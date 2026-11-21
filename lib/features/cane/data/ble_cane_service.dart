import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../domain/cane_service.dart';
import 'ble_config.dart';
import 'live_packet.dart';

/// The OS owns the bond prompt when reading the encrypted info characteristic.
class BleCaneService implements CaneService {
  BleCaneService({FlutterReactiveBle? client, this.stepLengthMetres = 0.57})
    : _client = client ?? FlutterReactiveBle();
  final FlutterReactiveBle _client;
  final double stepLengthMetres;
  final parser = LivePacketParser();
  final _live = StreamController<LivePacket>.broadcast();
  final _steps = StreamController<int>.broadcast();
  final _fall = StreamController<DateTime>.broadcast();
  final _battery = StreamController<int>.broadcast();
  final _states = StreamController<DeviceConnectionState>.broadcast();
  Stream<DeviceConnectionState> get connectionStates => _states.stream;
  final _subscriptions = <StreamSubscription<dynamic>>[];
  StreamSubscription<ConnectionStateUpdate>? _connection;
  String? selectedDevice, serial;
  int? calibrationId;
  int? _lastSteps;
  int _stepsTotal = 0, _generation = 0;
  Future<void>? _connecting;
  bool _closed = false;
  Timer? _retry;
  int _attempt = 0;
  final _seenFalls = <String>{};
  Stream<DiscoveredDevice> discover() =>
      _client.scanForDevices(withServices: [Uuid.parse(CaneGatt.service)]);
  QualifiedCharacteristic _char(
    String characteristic, {
    String service = CaneGatt.service,
  }) => QualifiedCharacteristic(
    deviceId: selectedDevice!,
    serviceId: Uuid.parse(service),
    characteristicId: Uuid.parse(characteristic),
  );
  @override
  Future<void> connect() {
    if (_closed) return Future.error(StateError('disposed'));
    if (selectedDevice == null) {
      return Future.error(StateError('Select a discovered cane first'));
    }
    return _connecting ??= _open(++_generation)
        .whenComplete(() => _connecting = null);
  }

  Future<void> _open(int generation) async {
    final ready = Completer<void>();
    void failed(Object error) {
      if (generation != _generation || _closed) return;
      _generation++;
      _states.add(DeviceConnectionState.disconnected);
      if (!ready.isCompleted) ready.completeError(error);
      unawaited(_recover(_generation));
    }

    _connection = _client
        .connectToDevice(
          id: selectedDevice!,
          connectionTimeout: const Duration(seconds: 12),
        )
        .listen(
          (update) async {
            if (generation != _generation) return;
            if (update.connectionState == DeviceConnectionState.disconnected) {
              failed(StateError('connection lost'));
              return;
            }
            if (update.connectionState != DeviceConnectionState.connected) {
              _states.add(update.connectionState);
              return;
            }
            try {
              final info = await _client.readCharacteristic(
                _char(CaneGatt.info),
              );
              if (generation != _generation) return;
              if (info.length != 18 ||
                  info[0] != 1 ||
                  info[17] != 0 ||
                  info.sublist(5, 13).any((v) => v < 32 || v > 126)) {
                throw FormatException('Unsupported device info');
              }
              serial = String.fromCharCodes(info.sublist(5, 13));
              calibrationId = ByteData.sublistView(Uint8List.fromList(info))
                  .getUint32(13, Endian.little);
              _lastSteps = null;
              void sub(
                QualifiedCharacteristic c,
                void Function(List<int>) read,
              ) {
                _subscriptions.add(
                  _client.subscribeToCharacteristic(c).listen((b) {
                    if (generation == _generation) read(b);
                  }, onError: failed),
                );
              }

              sub(_char(CaneGatt.telemetry), (bytes) {
                final p = parser.parse(bytes);
                if (p == null) return;
                final last = _lastSteps;
                if (last != null) _stepsTotal += (p.steps - last) & 0xffff;
                _lastSteps = p.steps;
                _live.add(p);
                _steps.add(_stepsTotal);
              });
              sub(_char(CaneGatt.fall), (bytes) {
                if (bytes.length != 8) return;
                if (_seenFalls.add('$serial/${bytes.join(",")}')) {
                  _fall.add(DateTime.now().toUtc());
                }
              });
              final batteryChar = _char('2a19', service: '180f');
              void batterySample(List<int> b) {
                if (b.length == 1 && b.first <= 100) _battery.add(b.first);
              }

              sub(batteryChar, batterySample);
              final b = await _client.readCharacteristic(batteryChar);
              if (generation != _generation) return;
              batterySample(b);
              _attempt = 0;
              _states.add(DeviceConnectionState.connected);
              if (!ready.isCompleted) ready.complete();
            } catch (e) {
              failed(e);
            }
          },
          onError: failed,
          onDone: () => failed(StateError('connection closed')),
        );
    try {
      await ready.future.timeout(const Duration(seconds: 20));
    } on TimeoutException catch (e) {
      failed(e);
      rethrow;
    }
  }

  Future<void> _clear() async {
    final subscriptions = [..._subscriptions, ?_connection];
    _subscriptions.clear();
    _connection = null;
    await Future.wait(subscriptions.map((s) => s.cancel()));
  }

  Future<void> _recover(int generation) async {
    await _clear();
    if (generation != _generation || _closed) return;
    _retry = Timer(Duration(seconds: 1 << (_attempt++).clamp(0, 5)), () {
      if (generation == _generation) {
        unawaited(connect().catchError((Object _) {}));
      }
    });
  }

  @override
  Future<void> disconnect() async {
    _generation++;
    _retry?.cancel();
    await _clear();
    if (!_closed) _states.add(DeviceConnectionState.disconnected);
  }

  @override
  Stream<bool> get gripState =>
      _live.stream.map((p) => (p.flags & 1) != 0).distinct();
  @override
  Stream<double> get tipLoad => _live.stream.map((p) => p.loadTenths / 10);
  @override
  Stream<int> get steps => _steps.stream;
  @override
  Stream<double> get cadence => _live.stream.map((p) => p.cadence.toDouble());
  @override
  Stream<double> get estimatedSpeed =>
      _live.stream.map((p) => p.cadence * stepLengthMetres / 60);
  @override
  Stream<double> get gait => _live.stream.map((p) => p.gait / 100);
  @override
  Stream<DateTime> get fall => _fall.stream;
  @override
  Stream<int> get battery => _battery.stream;
  @override
  Future<void> sendVibration() => _client.writeCharacteristicWithoutResponse(
    _char(CaneGatt.vibration),
    value: [1, 40],
  );
  @override
  Future<void> dispose() async {
    _closed = true;
    await disconnect();
    await Future.wait([
      _live.close(),
      _steps.close(),
      _fall.close(),
      _battery.close(),
      _states.close(),
    ]);
  }
}
