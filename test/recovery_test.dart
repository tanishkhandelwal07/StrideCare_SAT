import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/storage/care_database.dart';
import 'package:stridecare/features/progress/daily_metrics.dart';
import 'package:stridecare/features/progress/recovery_score.dart';
import 'package:stridecare/features/progress/weekly_report.dart';
import 'package:stridecare/features/safety/practice_fall.dart';
import 'package:stridecare/l10n/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('two ordered escalation stages after a 10-second countdown', () {
    expect(fallStage(const Duration(seconds: 9)), FallStage.countdown);
    expect(fallStage(const Duration(seconds: 10)), FallStage.firstContact);
    expect(fallStage(const Duration(seconds: 129)), FallStage.firstContact);
    expect(fallStage(const Duration(seconds: 130)), FallStage.secondContact);
  });
  test('saved walks aggregate once and produce a weekly PDF', () async {
    final db = CareDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await db.transaction(() async {
      await db.customStatement(
        "INSERT INTO users(id,name,height_cm,age,locale) VALUES(1,'Test',160,62,'en')",
      );
      for (final n in [1, 2]) {
        await db.customStatement(
          "INSERT INTO emergency_contacts VALUES(1,?,'Contact',?,'Family')",
          [n, '+91990000000$n'],
        );
      }
    });
    final today = DateTime(2026, 11, 21, 10);
    WalkSession session(DateTime at) => WalkSession(
      id: at.toString(),
      userId: 1,
      startedAt: at,
      endedAt: at.add(const Duration(minutes: 2)),
      steps: 120,
      avgLoad: 100,
      peakLoad: 110,
      avgSpeed: 0.6,
      peakSpeed: 0.8,
      cadence: 60,
      strideLengthM: 0.6,
      distanceM: 72,
      gaitRegularity: 0.85,
    );
    final first = session(today.subtract(const Duration(days: 1)));
    await saveWalk(db, first);
    await saveWalk(db, first);
    await saveWalk(db, session(today));
    final days = await db.select(db.dailyMetrics).get();
    expect(days.length, 2);
    expect(days.first.steps, 120);
    expect(days.first.avgSpeed, closeTo(0.6, 0.001));
    expect(recoveryScore(days.first, null), isNull);
    expect(recoveryScore(days.last, days.first), 70);
    expect(slowerDay(days.last, days.first), isFalse);
    expect(slowerDay(days.last.copyWith(avgSpeed: 0.3), days.first), isTrue);
    final bytes = await weeklyReport(
      db,
      await AppLocalizations.delegate.load(const Locale('en')),
      await db.select(db.users).getSingle(),
      today,
    );
    expect(String.fromCharCodes(bytes.take(4)), '%PDF');
  });
}
