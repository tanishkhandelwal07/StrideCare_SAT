/// All streams are broadcast. Subscribe before connecting for initial values.
/// Disconnect stops telemetry; reconnecting resumes with the same device counter.
abstract class CaneService {
  Future<void> connect();
  Future<void> disconnect();
  Stream<bool> get gripState;

  /// Cane tip load in newtons.
  Stream<double> get tipLoad;

  /// Cumulative step count, monotonically increasing for this device.
  Stream<int> get steps;

  /// Steps per minute.
  Stream<double> get cadence;

  /// Estimated metres per second.
  Stream<double> get estimatedSpeed;

  /// Rhythm regularity in the range 0 (irregular) to 1 (regular).
  Stream<double> get gait;
  Stream<DateTime> get fall;

  /// Charge remaining, as a percentage from 0 to 100.
  Stream<int> get battery;
  Future<void> sendVibration();
  Future<void> dispose();
}
