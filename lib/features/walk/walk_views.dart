import '../today/presentation/cane_illustration.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/navigation.dart';
import '../../design/section_page.dart';
import '../../design/tokens.dart';
import '../../l10n/generated/app_localizations.dart';
import '../cane/application/cane_provider.dart';
import 'walk_controller.dart';
import '../safety/practice_fall.dart';
import '../../storage/care_database.dart';
import 'walk_session_detector.dart';

String elapsed(Duration d) =>
    '${d.inMinutes}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
String paceWords(AppLocalizations s, double v) => v < 0.65
    ? s.slow
    : v < 1.15
    ? s.comfortable
    : s.brisk;

class WalkShell extends ConsumerWidget {
  const WalkShell({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(walkProvider);
    final model = ref.read(walkProvider.notifier),
        live = model.detector.active,
        summary = model.summary;
    ref.watch(fallMonitorProvider);
    final event = ref.watch(unresolvedFallProvider).value;
    if (event != null) {
      final s = AppLocalizations.of(context);
      final age = (ref.watch(fallClockProvider).value ?? DateTime.now())
          .difference(event.detectedAt);
      final stage = fallStage(age);
      final real = ref.watch(liveSosProvider);
      final submission = real && stage != FallStage.countdown
          ? ref.watch(sendSosProvider(event))
          : null;
      return Scaffold(
        body: SafeArea(
          child: SectionPage(
            title: real ? s.sosCheck : s.simFall,
            message: real ? s.sosRealHint : s.sosPractice,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  real && submission != null
                      ? s.sosUnconfirmed
                      : switch (stage) {
                          FallStage.countdown =>
                            '${fallCountdownSeconds - age.inSeconds.clamp(0, fallCountdownSeconds)}',
                          FallStage.firstContact => s.firstStage,
                          FallStage.secondContact => s.secondStage,
                        },
                  style: CareTokens.brand,
                ),
                FilledButton(
                  onPressed: () =>
                      acknowledgeFall(ref.read(databaseProvider), event),
                  child: Text(s.okay),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (live == null && summary == null) return const CareNavigation();
    final s = AppLocalizations.of(context);
    final speed = live != null
        ? estimatedPace(model.cadence, model.stepLength)
        : summary!.avgSpeed;
    return Scaffold(
      body: SafeArea(
        child: SectionPage(
          title: live != null ? s.liveWalk : s.walkSummary,
          message: s.demo,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.stepsWord),
              Text(
                '${live?.steps ?? summary!.steps}',
                style: CareTokens.figures,
              ),
              Text(
                '${s.walkTime} · ${elapsed(live?.duration ?? summary!.endedAt.difference(summary.startedAt))}',
              ),
              const Divider(),
              if (model.aboveTarget) Text(s.feedback),
              Text(paceWords(s, speed), style: CareTokens.brand),
              Text('${s.pace} · ${speed.toStringAsFixed(1)}'),
              if (live == null) ...[
                Text('${s.distance} · ${summary!.distanceM.round()}'),
                Text('${s.loadTrend} · ${summary.avgLoad.round()}'),
                if (model.saveFailed)
                  TextButton(onPressed: model.flush, child: Text(s.saveError)),
                FilledButton(
                  onPressed: model.pending.isEmpty ? model.dismiss : null,
                  child: Text(s.returnToday),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PairCane extends ConsumerStatefulWidget {
  const PairCane({super.key});
  @override
  ConsumerState<PairCane> createState() => _PairCaneState();
}

class _PairCaneState extends ConsumerState<PairCane> {
  int stage = 0;
  int baseSteps = 0;
  DateTime? zeroEnds;
  late WalkController model;
  @override
  void initState() {
    super.initState();
    model = ref.read(walkProvider.notifier);
    if (model.connected) stage = 4;
  }

  @override
  void dispose() {
    model.calibrating = false;
    super.dispose();
  }

  Future<void> pair() async {
    model.calibrating = true;
    baseSteps = model.counter;
    await model.toggle();
    if (mounted) {
      setState(() {
        stage = 3;
        zeroEnds = DateTime.now().add(const Duration(seconds: 5));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(walkProvider);
    final s = AppLocalizations.of(context);
    final checked = (model.counter - baseSteps).clamp(0, 5);
    final remaining = zeroEnds?.difference(DateTime.now()).inSeconds ?? 0;
    return Scaffold(
      appBar: AppBar(),
      body: SectionPage(
        title: [
          s.pairTitle,
          s.deviceAttach,
          s.searchDevice,
          s.calibrate,
          s.connectedLabel,
        ][stage],
        message: stage == 0 ? s.pairHint : s.demo,
        illustration: stage == 1 ? const CaneIllustration() : null,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (stage < 2)
              FilledButton(
                onPressed: () => setState(() => stage++),
                child: Text(s.nextStep),
              ),
            if (stage == 2)
              ListTile(
                title: const Text('StrideCare-0001'),
                subtitle: Text(s.connect),
                onTap: model.busy ? null : pair,
              ),
            if (stage == 3) ...[
              Text(remaining > 0 ? s.still : s.motionCheck),
              Text(
                remaining > 0 ? '$remaining' : '$checked / 5',
                style: CareTokens.figures,
              ),
              FilledButton(
                onPressed: remaining <= 0 && checked == 5
                    ? () => setState(() => stage = 4)
                    : null,
                child: Text(s.nextStep),
              ),
            ],
            if (stage == 4) ...[
              Text(
                'StrideCare-0001 · ${model.battery}%',
                style: CareTokens.brand,
              ),
              TextButton(
                onPressed: () async {
                  await ref.read(caneServiceProvider).sendVibration();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(s.buzzOk)));
                  }
                },
                child: Text(s.testBuzz),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: Text(s.returnToday),
              ),
              TextButton(
                onPressed: model.busy
                    ? null
                    : () async {
                        await model.toggle();
                        if (context.mounted) Navigator.pop(context);
                      },
                child: Text(s.disconnect),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
