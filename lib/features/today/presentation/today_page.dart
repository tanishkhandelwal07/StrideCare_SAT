import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design/section_page.dart';
import '../../../design/tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../profile/profile.dart';
import '../../walk/walk_controller.dart';
import '../../walk/walk_views.dart';
import 'cane_illustration.dart';
import '../../clinic/targets.dart';
import '../../settings/presentation/settings_page.dart';
import '../../../app/navigation.dart';
import '../../progress/daily_metrics.dart';
import '../../progress/recovery_score.dart';

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(walkProvider);
    final s = AppLocalizations.of(context),
        now = DateTime.now(),
        model = ref.read(walkProvider.notifier);
    final walks = ref.watch(walksProvider);
    final today = (walks.value ?? []).where(
      (w) => DateUtils.isSameDay(now, w.startedAt),
    );
    final sample =
        !ref.watch(connectedAccountProvider) && walks.hasValue && today.isEmpty;
    // A five-minute, 72 steps/min example from the synthetic walk dataset.
    final steps = sample ? 360 : today.fold(0, (n, w) => n + w.steps);
    final time = sample
        ? const Duration(minutes: 5)
        : today.fold(
            Duration.zero,
            (n, w) => n + w.endedAt.difference(w.startedAt),
          );
    final targets = ref.watch(targetsProvider).value;
    final days = ref.watch(metricsProvider).value ?? [];
    final hasBaseline = days.length >= 2 && days.first.day == dayKey(now);
    final score = hasBaseline ? recoveryScore(days.first, days[1]) : null;
    final greeting = now.hour < 12
        ? s.morning
        : now.hour < 17
        ? s.afternoon
        : s.evening;
    final name = ref.watch(profileProvider).value?.name.split(' ').first ?? '';
    return SectionPage(
      title: '$greeting, $name',
      message: s.todayHint,
      illustration: !model.connected ? const CaneIllustration() : null,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sample && !walks.isLoading && !walks.hasError
                ? s.sampleActivity
                : s.demo,
            style: CareTokens.label,
          ),
          const Divider(),
          if (walks.hasError)
            Text(s.saveError)
          else if (walks.isLoading)
            const LinearProgressIndicator()
          else ...[
            if (targets?.steps != null || targets?.minutes != null)
              SizedBox.square(
                dimension: CareTokens.illustrationSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (targets?.steps != null)
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: (steps / targets!.steps!).clamp(0, 1),
                          backgroundColor: CareTokens.rule,
                          color: CareTokens.teal,
                          semanticsLabel: s.todaySteps,
                        ),
                      ),
                    if (targets?.minutes != null)
                      SizedBox.square(
                        dimension: CareTokens.metricSize,
                        child: CircularProgressIndicator(
                          value: (time.inSeconds / 60 / targets!.minutes!)
                              .clamp(0, 1),
                          backgroundColor: CareTokens.rule,
                          color: CareTokens.marigold,
                          semanticsLabel: s.minuteGoal,
                        ),
                      ),
                  ],
                ),
              ),
            Text(s.todaySteps),
            Text('$steps', style: CareTokens.figures),
            Text('${s.walkTime} · ${elapsed(time)}'),
            if (today.isNotEmpty)
              Text(
                '${s.pace} · ${paceWords(s, time.inSeconds == 0 ? 0 : today.fold(0.0, (n, w) => n + w.distanceM) / time.inSeconds)}',
              ),
          ],
          const Divider(),
          Text(s.recoveryLabel, style: CareTokens.brand),
          if (score == null)
            Text(s.noBaseline)
          else ...[
            Text(
              '${score >= 75
                  ? s.improving
                  : score < 65
                  ? s.slower
                  : s.steady}, $score',
            ),
            if (slowerDay(days.first, days[1])) Text(s.lowerDay),
          ],
          const Divider(),
          Text(s.tasks, style: CareTokens.brand),
          ListTile(
            leading: const Icon(Icons.restaurant_outlined),
            title: Text(s.meal),
            onTap: () =>
                ref.read(currentTabProvider.notifier).select(CareTab.wellness),
          ),
          ListTile(
            leading: const Icon(Icons.spa_outlined),
            title: Text(
              targets?.breathing == true ? s.breathing : s.approvalLock,
            ),
            onTap: () =>
                ref.read(currentTabProvider.notifier).select(CareTab.wellness),
          ),
          const Divider(),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const PairCane()),
            ),
            child: Text(model.connected ? s.connectedLabel : s.fixCane),
          ),
        ],
      ),
    );
  }
}
