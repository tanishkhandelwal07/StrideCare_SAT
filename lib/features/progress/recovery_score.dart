import '../../storage/care_database.dart';

/// Experimental within-person index for practice data. A stable day centres
/// on 70. Changes are capped to keep one unusually long walk from dominating.
/// Weights are load 30%, pace 25%, rhythm 25%, activity 20%.
int? recoveryScore(DailyMetric day, DailyMetric? baseline) {
  if (baseline == null || baseline.steps == 0) return null;
  double change(double a, double b) => b <= 0 ? 0 : ((a - b) / b).clamp(-1, 1);
  final trend =
      -0.30 * change(day.avgLoad, baseline.avgLoad) +
      0.25 * change(day.avgSpeed, baseline.avgSpeed) +
      0.25 * change(day.gaitRegularity, baseline.gaitRegularity) +
      0.20 * change(day.steps.toDouble(), baseline.steps.toDouble());
  return (70 + 50 * trend).round().clamp(0, 100);
}

bool slowerDay(DailyMetric day, DailyMetric previous) =>
    previous.avgSpeed > 0 && day.avgSpeed < previous.avgSpeed * 0.9;
