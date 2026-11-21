import 'dart:async';

import 'package:drift/drift.dart' show Value, InsertMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/care_database.dart';
import '../profile/profile.dart';
import '../cane/application/cane_provider.dart';

enum FallStage { countdown, firstContact, secondContact }

FallStage fallStage(Duration age) => age.inSeconds < 30
    ? FallStage.countdown
    : age.inSeconds < 150
    ? FallStage.firstContact
    : FallStage.secondContact;
final unresolvedFallProvider = StreamProvider<FallEvent?>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.fallEvents)
        ..where((row) => row.acknowledgedAt.isNull())
        ..limit(1))
      .watchSingleOrNull();
});
final fallMonitorProvider = Provider<void>((ref) {
  final db = ref.watch(databaseProvider), cane = ref.watch(caneServiceProvider);
  final sub = cane.fall.listen((time) async {
    final user = ref.read(profileProvider).value;
    if (user == null) return;
    await db
        .into(db.fallEvents)
        .insert(
          FallEvent(
            id: '${user.id}-${time.microsecondsSinceEpoch}',
            userId: user.id,
            detectedAt: time,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  });
  ref.onDispose(sub.cancel);
});
final fallClockProvider = StreamProvider.autoDispose<DateTime>((ref) async* {
  yield DateTime.now();
  yield* Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});
Future<void> acknowledgeFall(CareDatabase db, FallEvent event) =>
    (db.update(db.fallEvents)..where((r) => r.id.equals(event.id))).write(
      FallEventsCompanion(acknowledgedAt: Value(DateTime.now())),
    );
