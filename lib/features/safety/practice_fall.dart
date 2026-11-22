import 'dart:async';

import 'package:drift/drift.dart' show Value, InsertMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/care_database.dart';
import '../profile/profile.dart';
import '../cane/data/ble_cane_service.dart';
import '../cane/application/cane_provider.dart';

enum FallStage { countdown, firstContact, secondContact }

const fallCountdownSeconds = 10;
final sosSenderProvider = Provider<Future<void> Function(FallEvent)?>(
  (_) => null,
);
final liveSosProvider = Provider<bool>(
  (ref) =>
      ref.watch(sosSenderProvider) != null &&
      ref.watch(caneServiceProvider) is BleCaneService,
);

Future<void> recordFall(CareDatabase db, int uid, DateTime time) async {
  await db
      .into(db.fallEvents)
      .insert(
        FallEvent(
          id: '$uid-${time.microsecondsSinceEpoch}',
          userId: uid,
          detectedAt: time,
        ),
        mode: InsertMode.insertOrIgnore,
      );
}

FallStage fallStage(Duration age) => age.inSeconds < fallCountdownSeconds
    ? FallStage.countdown
    : age.inSeconds < fallCountdownSeconds + 120
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
    await recordFall(db, user.id, time);
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

// Only the real-cane, authenticated build may submit an SOS. Recheck
// acknowledgement before submitting when the screen resumes.
final sendSosProvider = FutureProvider.autoDispose.family<void, FallEvent>((
  ref,
  event,
) async {
  if (!ref.read(liveSosProvider)) return;
  final db = ref.read(databaseProvider);
  final row = await (db.select(
    db.fallEvents,
  )..where((r) => r.id.equals(event.id))).getSingle();
  final age = DateTime.now().difference(row.detectedAt);
  if (row.acknowledgedAt != null ||
      age.inSeconds < fallCountdownSeconds ||
      age.inMinutes >= 5) {
    return;
  }
  await ref.read(sosSenderProvider)!(event);
});
