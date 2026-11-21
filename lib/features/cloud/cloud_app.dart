import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/stridecare_app.dart';
import '../../design/theme.dart';
import '../../design/tokens.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../storage/care_database.dart';
import '../clinic/targets.dart';
import '../settings/presentation/settings_page.dart';
import '../clinic/clinic_page.dart';
import '../walk/walk_controller.dart';
import 'repository.dart';
import 'walk_sync.dart';

class CloudApp extends StatefulWidget {
  const CloudApp({
    super.key,
    required this.accounts,
    required this.care,
    required this.project,
  });
  final AccountRepository accounts;
  final CareRepository care;
  final String project;
  @override
  State<CloudApp> createState() => _CloudAppState();
}

class _CloudAppState extends State<CloudApp> {
  late final session = widget.accounts.signedInUid;
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: careTheme(),
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      ...GlobalMaterialLocalizations.delegates,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: StreamBuilder<String?>(
      stream: session,
      builder: (ctx, snap) {
        if (snap.hasError) {
          return Scaffold(
            body: Center(child: Text(AppLocalizations.of(ctx).cloudError)),
          );
        }
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final uid = snap.data;
        return uid == null
            ? _Login(widget.accounts)
            : _AccountView(key: ValueKey(uid), uid: uid, app: widget);
      },
    ),
  );
}

class _Login extends StatefulWidget {
  const _Login(this.accounts);
  final AccountRepository accounts;
  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  final email = TextEditingController(), password = TextEditingController();
  bool busy = false, error = false;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: CareTokens.readingWidth,
            ),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(CareTokens.margin),
              children: [
                Text(s.appName, style: CareTokens.brand),
                Text(s.signIn, style: CareTokens.heading),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: s.emailAddress),
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(labelText: s.passwordLabel),
                ),
                if (error) Text(s.signInError),
                const SizedBox(height: CareTokens.margin),
                FilledButton(
                  onPressed: busy
                      ? null
                      : () async {
                          setState(() {
                            busy = true;
                            error = false;
                          });
                          try {
                            await widget.accounts.signIn(
                              email.text.trim(),
                              password.text,
                            );
                          } catch (_) {
                            if (mounted) setState(() => error = true);
                          } finally {
                            if (mounted) setState(() => busy = false);
                          }
                        },
                  child: Text(s.signIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountView extends StatefulWidget {
  const _AccountView({super.key, required this.uid, required this.app});
  final String uid;
  final CloudApp app;
  @override
  State<_AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<_AccountView> {
  late final role = widget.app.care.role(widget.uid);
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.cloudWorkspace),
        actions: [
          TextButton(
            onPressed: widget.app.accounts.signOut,
            child: Text(s.signOut),
          ),
        ],
      ),
      body: StreamBuilder<String?>(
        stream: role,
        builder: (ctx, snap) {
          if (snap.hasError) return Center(child: Text(s.cloudError));
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return switch (snap.data) {
            'patient' => _Patient(uid: widget.uid, app: widget.app),
            'clinician' => _Clinic(widget.app.care, widget.uid),
            _ => Center(child: Text(s.noRole)),
          };
        },
      ),
    );
  }
}

class _Patient extends StatefulWidget {
  const _Patient({required this.uid, required this.app});
  final String uid;
  final CloudApp app;
  @override
  State<_Patient> createState() => _PatientState();
}

class _PatientState extends State<_Patient> {
  late final db = CareDatabase.local(
    name: 'stridecare_${widget.app.project}_${widget.uid}',
  );
  late final container = ProviderContainer(
    overrides: [
      databaseProvider.overrideWithValue(db),
      connectedAccountProvider.overrideWithValue(true),
    ],
  );
  late final sync = WalkSync(db, widget.app.care, widget.uid);
  late final Timer timer;
  late final StreamSubscription<CareTargets> plans;
  bool uploadFailed = false, planFailed = false;
  @override
  void initState() {
    super.initState();
    plans = widget.app.care
        .targets(widget.uid)
        .asyncMap((plan) async {
          await plan.save(db);
          if (!mounted) return plan;
          container.invalidate(targetsProvider);
          container.read(walkProvider.notifier).targets = plan;
          return plan;
        })
        .listen(
          (_) {
            if (mounted && planFailed) setState(() => planFailed = false);
          },
          onError: (Object _) {
            if (mounted) setState(() => planFailed = true);
          },
        );
    timer = Timer.periodic(const Duration(seconds: 8), (_) => flush());
    unawaited(flush());
  }

  Future<void> flush() async {
    try {
      await sync.flush();
      if (mounted && uploadFailed) setState(() => uploadFailed = false);
    } catch (_) {
      if (mounted) setState(() => uploadFailed = true);
    }
  }

  @override
  void dispose() {
    sync.closed = true;
    timer.cancel();
    plans.cancel();
    container.dispose();
    unawaited(db.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (uploadFailed || planFailed)
        Text(AppLocalizations.of(context).syncProblem),
      Expanded(
        child: UncontrolledProviderScope(
          container: container,
          child: const StrideCareApp(patientOnly: true),
        ),
      ),
    ],
  );
}

class _Clinic extends StatefulWidget {
  const _Clinic(this.repo, this.uid);
  final CareRepository repo;
  final String uid;
  @override
  State<_Clinic> createState() => _ClinicState();
}

class _ClinicState extends State<_Clinic> {
  late final assigned = widget.repo.assigned(widget.uid);
  String? selected;
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    return StreamBuilder<List<Assignment>>(
      stream: assigned,
      builder: (ctx, snap) {
        if (snap.hasError) return Text(s.cloudError);
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final patients = snap.requireData;
        if (patients.isEmpty) return Center(child: Text(s.noAssignments));
        final current = patients.firstWhere(
          (p) => p.id == selected,
          orElse: () => patients.first,
        );
        return ListView(
          padding: const EdgeInsets.all(CareTokens.margin),
          children: [
            Text(s.clinic, style: CareTokens.heading),
            DropdownButton<String>(
              value: current.id,
              items: [
                for (final p in patients)
                  DropdownMenuItem(value: p.id, child: Text(p.name)),
              ],
              onChanged: (id) => setState(() => selected = id),
            ),
            _Detail(
              key: ValueKey(current.id),
              repo: widget.repo,
              pid: current.id,
            ),
          ],
        );
      },
    );
  }
}

class _Detail extends StatefulWidget {
  const _Detail({super.key, required this.repo, required this.pid});
  final CareRepository repo;
  final String pid;
  @override
  State<_Detail> createState() => _DetailState();
}

class _DetailState extends State<_Detail> {
  late final walks = widget.repo.recent(widget.pid),
      plans = widget.repo.targets(widget.pid);
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.recentWalks, style: CareTokens.brand),
        StreamBuilder<List<SharedWalk>>(
          stream: walks,
          builder: (ctx, snap) {
            if (snap.hasError) return Text(s.cloudError);
            if (!snap.hasData) return const LinearProgressIndicator();
            if (snap.requireData.isEmpty) return Text(s.emptyWalks);
            return Column(
              children: [
                for (final w in snap.requireData)
                  ListTile(
                    title: Text(
                      '${MaterialLocalizations.of(ctx).formatShortDate(w.started)} · ${s.stepsWord} ${w.steps}',
                    ),
                    subtitle: Text(
                      '${s.pace} ${w.pace.toStringAsFixed(2)} · ${s.loadTrend} ${w.load.round()}',
                    ),
                  ),
              ],
            );
          },
        ),
        const Divider(),
        StreamBuilder<CareTargets>(
          stream: plans,
          builder: (ctx, snap) {
            if (snap.hasError) return Text(s.cloudError);
            if (!snap.hasData) return const LinearProgressIndicator();
            return TargetForm(
              snap.requireData,
              onSave: (t) => widget.repo.saveTargets(widget.pid, t),
            );
          },
        ),
      ],
    );
  }
}
