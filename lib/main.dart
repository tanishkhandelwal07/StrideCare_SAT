import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app/stridecare_app.dart';
import 'features/cloud/cloud_app.dart';
import 'features/cloud/repository.dart';

Future<void> main() async {
  const mode = String.fromEnvironment('CARE_BACKEND', defaultValue: 'offline');
  if (mode == 'offline' || (mode == 'emulator' && Uri.base.queryParameters['view'] != 'connected')) {
    runApp(const ProviderScope(child: StrideCareApp()));
    return;
  }
  WidgetsFlutterBinding.ensureInitialized();
  const emulator = mode == 'emulator';
  if (!emulator && mode != 'firebase') throw StateError('Unknown CARE_BACKEND');
  const project = emulator
      ? 'demo-stridecare'
      : String.fromEnvironment('FIREBASE_PROJECT_ID');
  const api = emulator
      ? 'demo-key'
      : String.fromEnvironment('FIREBASE_API_KEY');
  const appId = emulator
      ? '1:123456789:web:abcdef'
      : String.fromEnvironment('FIREBASE_APP_ID');
  const sender = emulator
      ? '123456789'
      : String.fromEnvironment('FIREBASE_SENDER_ID');
  if ([project, api, appId, sender].any((v) => v.isEmpty)) {
    throw StateError('Missing Firebase build configuration');
  }
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: api,
      projectId: project,
      appId: appId,
      messagingSenderId: sender,
    ),
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
  if (emulator) {
    const host = String.fromEnvironment(
      'EMULATOR_HOST',
      defaultValue: '127.0.0.1',
    );
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  }
  runApp(
    ProviderScope(
      child: CloudApp(
        accounts: FirebaseAccounts(),
        care: FirestoreCare(),
        project: project,
      ),
    ),
  );
}
