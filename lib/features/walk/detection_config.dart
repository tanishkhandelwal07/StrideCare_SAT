abstract final class DetectionConfig {
  static const minimumLoadN = 5.0;
  static const startSteps = 3;
  static const startWindow = Duration(seconds: 5);
  static const idleWindow = Duration(seconds: 30);
  static const heightToStepLength = 0.00415; // cm of height to metres per step
}
