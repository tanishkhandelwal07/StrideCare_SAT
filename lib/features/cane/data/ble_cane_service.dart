import '../domain/cane_service.dart';

/// Hardware contract scaffold. No OS permissions or scans during app startup.
class BleCaneService implements CaneService {
  @override
  Future<void> connect() =>
      Future.error(UnsupportedError('Firmware GATT contract pending.'));
  @override
  Future<void> sendVibration() =>
      Future.error(StateError('Cane is disconnected.'));
  @override
  Future<void> disconnect() async {}
  @override
  Future<void> dispose() => disconnect();
  @override
  Stream<bool> get gripState => const Stream.empty();
  @override
  Stream<double> get tipLoad => const Stream.empty();
  @override
  Stream<int> get steps => const Stream.empty();
  @override
  Stream<double> get cadence => const Stream.empty();
  @override
  Stream<double> get estimatedSpeed => const Stream.empty();
  @override
  Stream<double> get gait => const Stream.empty();
  @override
  Stream<DateTime> get fall => const Stream.empty();
  @override
  Stream<int> get battery => const Stream.empty();
}
