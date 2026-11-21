import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/features/cane/data/mock_cane_service.dart';

void main() {
  test('The mock grips, walks, pauses and releases without UI commands', () {
    fakeAsync((clock) {
      final cane = MockCaneService(seed: 42);
      final grips = <bool>[];
      final steps = <int>[];
      final speeds = <double>[];
      final cadences = <double>[];
      var gripped = false;
      var sawMotion = false;
      var sawPause = false;
      var resumed = false;
      cane.gripState.listen((value) => grips.add(gripped = value));
      cane.steps.listen(steps.add);
      cane.estimatedSpeed.listen(speeds.add);
      cane.cadence.listen((value) {
        cadences.add(value);
        if (gripped && value > 0) {
          sawMotion = true;
          if (sawPause) resumed = true;
        } else if (gripped && sawMotion) {
          sawPause = true;
        }
      });

      cane.connect();
      clock.elapse(const Duration(minutes: 5));
      expect(grips.take(3), [false, true, false]);
      expect(resumed, isTrue);
      expect(steps.last, greaterThan(20));
      expect(steps, orderedEquals([...steps]..sort()));
      expect(speeds.length, cadences.length);
      for (var i = 0; i < speeds.length; i++) {
        expect(
          speeds[i],
          closeTo(cadences[i] * cane.strideLengthMetres / 60, 1e-9),
        );
      }
      cane.sendVibration();
      cane.disconnect();
      clock.flushMicrotasks();
      final count = steps.length;
      clock.elapse(const Duration(seconds: 10));
      expect(steps.length, count);
      cane.dispose();
      clock.flushMicrotasks();
      expect(clock.periodicTimerCount, 0);
    });
  });
}
