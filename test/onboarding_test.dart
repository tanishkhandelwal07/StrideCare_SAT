import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:stridecare/features/profile/profile.dart';
import 'package:stridecare/l10n/generated/app_localizations.dart';
import 'package:stridecare/storage/care_database.dart';

void main() {
  testWidgets('profile requires two different contact numbers before commit', (
    t,
  ) async {
    final db = CareDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    t.view.devicePixelRatio = 1;
    t.view.physicalSize = const Size(800, 1200);
    addTearDown(t.view.resetPhysicalSize);
    addTearDown(t.view.resetDevicePixelRatio);
    await t.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          home: const Onboarding(),
        ),
      ),
    );
    await t.pumpAndSettle();
    Future<void> tapText(String label) async {
      final item = find.text(label).last;
      await t.ensureVisible(item);
      await t.tap(item);
      await t.pumpAndSettle();
    }

    Future<void> enter(int i, String text) =>
        t.enterText(find.byType(TextFormField).at(i), text);
    await tapText('Continue');
    await enter(0, 'Test');
    await tapText('Continue');
    await enter(0, '160');
    await enter(1, '65');
    await tapText('Continue');
    await tapText('Hip fracture');
    await tapText('Continue');
    await tapText('Date of injury or surgery');
    await tapText('OK');
    await tapText('Continue');
    await tapText('Left');
    await tapText('Continue');
    await tapText('Continue');
    expect(find.text('Please fill in this field.'), findsWidgets);
    await enter(0, 'First');
    await enter(1, '+919800000001');
    await enter(2, 'Family');
    await tapText('Continue');
    await enter(0, 'Second');
    await enter(1, '+91 9800000001');
    await enter(2, 'Friend');
    await tapText('Continue');
    expect(
      find.text('Use a different number for the second person.'),
      findsOneWidget,
    );
    await enter(1, '+919800000002');
    await tapText('Continue');
    await tapText('Save profile');
    await t.runAsync(() async {
      expect((await db.select(db.emergencyContacts).get()).length, 2);
      expect((await db.select(db.users).getSingle()).name, 'Test');
    });
  });
}
