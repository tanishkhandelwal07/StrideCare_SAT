import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../storage/care_database.dart';
import '../clinic/targets.dart';

abstract interface class AccountRepository {
  Stream<String?> get signedInUid;
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}

class FirebaseAccounts implements AccountRepository {
  final _auth = auth.FirebaseAuth.instance;
  @override
  Stream<String?> get signedInUid =>
      _auth.authStateChanges().map((u) => u?.uid);
  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() => _auth.signOut();
}

typedef Assignment = ({String id, String name});
typedef SharedWalk = ({DateTime started, int steps, double pace, double load});

abstract interface class CareRepository {
  Stream<String?> role(String uid);
  Stream<List<Assignment>> assigned(String uid);
  Stream<List<SharedWalk>> recent(String patient);
  Future<void> send(String patient, WalkSession walk);
  Stream<CareTargets> targets(String patient);
  Future<void> saveTargets(String patient, CareTargets value);
}

class FirestoreCare implements CareRepository {
  final _db = FirebaseFirestore.instance;
  DocumentReference<Map<String, dynamic>> _patient(String id) =>
      _db.collection('patients').doc(id);
  @override
  Stream<String?> role(String uid) => _db
      .collection('accounts')
      .doc(uid)
      .snapshots()
      .map((d) => d.data()?['role'] as String?);
  @override
  Stream<List<Assignment>> assigned(String uid) => _db
      .collection('clinicians')
      .doc(uid)
      .collection('patients')
      .orderBy('name')
      .snapshots()
      .map(
        (q) => [for (final d in q.docs) (id: d.id, name: d['name'] as String)],
      );
  @override
  Stream<List<SharedWalk>> recent(String patient) =>
      _patient(patient)
          .collection('walks')
          .orderBy('startMs', descending: true)
          .limit(30)
          .snapshots()
          .map(
            (q) => [
              for (final d in q.docs)
                (
                  started: DateTime.fromMillisecondsSinceEpoch(d['startMs']),
                  steps: d['steps'] as int,
                  pace: (d['avgSpeed'] as num).toDouble(),
                  load: (d['avgLoad'] as num).toDouble(),
                ),
            ],
          );
  @override
  Future<void> send(String patient, WalkSession w) =>
      _patient(patient).collection('walks').doc(w.id).set({
        'startMs': w.startedAt.millisecondsSinceEpoch,
        'endMs': w.endedAt.millisecondsSinceEpoch,
        'steps': w.steps,
        'avgSpeed': w.avgSpeed,
        'distanceM': w.distanceM,
        'cadence': w.cadence,
        'avgLoad': w.avgLoad,
      });
  @override
  Stream<CareTargets> targets(String patient) =>
      _patient(patient)
          .collection('plan')
          .doc('current')
          .snapshots()
          .map((d) => CareTargets.fromMap(d.data() ?? {}));
  @override
  Future<void> saveTargets(String patient, CareTargets value) =>
      _patient(patient).collection('plan').doc('current').set(value.toMap());
}
