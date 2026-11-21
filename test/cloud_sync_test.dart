import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stridecare/features/cloud/repository.dart';
import 'package:stridecare/features/cloud/walk_sync.dart';
import 'package:stridecare/storage/care_database.dart';

class RecordingRemote extends Fake implements CareRepository {
  final documents = <String, int>{};
  bool failAfterWrite = true;
  int requests = 0;
  @override
  Future<void> send(String patient, WalkSession walk) async {
    requests++;
    documents['$patient/${walk.id}'] = walk.steps;
    if (failAfterWrite) throw StateError('Lost acknowledgement');
  }
}

void main() {
  test(
    'saved walks survive a lost acknowledgement and a sync restart',
    () async {
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
      final at = DateTime(2026, 11, 19, 10);
      final w = WalkSession(
        id: 'session-1',
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
      await db.into(db.walkSessions).insert(w);
      final remote = RecordingRemote();
      await expectLater(
        WalkSync(db, remote, 'patient').flush(),
        throwsStateError,
      );
      expect(await db.preference('sent_walk/session-1'), isNull);
      remote.failAfterWrite = false;
      final retry = WalkSync(db, remote, 'patient');
      await Future.wait([retry.flush(), retry.flush()]);
      await retry.flush();
      expect(remote.requests, 2);
      expect(remote.documents, {'patient/session-1': 120});
      expect(await db.preference('sent_walk/session-1'), '1');
    },
  );
}
