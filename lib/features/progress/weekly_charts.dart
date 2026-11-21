import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';

import '../../storage/care_database.dart';
import '../../design/tokens.dart';
import '../../l10n/generated/app_localizations.dart';

class WeeklyCharts extends StatefulWidget {
  const WeeklyCharts(this.days, {super.key});
  final List<DailyMetric> days;
  @override
  State<WeeklyCharts> createState() => _WeeklyChartsState();
}

class _WeeklyChartsState extends State<WeeklyCharts> {
  int metric = 0;
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final labels = [
      s.stepsWord,
      s.pace,
      s.peakPace,
      s.cadenceLabel,
      s.stepLength,
      s.gaitLabel,
      s.loadTrend,
      s.minuteGoal,
    ];
    double read(DailyMetric d) => [
      d.steps.toDouble(),
      d.avgSpeed,
      d.peakSpeed,
      d.cadence,
      d.strideLengthM,
      d.gaitRegularity * 100,
      d.avgLoad,
      d.walkMinutes,
    ][metric];
    final days = widget.days.toList()..sort((a, b) => a.day.compareTo(b.day));
    if (days.isEmpty) return Text(s.emptyWalks);
    final first = DateTime.parse(days.first.day).toUtc();
    final spots = [
      for (final d in days)
        FlSpot(
          DateTime.parse(d.day).toUtc().difference(first).inHours / 24,
          read(d),
        ),
    ];
    final fmt = MaterialLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<int>(
          isExpanded: true,
          value: metric,
          items: [
            for (var i = 0; i < labels.length; i++)
              DropdownMenuItem(value: i, child: Text(labels[i])),
          ],
          onChanged: (v) => setState(() => metric = v!),
        ),
        Text(
          '${read(days.last).toStringAsFixed(metric == 0 ? 0 : 2)} · ${fmt.formatShortDate(DateTime.parse(days.last.day))}',
          style: CareTokens.brand,
        ),
        if (spots.length > 1)
          Semantics(
            label: [
              for (final d in days) '${d.day} ${read(d).toStringAsFixed(2)}',
            ].join(', '),
            child: SizedBox(
              height: CareTokens.illustrationSize,
              child: LineChart(
                LineChartData(
                  lineTouchData: const LineTouchData(enabled: false),
                  titlesData: const FlTitlesData(show: false),
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => const FlLine(
                      color: CareTokens.rule,
                      strokeWidth: CareTokens.hairline,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      color: CareTokens.teal,
                      barWidth: CareTokens.stroke,
                      dotData: FlDotData(
                        checkToShowDot: (p, _) => p == spots.last,
                        getDotPainter: (_, _, _, _) => FlDotCirclePainter(
                          radius: CareTokens.small,
                          color: CareTokens.teal,
                          strokeWidth: 0,
                        ),
                      ),
                      spots: spots,
                    ),
                  ],
                ),
              ),
            ),
          ),
        Wrap(
          spacing: CareTokens.margin,
          children: [
            Text(fmt.formatShortDate(DateTime.parse(days.first.day))),
            if (days.length > 1)
              Text(fmt.formatShortDate(DateTime.parse(days.last.day))),
          ],
        ),
        if (days.any((d) => d.steps >= 1000))
          Text(s.milestone, style: CareTokens.label),
      ],
    );
  }
}
