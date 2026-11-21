import 'dart:async';
import 'dart:math';

import '../domain/cane_service.dart';

enum _Phase { resting, holding, moving, paused }

/// Simulates the firmware, independently of any route or user interaction.
/// A sample advances one simulated second; tests can shorten [sampleInterval].
class MockCaneService implements CaneService {
  MockCaneService({
    int? seed,
    this.sampleInterval = const Duration(seconds: 1),
    this.strideLengthMetres = 0.57,
    DateTime? recoveryStart,
    DateTime Function()? now,
  }) : _random = Random(seed),
       _now = now ?? DateTime.now,
       _recoveryStart = recoveryStart ?? (now ?? DateTime.now)();

  final Duration sampleInterval;
  final double strideLengthMetres;
  final Random _random;
  final DateTime Function() _now;
  final DateTime _recoveryStart;
  final _grip = StreamController<bool>.broadcast();
  final _load = StreamController<double>.broadcast();
  final _steps = StreamController<int>.broadcast();
  final _cadence = StreamController<double>.broadcast();
  final _speed = StreamController<double>.broadcast();
  final _gait = StreamController<double>.broadcast();
  final _fall = StreamController<DateTime>.broadcast();
  final _battery = StreamController<int>.broadcast();

  Timer? _timer;
  bool _disposed = false;
  var _phase = _Phase.resting;
  int _remaining = 0;
  int _walkSeconds = 0;
  int _totalSteps = 0;
  int _ticks = 0;
  double _fractionalSteps = 0;
  int _charge = 93;
  double _walkCadence = 0;
  double _walkLoad = 0;

  @override
  Stream<bool> get gripState => _grip.stream;
  @override
  Stream<double> get tipLoad => _load.stream;
  @override
  Stream<int> get steps => _steps.stream;
  @override
  Stream<double> get cadence => _cadence.stream;
  @override
  Stream<double> get estimatedSpeed => _speed.stream;
  @override
  Stream<double> get gait => _gait.stream;
  @override
  Stream<DateTime> get fall => _fall.stream;
  @override
  Stream<int> get battery => _battery.stream;

  @override
  Future<void> connect() async {
    if (_disposed) throw StateError('Cane service has been disposed.');
    if (_timer != null) return;
    _phase = _Phase.resting;
    _remaining = 3 + _random.nextInt(5);
    _grip.add(false);
    _battery.add(_charge);
    _emitReadings();
    _timer = Timer.periodic(sampleInterval, (_) => _tick());
  }

  void _tick() {
    _ticks++;
    if (--_remaining <= 0) _advance();
    if (_phase == _Phase.moving) {
      _walkSeconds--;
      if (_walkSeconds <= 0) {
        _rest();
      } else if (_random.nextDouble() < 0.00018) {
        _fall.add(_now().toUtc());
        _rest();
      }
    }
    _emitReadings();
    if (_ticks % 600 == 0 && _charge > 0) {
      _battery.add(--_charge);
      if (_charge == 0) unawaited(disconnect());
    }
  }

  void _advance() {
    switch (_phase) {
      case _Phase.resting:
        final elapsedDays = max(0, _now().difference(_recoveryStart).inDays);
        final progress = min(elapsedDays / 56, 1.0);
        // A stable daily setback with independent, smaller variation per walk.
        final badDay = Random(elapsedDays + 37).nextDouble() < 0.18;
        _walkCadence =
            62 + 27 * progress - (badDay ? 9 : 0) + _random.nextDouble() * 5;
        _walkLoad = 125 - 52 * progress + (badDay ? 18 : 0);
        _walkSeconds = 55 + _random.nextInt(180);
        _fractionalSteps = 0;
        _grip.add(true);
        _phase = _Phase.holding;
        _remaining = 2;
      case _Phase.holding:
      case _Phase.paused:
        _phase = _Phase.moving;
        _remaining = 18 + _random.nextInt(40);
      case _Phase.moving:
        _phase = _Phase.paused;
        _remaining = 3 + _random.nextInt(8);
    }
  }

  void _rest() {
    _phase = _Phase.resting;
    _remaining = 50 + _random.nextInt(160);
    _grip.add(false);
  }

  void _emitReadings() {
    final moving = _phase == _Phase.moving;
    final cadence = moving ? _walkCadence + _random.nextDouble() * 6 - 3 : 0.0;
    _fractionalSteps += cadence / 60;
    final increment = _fractionalSteps.floor();
    _fractionalSteps -= increment;
    _totalSteps += increment;
    final bearingLoad = moving || _phase == _Phase.holding;
    _load.add(
      bearingLoad ? _walkLoad * (0.82 + 0.35 * _random.nextDouble()) : 0,
    );
    _steps.add(_totalSteps);
    _cadence.add(cadence);
    _speed.add(cadence * strideLengthMetres / 60);
    if (moving) _gait.add(0.76 + _random.nextDouble() * 0.17);
  }

  @override
  Future<void> sendVibration() async {
    if (_timer == null) throw StateError('Cane is disconnected.');
    // The mock acknowledges the command without operating a physical motor.
  }

  @override
  Future<void> disconnect() async {
    if (_timer == null) return;
    _timer!.cancel();
    _timer = null;
    _rest();
    _emitReadings();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await disconnect();
    await Future.wait([
      _grip.close(),
      _load.close(),
      _steps.close(),
      _cadence.close(),
      _speed.close(),
      _gait.close(),
      _fall.close(),
      _battery.close(),
    ]);
  }
}
