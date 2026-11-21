import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/care_database.dart';
import 'recovery_score.dart';

String dayKey(DateTime date) =>
    date.toLocal().toIso8601String().substring(0, 10);
final metricsProvider = StreamProvider<List<DailyMetric>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(
    db.dailyMetrics,
  )..orderBy([(row) => OrderingTerm.desc(row.day)])).watch();
});
Future<void> saveWalk(CareDatabase db, WalkSession session) =>
    db.transaction(() async {
      final start = session.startedAt;
      final day = DateTime(start.year, start.month, start.day),
          end = DateTime(start.year, start.month, start.day + 1);
      await db.into(db.walkSessions).insertOnConflictUpdate(session);
      final rows =
          await (db.select(db.walkSessions)..where(
                (r) =>
                    r.userId.equals(session.userId) &
                    r.startedAt.isBiggerOrEqualValue(day) &
                    r.startedAt.isSmallerThanValue(end),
              ))
              .get();
      final steps = rows.fold(0, (n, w) => n + w.steps);
      final seconds = rows.fold(
        0.0,
        (n, w) => n + w.endedAt.difference(w.startedAt).inMilliseconds / 1000,
      );
      final distance = rows.fold(0.0, (n, w) => n + w.distanceM);
      double weighted(double Function(WalkSession) read) =>
          rows.fold(0.0, (n, w) => n + w.steps * read(w)) / steps;
      final metric = DailyMetric(
        userId: session.userId,
        day: dayKey(day),
        steps: steps,
        walkMinutes: seconds / 60,
        avgLoad: weighted((w) => w.avgLoad),
        peakLoad: rows.map((w) => w.peakLoad).reduce(max),
        avgSpeed: seconds > 0 ? distance / seconds : 0,
        peakSpeed: rows.map((w) => w.peakSpeed).reduce(max),
        cadence: seconds > 0 ? 60 * steps / seconds : 0,
        strideLengthM: distance / steps,
        distanceM: distance,
        gaitRegularity: weighted((w) => w.gaitRegularity),
      );
      await db.into(db.dailyMetrics).insertOnConflictUpdate(metric);
      final previous =
          await (db.select(db.dailyMetrics)
                ..where(
                  (r) =>
                      r.userId.equals(session.userId) &
                      r.day.isSmallerThanValue(metric.day),
                )
                ..orderBy([(r) => OrderingTerm.desc(r.day)])
                ..limit(1))
              .getSingleOrNull();
      final score = recoveryScore(metric, previous);
      if (score != null) {
        await db
            .into(db.recoveryScores)
            .insertOnConflictUpdate(
              RecoveryScore(
                userId: session.userId,
                day: metric.day,
                score: score,
              ),
            );
      }
      if (steps >= 1000) {
        await db
            .into(db.milestones)
            .insert(
              Milestone(
                userId: session.userId,
                milestoneKey: 'first1000',
                achievedAt: session.endedAt,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    });
