import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/features/cane/application/cane_provider.dart';
import 'package:stridecare/features/cane/data/mock_cane_service.dart';
import 'package:stridecare/features/profile/profile.dart';
import 'package:stridecare/features/walk/walk_controller.dart';
import 'package:stridecare/storage/care_database.dart';

void main() {
  test(
    'practice telemetry opens and saves a walk without a walk command',
    () async {
      final db = CareDatabase(NativeDatabase.memory());
      await db.transaction(() async {
        await db.customStatement(
          "INSERT INTO users (id,name,height_cm,age,locale) VALUES(1,'Test',170,60,'en')",
        );
        for (final n in [1, 2]) {
          await db.customStatement(
            "INSERT INTO emergency_contacts VALUES(1,?,'Contact',?,'Family')",
            [n, '+91990000000$n'],
          );
        }
      });
      final mock = MockCaneService(
        seed: 3,
        sampleInterval: const Duration(milliseconds: 4),
      );
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          caneServiceProvider.overrideWithValue(mock),
        ],
      );
      addTearDown(() async {
        container.dispose();
        await mock.dispose();
        await db.close();
      });
      container.listen(profileProvider, (_, _) {});
      await container.read(profileProvider.future).timeout(const Duration(seconds: 3));
      final model = container.read(walkProvider.notifier);
      final saved = db
          .select(db.walkSessions)
          .watch()
          .firstWhere((rows) => rows.isNotEmpty);
      bool liveSeen = false;
      container.listen(
        walkProvider,
        (_, _) => liveSeen |= model.detector.active != null,
      );
      await model.toggle();
      final walk = (await saved.timeout(const Duration(seconds: 5))).single;
      expect(liveSeen, isTrue);
      expect(walk.steps, greaterThanOrEqualTo(3));
      expect(walk.distanceM, closeTo(walk.steps * 170 * 0.00415, 0.001));
      expect(model.summary?.id, walk.id);
      await model.toggle();
    },
  );
}
