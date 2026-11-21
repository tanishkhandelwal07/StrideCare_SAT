import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/features/progress/sample_week.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'Published sample week agrees with report totals and includes its PDF',
    () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final week = await container.read(sampleWeekProvider.future);
      expect(week.length, 7);
      expect(week.last.steps, 306);
      expect(week.fold<int>(0, (sum, day) => sum + day.steps), 2190);
      expect(week.fold<double>(0, (sum, day) => sum + day.minutes), 35);
      final pdf = await rootBundle.load(
        'reports/StrideCare-week-2026-11-20.pdf',
      );
      expect(pdf.getUint32(0), 0x25504446);
    },
  );
}
