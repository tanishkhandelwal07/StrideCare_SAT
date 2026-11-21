import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../design/section_page.dart';
import '../../design/tokens.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../storage/care_database.dart';
import '../progress/daily_metrics.dart';
import '../walk/walk_views.dart';

final fallHistoryProvider = StreamProvider<List<FallEvent>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.fallEvents).watch();
});

class FamilyPage extends ConsumerWidget {
  const FamilyPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context),
        days = ref.watch(metricsProvider).value ?? [];
    final events = ref.watch(fallHistoryProvider).value ?? [];
    return Scaffold(
      body: SafeArea(
        child: SectionPage(
          title: s.family,
          message: s.localClinic,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (days.isEmpty) Text(s.emptyWalks),
              for (final d in days.take(7)) ...[
                Text(
                  MaterialLocalizations.of(context)
                      .formatShortDate(DateTime.parse(d.day)),
                  style: CareTokens.brand,
                ),
                Text('${s.stepsWord} · ${d.steps}'),
                Text('${s.minuteGoal} · ${d.walkMinutes.toStringAsFixed(1)}'),
                Text('${s.pace} · ${paceWords(s, d.avgSpeed)}'),
                const Divider(),
              ],
              Text('${s.fallsLabel} · ${events.length}'),
              for (final f in events.reversed.take(7))
                Text(
                  MaterialLocalizations.of(context)
                      .formatFullDate(f.detectedAt),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
