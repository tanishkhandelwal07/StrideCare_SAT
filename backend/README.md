# Patient and physio sync

The connected build signs in with Firebase email/password. The account document determines the home screen. Each patient has a local Drift database scoped to the Firebase project and UID. When the app is open, it scans for unsent walks every eight seconds. It records a local acknowledgement after Firestore confirms the write. Retries reuse the walk document ID. The physio sees the thirty most recent walk summaries for the selected assigned patient. The patient subscribes to plan changes and updates the active walk thresholds and the locally stored plan.

The synchronized fields are walk times, steps, estimated distance and pace, cadence and mean cane load. Contacts, medication entries, meal logs and falls stay local in this version. The offline practice build continues to use its original database.

## Run locally

Use the Flutter SDK from the project README, Chrome, a current Node installation, the Firebase CLI and a Java 21 runtime. Start from the project root. On the development Mac, the Flutter environment is available with `source /tmp/stridecare-env.sh`.

1. Start the emulators and keep the terminal open.

   ```sh
   firebase emulators:start --project demo-stridecare --only auth,firestore
   ```

2. In another terminal, seed the fictional accounts and seven dated walk records. This command also checks the access rules. Rerunning it restores the demo patient's target values.

   ```sh
   node backend/practice.mjs
   ```

3. Run the connected app in Chrome, or choose **StrideCare · Local Firebase** in VS Code.

   ```sh
   flutter pub get
   flutter run -d chrome --dart-define=CARE_BACKEND=emulator --web-port=8752
   ```

| Practice account | Sign-in email |
| --- | --- |
| Patient | patient@example.test |
| Assigned physio | physio@example.test |
| Unassigned physio | unassigned@example.test |

The emulator preview opens practice mode directly. Append `?view=connected` to open the authenticated workspace.

The shared emulator password is `StrideCare-practice-2026`. These accounts are confined to localhost. Use a separate browser profile or a private window for each concurrent sign-in. Sign in as the patient, complete onboarding with fictional details, pair the practice cane and let a walk finish. The new walk appears in the assigned physio's list. Change the maximum estimated pace in the physio view and open Settings in the patient view to see the updated target. The unassigned physio sees an empty patient list.

The synthetic dataset in `datasets/practice_walks_v1.json` has fixed timestamps in milliseconds since the Unix epoch. Distance is in metres, speed in metres per second, cadence in steps per minute and mean tip load in newtons. These samples exercise the software and have no clinical validation.

## Production configuration

Create a Firebase project, register the web app, enable email/password sign-in and create a Firestore database. Deploy the checked-in rules to the intended project before registering patients. Use trusted administrator tooling to provision accounts and assignments. The client has read-only access to its own role and its clinician assignments.

| Firestore path | Contents |
| --- | --- |
| `accounts/{authUid}` | A trusted administrator sets role to `patient` or `clinician`. |
| `clinicians/{clinicianUid}/patients/{patientUid}` | A trusted administrator assigns the patient and sets their display `name`. |
| `patients/{patientUid}/walks/{walkId}` | Immutable patient-submitted walk summary. The patient and assigned clinicians can read it. |
| `patients/{patientUid}/plan/current` | Assigned clinicians write targets and breathing approval. The patient can read them. |

Build with `--dart-define=CARE_BACKEND=firebase` and pass `FIREBASE_PROJECT_ID`, `FIREBASE_API_KEY`, `FIREBASE_APP_ID` and `FIREBASE_SENDER_ID` as separate Dart defines from Firebase's web app configuration. Keep service account keys out of the app. The emulator seed script always uses the loopback endpoints. New Firebase projects also need explicit account provisioning and hosting configuration.

## Verification

Run `flutter test` for the offline workflow and sync retry tests. With the seeded emulators running, run `flutter test --platform chrome test/firebase_workflow_browser.dart` for the Flutter client round trip. The test adds one stable synthetic walk, changes the target, reads it back as the patient, and restores the original plan.
