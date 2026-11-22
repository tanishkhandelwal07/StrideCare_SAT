import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/app/stridecare_app.dart';
import 'package:stridecare/l10n/generated/app_localizations.dart';

import 'package:stridecare/features/profile/profile.dart';
import 'package:stridecare/features/safety/practice_fall.dart';
import 'package:stridecare/features/progress/daily_metrics.dart';
import 'package:drift/native.dart';
import 'package:stridecare/features/settings/presentation/settings_page.dart';
import 'package:stridecare/features/walk/walk_controller.dart';
import 'package:stridecare/features/medicine/presentation/medicine_page.dart';
import 'package:stridecare/features/wellness/presentation/wellness_page.dart';
import 'package:stridecare/storage/care_database.dart';

void main() {
  testWidgets(
    'Five labelled destinations navigate at normal and large text sizes',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 720);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);
      final dispatcher = tester.platformDispatcher;
      addTearDown(dispatcher.clearTextScaleFactorTestValue);

      final db = CareDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      for (final locale in AppLocalizations.supportedLocales) {
        for (final scale in [1.0, 2.0]) {
          dispatcher.textScaleFactorTestValue = scale;
          await tester.pumpWidget(
            ProviderScope(
              key: ValueKey('${locale.languageCode}-$scale'),
              overrides: [
                databaseProvider.overrideWithValue(db),
                unresolvedFallProvider.overrideWith((_) => Stream.value(null)),
                metricsProvider.overrideWith((_) => Stream.value([])),
                profileProvider.overrideWith(
                  (_) => Stream.value(
                    User(
                      id: 1,
                      name: 'Test',
                      heightCm: 161,
                      age: 62,
                      locale: locale.languageCode,
                      firstSlot: 1,
                      secondSlot: 2,
                    ),
                  ),
                ),
                walksProvider.overrideWith((_) => Stream.value([])),
                medicationProvider.overrideWith((_) => Stream.value([])),
                mealProvider.overrideWith((_, _) async => false),
                sizeProvider.overrideWith((_) async => 1.0),
              ],
              child: StrideCareApp(locale: locale),
            ),
          );
          await tester.pumpAndSettle();
          final strings = await AppLocalizations.delegate.load(locale);
          final labels = [
            strings.today,
            strings.progress,
            strings.wellness,
            strings.medicine,
            strings.settings,
          ];
          if (locale.languageCode == 'en') {
            expect(labels, [
              'Today',
              'Progress',
              'Wellness',
              'Medicine',
              'Settings',
            ]);
          }
          final messages = [
            strings.todayHint,
            strings.weeklyWalks,
            strings.wellnessHint,
            strings.medicineHint,
            strings.settingsHint,
          ];
          for (final label in labels) {
            expect(find.widgetWithText(InkWell, label), findsOneWidget);
          }
          for (var i = 0; i < labels.length; i++) {
            final destination = find.widgetWithText(InkWell, labels[i]);
            final size = tester.getSize(destination);
            expect(size.shortestSide, greaterThanOrEqualTo(56));
            await tester.tap(destination);
            await tester.pumpAndSettle();
            expect(find.text(messages[i]), findsOneWidget);
            if (labels[i] == strings.progress) {
              expect(find.text(strings.exampleReport), findsOneWidget);
              expect(find.text(strings.report), findsNothing);
            }
            if (labels[i] == strings.wellness) {
              final cuisine = find.text(strings.mediterranean);
              await Scrollable.ensureVisible(
                tester.element(cuisine),
                alignment: 0.3,
              );
              await tester.pumpAndSettle();
              await tester.tap(cuisine);
              await tester.pumpAndSettle();
              expect(find.text(strings.beans), findsOneWidget);
              expect(find.text(strings.chicken), findsOneWidget);
              expect(find.text(strings.recipe), findsNothing);
              expect(find.text(strings.wellnessAdvice), findsOneWidget);
            }
            expect(tester.takeException(), isNull);
          }
        }
      }
    },
  );
}
