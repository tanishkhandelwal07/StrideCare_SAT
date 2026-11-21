import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;

import '../../../design/section_page.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../storage/care_database.dart';
import '../../profile/profile.dart';
import '../reminders.dart';

final medicationProvider = StreamProvider<List<MedicationLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.medicationLogs).watch();
});

class MedicinePage extends ConsumerWidget {
  const MedicinePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context),
        db = ref.watch(databaseProvider),
        logs = ref.watch(medicationProvider);
    return SectionPage(
      title: s.medicine,
      message: s.medicineHint,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final m in logs.value ?? <MedicationLog>[])
            CheckboxListTile(
              title: Text(m.medicineName),
              subtitle: Text(
                '${MaterialLocalizations.of(context).formatShortDate(m.scheduledAt)} · ${TimeOfDay.fromDateTime(m.scheduledAt).format(context)}',
              ),
              value: m.takenAt != null,
              onChanged: (v) async {
                await (db.update(
                  db.medicationLogs,
                )..where((r) => r.id.equals(m.id))).write(
                  MedicationLogsCompanion(
                    takenAt: Value(v == true ? DateTime.now() : null),
                  ),
                );
                if (v == true) {
                  await MedicineReminders.cancel(m.id);
                } else {
                  await MedicineReminders.schedule(m, s);
                }
              },
            ),
          FilledButton(
            child: Text(s.addMed),
            onPressed: () async {
              var name = '';
              final id = ref.read(profileProvider).value!.id;
              final answer = await showDialog<String>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(s.addMed),
                  content: TextField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: s.medicineName),
                    onChanged: (v) => name = v.trim(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        MaterialLocalizations.of(ctx).cancelButtonLabel,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (name.isNotEmpty) Navigator.pop(ctx, name);
                      },
                      child: Text(s.nextStep),
                    ),
                  ],
                ),
              );
              if (answer == null || !context.mounted) return;
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time == null) return;
              final now = DateTime.now();
              var scheduled = DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              );
              if (!scheduled.isAfter(now)) {
                scheduled = DateTime(
                  now.year,
                  now.month,
                  now.day + 1,
                  time.hour,
                  time.minute,
                );
              }
              final entry = MedicationLog(
                id: '${now.microsecondsSinceEpoch}',
                userId: id,
                medicineName: answer,
                scheduledAt: scheduled,
              );
              await db.into(db.medicationLogs).insert(entry);
              final enabled = await MedicineReminders.schedule(entry, s);
              if (!enabled && context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(s.reminderOff)));
              }
            },
          ),
        ],
      ),
    );
  }
}
