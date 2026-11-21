// Run explicitly on Chrome against the seeded loopback emulators.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:stridecare/features/cloud/repository.dart';
import 'package:stridecare/features/clinic/targets.dart';
import 'package:stridecare/storage/care_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FirebaseCoreWeb.registerWith(webPluginRegistrar);
  FirebaseAuthWeb.registerWith(webPluginRegistrar);
  FirebaseFirestoreWeb.registerWith(webPluginRegistrar);
  test(
    'Flutter repositories sync a patient walk and return the assigned plan',
    () async {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          projectId: 'demo-stridecare',
          apiKey: 'demo-key',
          appId: '1:123456789:web:abcdef',
          messagingSenderId: '123456789',
        ),
      );
      await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
      FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
      final accounts = FirebaseAccounts(), care = FirestoreCare();
      const password = 'StrideCare-practice-2026';
      await accounts.signIn('patient@example.test', password);
      final pid = FirebaseAuth.instance.currentUser!.uid;
      final start = DateTime.utc(2026, 11, 19, 10);
      await care.send(
        pid,
        WalkSession(
          id: 'flutter-workflow',
          userId: 1,
          startedAt: start,
          endedAt: start.add(const Duration(minutes: 1)),
          steps: 60,
          avgLoad: 95,
          peakLoad: 108,
          avgSpeed: 0.5,
          peakSpeed: 0.6,
          cadence: 60,
          strideLengthM: 0.5,
          distanceM: 30,
          gaitRegularity: 0.9,
        ),
      );
      await accounts.signOut();
      await accounts.signIn('physio@example.test', password);
      expect(
        (await care.assigned(FirebaseAuth.instance.currentUser!.uid).first).any(
          (p) => p.id == pid,
        ),
        isTrue,
      );
      expect(
        (await care.recent(pid).first).any(
          (w) => w.started == start.toLocal() && w.steps == 60,
        ),
        isTrue,
      );
      final original = await care.targets(pid).first;
      try {
        await care.saveTargets(pid, const CareTargets(maxSpeed: 0.76));
        await accounts.signOut();
        await accounts.signIn('patient@example.test', password);
        expect((await care.targets(pid).first).maxSpeed, 0.76);
      } finally {
        await accounts.signOut();
        await accounts.signIn('physio@example.test', password);
        await care.saveTargets(pid, original);
        await accounts.signOut();
      }
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
