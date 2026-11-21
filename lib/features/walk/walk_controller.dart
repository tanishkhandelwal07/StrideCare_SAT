import '../progress/daily_metrics.dart';
import '../clinic/targets.dart';

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cane/application/cane_provider.dart';
import '../profile/profile.dart';
import '../../storage/care_database.dart';
import 'walk_session_detector.dart';
import 'detection_config.dart';

final walksProvider = StreamProvider<List<WalkSession>>((ref) {
  final db = ref.watch(databaseProvider);
  return db
      .select(db.walkSessions)
      .watch()
      .map(
        (rows) =>
            rows.toList()..sort((a, b) => b.startedAt.compareTo(a.startedAt)),
      );
});

class WalkController extends Notifier<int> {
  final detector = WalkSessionDetector();
  bool connected = false, busy = false, grip = false, saveFailed = false;
  double load = 0, cadence = 0, gait = 0, stepLength = 0;
  int battery = 0, counter = 0;
  bool calibrating = false, aboveTarget = false;
  CareTargets targets = const CareTargets();
  WalkSession? summary;
  final pending = <WalkSession>[];
  @override
  int build() {
    final cane = ref.watch(caneServiceProvider);
    final subs = <StreamSubscription<dynamic>>[
      cane.gripState.listen((v) => grip = v),
      cane.tipLoad.listen((v) => load = v),
      cane.cadence.listen((v) => cadence = v),
      cane.gait.listen((v) => gait = v),
      cane.battery.listen((v) {
        battery = v;
        if (v == 0) connected = false;
        state++;
      }),
      cane.steps.listen(
        (v) => scheduleMicrotask(() {
          if (!ref.mounted) return;
          counter = v;
          if (calibrating) {
            state++;
            return;
          }
          final walk = detector.sample(
            DateTime.now(),
            grip: grip,
            load: load,
            counter: v,
            cadence: cadence,
            gait: gait,
          );
          final above =
              detector.active != null &&
              targets.exceeds(
                estimatedPace(cadence, stepLength),
                cadence,
                load,
              );
          if (above && !aboveTarget && connected) {
            unawaited(cane.sendVibration());
          }
          aboveTarget = above;
          if (walk != null) _complete(walk);
          state++;
        }),
      ),
    ];
    ref.onDispose(() {
      for (final s in subs) {
        s.cancel();
      }
    });
    return 0;
  }

  Future<void> toggle() async {
    if (busy) return;
    busy = true;
    state++;
    try {
      final cane = ref.read(caneServiceProvider);
      if (connected) {
        await cane.disconnect();
        connected = false;
      } else {
        final user = ref.read(profileProvider).value!;
        stepLength = user.heightCm * DetectionConfig.heightToStepLength;
        targets = await CareTargets.read(ref.read(databaseProvider));
        await cane.connect();
        connected = true;
      }
    } finally {
      busy = false;
      state++;
    }
  }

  void _complete(WalkRecord r) {
    final id = ref.read(profileProvider).value!.id;
    final session = WalkSession(
      id: '$id-${r.start.microsecondsSinceEpoch}',
      userId: id,
      startedAt: r.start,
      endedAt: r.end,
      steps: r.steps,
      avgLoad: r.totalLoad / r.samples,
      peakLoad: r.peakLoad,
      avgSpeed: estimatedPace(r.cadence, stepLength),
      peakSpeed: estimatedPace(r.peakCadence, stepLength),
      cadence: r.cadence,
      strideLengthM: stepLength,
      distanceM: r.steps * stepLength,
      gaitRegularity: r.totalGait / r.samples,
    );
    summary = session;
    pending.add(session);
    unawaited(flush());
  }

  Future<void> flush() async {
    final db = ref.read(databaseProvider);
    try {
      for (final session in pending.toList()) {
        await saveWalk(db, session);
        pending.remove(session);
      }
      saveFailed = false;
    } catch (_) {
      saveFailed = true;
    }
    if (ref.mounted) state++;
  }

  void dismiss() {
    summary = null;
    state++;
  }
}

final walkProvider = NotifierProvider<WalkController, int>(WalkController.new);
