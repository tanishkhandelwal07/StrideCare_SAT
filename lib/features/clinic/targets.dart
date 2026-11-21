import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/care_database.dart';

class CareTargets {
  const CareTargets({
    this.maxSpeed,
    this.maxCadence,
    this.maxLoad,
    this.steps,
    this.minutes,
    this.breathing = false,
  });
  final double? maxSpeed, maxCadence, maxLoad, steps, minutes;
  final bool breathing;
  bool exceeds(double speed, double cadence, double load) =>
      (maxSpeed != null && speed > maxSpeed!) ||
      (maxCadence != null && cadence > maxCadence!) ||
      (maxLoad != null && load > maxLoad!);
  Future<void> save(CareDatabase db) => db.setPreference(
    'targets',
    jsonEncode({
      'speed': maxSpeed,
      'cadence': maxCadence,
      'load': maxLoad,
      'steps': steps,
      'minutes': minutes,
      'breathing': breathing,
    }),
  );
  static Future<CareTargets> read(CareDatabase db) async {
    final raw = await db.preference('targets');
    if (raw == null) return const CareTargets();
    final m = jsonDecode(raw) as Map<String, dynamic>;
    return CareTargets(
      maxSpeed: m['speed'],
      maxCadence: m['cadence'],
      maxLoad: m['load'],
      steps: m['steps'],
      minutes: m['minutes'],
      breathing: m['breathing'] == true,
    );
  }
}

final targetsProvider = FutureProvider<CareTargets>(
  (ref) => CareTargets.read(ref.watch(databaseProvider)),
);

enum ChangeAlert { load, activity, pace }

List<ChangeAlert> alertsFor(List<DailyMetric> days) {
  if (days.length < 2) return [];
  final a = days[0], b = days[1];
  final alerts = <ChangeAlert>[
    if (b.avgLoad > 0 && a.avgLoad > b.avgLoad * 1.2) ChangeAlert.load,
  ];
  if (days.length >= 3) {
    final c = days[2];
    final consecutive =
        DateTime.parse('${a.day}T00:00:00Z')
            .difference(DateTime.parse('${c.day}T00:00:00Z'))
            .inDays ==
        2;
    if (consecutive && a.steps < b.steps && b.steps < c.steps) {
      alerts.add(ChangeAlert.activity);
    }
    if (consecutive &&
        a.avgSpeed < b.avgSpeed &&
        b.avgSpeed < c.avgSpeed &&
        a.avgSpeed < c.avgSpeed * 0.9) {
      alerts.add(ChangeAlert.pace);
    }
  }
  return alerts;
}
