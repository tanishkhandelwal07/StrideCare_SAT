import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/storage/care_database.dart';

void main() {
  test(
    'A committed profile requires exactly two distinct, ordered contacts',
    () async {
      final db = CareDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      Future<void> profile(List<String> phones) => db.transaction(() async {
        await db.customStatement(
          "INSERT INTO users (id, name, height_cm, age, locale) VALUES (1, 'Test', 162, 68, 'pa')",
        );
        for (var i = 0; i < phones.length; i++) {
          await db.customStatement(
            "INSERT INTO emergency_contacts VALUES (1, ?, 'Test contact', ?, 'Family')",
            [i + 1, phones[i]],
          );
        }
      });

      const first = '+919800000001';
      const second = '+919800000002';
      for (final invalid in <List<String>>[
        [],
        [first],
        [first, first],
        [first, second, '+919800000003'],
      ]) {
        await expectLater(profile(invalid), throwsA(anything));
        expect(await db.select(db.users).get(), isEmpty);
      }
      await profile([first, second]);
      final contacts = await db
          .customSelect(
            'SELECT phone_e164 FROM emergency_contacts ORDER BY position',
          )
          .get();
      expect(contacts.map((row) => row.read<String>('phone_e164')), [
        first,
        second,
      ]);
      await expectLater(
        db.customStatement('DELETE FROM emergency_contacts WHERE position = 1'),
        throwsA(anything),
      );
      expect(db.allTables.length, 13);
    },
  );
}
