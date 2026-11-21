import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../storage/care_database.dart';
import 'daily_metrics.dart';

Future<Uint8List> weeklyReport(
  CareDatabase db,
  AppLocalizations s,
  User user,
  DateTime now,
) async {
  final start = DateTime(now.year, now.month, now.day - 6);
  final end = DateTime(now.year, now.month, now.day + 1);
  final days =
      await (db.select(db.dailyMetrics)..where(
            (r) =>
                r.userId.equals(user.id) &
                r.day.isBetweenValues(dayKey(start), dayKey(now)),
          ))
          .get();
  days.sort((a, b) => a.day.compareTo(b.day));
  final falls =
      await (db.select(db.fallEvents)..where(
            (r) =>
                r.userId.equals(user.id) &
                r.detectedAt.isBiggerOrEqualValue(start) &
                r.detectedAt.isSmallerThanValue(end),
          ))
          .get();
  final meds =
      await (db.select(db.medicationLogs)..where(
            (r) =>
                r.userId.equals(user.id) &
                r.scheduledAt.isBiggerOrEqualValue(start) &
                r.scheduledAt.isSmallerThanValue(end),
          ))
          .get();
  Future<pw.Font> font(String file) async =>
      pw.Font.ttf(await rootBundle.load('assets/fonts/$file.ttf'));
  final body = await font('NunitoSans'),
      fallback = [
        await font('NotoSansDevanagari'),
        await font('NotoSansGurmukhi'),
      ];
  final doc = pw.Document(
    theme: pw.ThemeData.withFont(
      base: body,
      bold: body,
      fontFallback: fallback,
    ),
  );
  doc.addPage(
    pw.MultiPage(
      build: (_) => [
        pw.Header(text: s.appName),
        pw.Text(user.name),
        pw.Text('${dayKey(start)} – ${dayKey(now)}'),
        pw.Text(s.demo),
        for (final d in days)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Divider(),
              pw.Text(d.day),
              pw.Text(
                '${s.stepsWord}: ${d.steps}    ${s.minuteGoal}: ${d.walkMinutes.toStringAsFixed(1)}',
              ),
              pw.Text('${s.loadTrend}: ${d.avgLoad.toStringAsFixed(1)}'),
              pw.Text(
                '${s.pace}: ${d.avgSpeed.toStringAsFixed(2)}    ${s.peakPace}: ${d.peakSpeed.toStringAsFixed(2)}',
              ),
              pw.Text('${s.cadenceLabel}: ${d.cadence.round()}'),
            ],
          ),
        if (days.isEmpty) pw.Text(s.emptyWalks),
        pw.Divider(),
        pw.Text('${s.fallsLabel}: ${falls.length}'),
        pw.Text(
          '${s.dosesLogged}: ${meds.where((m) => m.takenAt != null).length} / ${meds.length}',
        ),
      ],
    ),
  );
  return doc.save();
}

Future<void> shareReport(CareDatabase db, AppLocalizations s, User user) async {
  final now = DateTime.now();
  await Printing.sharePdf(
    bytes: await weeklyReport(db, s, user, now),
    filename: 'StrideCare-${dayKey(now)}.pdf',
  );
}
