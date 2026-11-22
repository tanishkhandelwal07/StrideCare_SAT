import '../sample_week.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../weekly_charts.dart';
import '../daily_metrics.dart';
import '../../../design/section_page.dart';
import '../../../design/tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../walk/walk_controller.dart';
import '../../walk/walk_views.dart';
import '../weekly_report.dart';
import '../../profile/profile.dart';
import '../../../storage/care_database.dart';

class ProgressPage extends ConsumerWidget {
  const ProgressPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context), rows = ref.watch(walksProvider);
    final today = DateUtils.dateOnly(DateTime.now());
    final start = DateTime(today.year, today.month, today.day - 6);
    final week = (rows.value ?? [])
        .where((w) => !w.startedAt.isBefore(start))
        .toList();
    return SectionPage(
      title: s.progress,
      message: s.weeklyWalks,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rows.hasError)
            Text(s.saveError)
          else if (rows.isLoading)
            const LinearProgressIndicator()
          else if (week.isEmpty) ...[
            Text(s.emptyWalks),
            const Divider(),
            Text(s.exampleReport, style: CareTokens.brand),
            Text(s.sampleSource),
            const SampleWeekReport(),
          ] else ...[
            WeeklyCharts(
              (ref.watch(metricsProvider).value ?? [])
                  .where((d) => d.day.compareTo(dayKey(start)) >= 0)
                  .toList(),
            ),
            for (final w in week) ...[
              const Divider(),
              Text(
                MaterialLocalizations.of(context).formatShortDate(w.startedAt),
                style: CareTokens.label,
              ),
              Text(
                '${s.stepsWord} · ${w.steps}     ${s.walkTime} · ${elapsed(w.endedAt.difference(w.startedAt))}',
              ),
              Text(
                '${paceWords(s, w.avgSpeed)} · ${w.avgSpeed.toStringAsFixed(1)}',
              ),
              Text('${s.loadTrend} · ${w.avgLoad.round()}'),
            ],

            OutlinedButton(
              onPressed: () async {
                try {
                  await shareReport(
                    ref.read(databaseProvider),
                    s,
                    ref.read(profileProvider).value!,
                  );
                } catch (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(s.saveError)));
                  }
                }
              },
              child: Text(s.report),
            ),
          ],
        ],
      ),
    );
  }
}
