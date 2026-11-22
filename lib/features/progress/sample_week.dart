import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:printing/printing.dart';

import '../../design/section_page.dart';
import '../../design/tokens.dart';
import '../../l10n/generated/app_localizations.dart';

typedef SampleDay = ({DateTime date, int steps, double minutes, int load});

final sampleWeekProvider = FutureProvider<List<SampleDay>>((ref) async {
  final csv = await rootBundle.loadString(
    'reports/StrideCare-week-2026-11-20.csv',
  );
  return csv.trim().split('\n').skip(1).map((line) {
    final fields = line.trim().split(',');
    return (
      date: DateTime.parse(fields[0]),
      steps: int.parse(fields[3]),
      minutes: double.parse(fields[4]),
      load: int.parse(fields[8]),
    );
  }).toList();
});

class SampleWeekButton extends StatelessWidget {
  const SampleWeekButton({super.key});
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const _SampleWeek()),
    ),
    child: Text(AppLocalizations.of(context).sampleWeek),
  );
}

class _SampleWeek extends ConsumerWidget {
  const _SampleWeek();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SectionPage(
        title: s.sampleWeek,
        message: s.sampleSource,
        content: const SampleWeekReport(),
      ),
    );
  }
}

class SampleWeekReport extends ConsumerWidget {
  const SampleWeekReport({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context);
    final dates = MaterialLocalizations.of(context);
    return ref
        .watch(sampleWeekProvider)
        .when(
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => Text(s.saveError),
          data: (days) {
            final peak = days
                .map((d) => d.steps)
                .reduce((a, b) => a > b ? a : b);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${dates.formatShortDate(days.first.date)} – ${dates.formatShortDate(days.last.date)}',
                ),
                Text(
                  '${days.fold<int>(0, (n, d) => n + d.steps)} ${s.stepsWord}',
                  style: CareTokens.figures,
                ),
                Text(
                  '${s.walkingMinutesSample} · ${days.fold<double>(0, (n, d) => n + d.minutes).round()}',
                ),
                for (final day in days) ...[
                  const Divider(),
                  Text(
                    dates.formatMediumDate(day.date),
                    style: CareTokens.label,
                  ),
                  Text(
                    '${day.steps} ${s.stepsWord} · ${s.loadTrend} ${day.load} N',
                  ),
                  LinearProgressIndicator(
                    value: day.steps / peak,
                    semanticsLabel: s.stepsWord,
                    semanticsValue: day.steps.toString(),
                    color: CareTokens.teal,
                    backgroundColor: CareTokens.rule,
                  ),
                ],
                const SizedBox(height: CareTokens.margin),
                OutlinedButton(
                  child: Text(s.samplePdf),
                  onPressed: () async {
                    try {
                      const filename = 'StrideCare-week-2026-11-20.pdf';
                      final file = await rootBundle.load('reports/$filename');
                      await Printing.sharePdf(
                        bytes: file.buffer.asUint8List(
                          file.offsetInBytes,
                          file.lengthInBytes,
                        ),
                        filename: filename,
                      );
                    } catch (_) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(s.saveError)));
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
  }
}
