import 'dart:collection';

import 'detection_config.dart';

typedef Reading = ({
  DateTime time,
  int steps,
  double load,
  double cadence,
  double gait,
});

class WalkRecord {
  WalkRecord(this.start);
  final DateTime start;
  late DateTime end = start;
  int steps = 0, samples = 0;
  double totalLoad = 0, peakLoad = 0, peakCadence = 0, totalGait = 0;
  Duration get duration => end.difference(start);
  double get cadence =>
      duration.inMilliseconds > 0 ? steps * 60000 / duration.inMilliseconds : 0;
  void add(Reading r) {
    end = r.time;
    steps += r.steps;
    if (r.steps > 0) {
      samples += r.steps;
      totalLoad += r.load * r.steps;
      totalGait += r.gait * r.steps;
      if (r.load > peakLoad) peakLoad = r.load;
      if (r.cadence > peakCadence) peakCadence = r.cadence;
    }
  }
}

class WalkSessionDetector {
  final _candidate = Queue<Reading>();
  WalkRecord? active;
  int? _lastCounter;
  DateTime? _lastActivity;
  WalkRecord? sample(
    DateTime time, {
    required bool grip,
    required double load,
    required int counter,
    required double cadence,
    required double gait,
  }) {
    final delta = counter - (_lastCounter ?? counter);
    _lastCounter = counter;
    if (!grip || delta < 0) return finish();
    final r = (
      time: time,
      steps: delta,
      load: load,
      cadence: cadence,
      gait: gait,
    );
    if (load > DetectionConfig.minimumLoadN || delta > 0) _lastActivity = time;
    if (active case final walk?) {
      if (time.difference(_lastActivity!) >= DetectionConfig.idleWindow) {
        return finish();
      }
      walk.add(r);
    } else {
      while (_candidate.isNotEmpty &&
          time.difference(_candidate.first.time) >
              DetectionConfig.startWindow) {
        _candidate.removeFirst();
      }
      if (delta > 0 && load > DetectionConfig.minimumLoadN) _candidate.add(r);
      if (_candidate.fold(0, (sum, reading) => sum + reading.steps) >=
          DetectionConfig.startSteps) {
        active = WalkRecord(
          _candidate.first.time.subtract(
            Duration(
              milliseconds: cadence > 0
                  ? (60000 * _candidate.first.steps / cadence).round().clamp(
                      1,
                      5000,
                    )
                  : 1000,
            ),
          ),
        );
        for (final reading in _candidate) {
          active!.add(reading);
        }
        _candidate.clear();
      }
    }
    return null;
  }

  WalkRecord? finish() {
    _candidate.clear();
    final ended = active;
    if (ended != null) ended.end = _lastActivity!;
    active = null;
    _lastActivity = null;
    return ended;
  }
}

double estimatedPace(double cadence, double stepLength) =>
    cadence * stepLength / 60;
