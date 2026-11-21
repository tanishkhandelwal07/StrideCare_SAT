import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/features/walk/walk_session_detector.dart';

void main() {
  late WalkSessionDetector d;
  final epoch = DateTime.utc(2026);
  WalkRecord? tick(int sec, int steps, {bool grip = true, double load = 50}) =>
      d.sample(
        epoch.add(Duration(seconds: sec)),
        grip: grip,
        load: load,
        counter: steps,
        cadence: 60,
        gait: 0.9,
      );
  setUp(() => d = WalkSessionDetector());
  test('requires simultaneous grip, load and three recent steps', () {
    tick(0, 100);
    tick(1, 101, grip: false);
    tick(2, 104, load: 0);
    tick(3, 105);
    tick(9, 106);
    tick(10, 107);
    expect(d.active, isNull);
    tick(11, 108);
    expect(d.active!.steps, 3);
  });
  test('counts qualifying steps, keeps pauses and finishes on release', () {
    tick(0, 0);
    tick(3, 3);
    tick(20, 3, load: 0);
    tick(22, 5);
    expect(d.active!.steps, 5);
    expect(tick(24, 5, grip: false)!.steps, 5);
    expect(d.active, isNull);
    expect(tick(25, 5, grip: false), isNull);
  });
  test('thirty seconds without steps or load ends at last activity', () {
    tick(0, 0);
    tick(3, 3);
    tick(15, 3);
    tick(44, 3, load: 0);
    expect(d.active, isNotNull);
    expect(tick(45, 3, load: 0)!.end, epoch.add(const Duration(seconds: 15)));
  });
  test('pace converts steps per minute and metres per step to m/s', () {
    expect(estimatedPace(90, 0.6), 0.9);
    expect(estimatedPace(0, 0.6), 0);
  });
}
