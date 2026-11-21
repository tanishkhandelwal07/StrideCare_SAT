import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../storage/care_database.dart';
import '../../design/tokens.dart';
import '../../design/section_page.dart';
import '../profile/profile.dart';
import '../progress/daily_metrics.dart';
import '../progress/weekly_charts.dart';
import 'targets.dart';

class ClinicPage extends ConsumerWidget {
  const ClinicPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context),
        user = ref.watch(profileProvider).value,
        days = ref.watch(metricsProvider).value ?? [];
    final alerts = alertsFor(days), now = DateTime.now();
    final week = days
        .where(
          (d) =>
              d.day.compareTo(
                dayKey(DateTime(now.year, now.month, now.day - 6)),
              ) >=
              0,
        )
        .toList();
    return Scaffold(
      body: SafeArea(
        child: SectionPage(
          title: s.clinic,
          message: s.localClinic,
          content: user == null
              ? Text(s.noProfile)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: CareTokens.brand),
                    WeeklyCharts(week),
                    const Divider(),
                    Text(s.alerts, style: CareTokens.brand),
                    if (alerts.isEmpty) Text(s.noAlerts),
                    for (final alert in alerts)
                      Text(switch (alert) {
                        ChangeAlert.load => s.riseLoad,
                        ChangeAlert.activity => s.dropActivity,
                        ChangeAlert.pace => s.dropPace,
                      }),
                    const Divider(),
                    if (ref.watch(targetsProvider).value case final t?)
                      TargetForm(t),
                  ],
                ),
        ),
      ),
    );
  }
}

class TargetForm extends ConsumerStatefulWidget {
  const TargetForm(this.targets, {super.key});
  final CareTargets targets;
  @override
  ConsumerState<TargetForm> createState() => _TargetFormState();
}

class _TargetFormState extends ConsumerState<TargetForm> {
  final form = GlobalKey<FormState>();
  late final fields = [
    widget.targets.maxSpeed,
    widget.targets.maxCadence,
    widget.targets.maxLoad,
    widget.targets.steps,
    widget.targets.minutes,
  ].map((v) => TextEditingController(text: v?.toString() ?? '')).toList();
  late bool breathing = widget.targets.breathing;
  @override
  void dispose() {
    for (final f in fields) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final labels = [
      s.maxSpeed,
      s.maxCadence,
      s.maxLoad,
      s.stepsWord,
      s.minuteGoal,
    ];
    double? number(int i) => double.tryParse(fields[i].text.trim());
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.targets, style: CareTokens.brand),
          for (var i = 0; i < fields.length; i++)
            TextFormField(
              controller: fields[i],
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: labels[i]),
              validator: (v) =>
                  v!.trim().isEmpty ||
                      ((number(i) ?? 0) > 0 && number(i)!.isFinite)
                  ? null
                  : s.invalidNumber,
            ),
          CheckboxListTile(
            value: breathing,
            title: Text(s.breathing),
            subtitle: Text(s.approved),
            onChanged: (v) => setState(() => breathing = v == true),
          ),
          FilledButton(
            onPressed: () async {
              if (!form.currentState!.validate()) return;
              await CareTargets(
                maxSpeed: number(0),
                maxCadence: number(1),
                maxLoad: number(2),
                steps: number(3),
                minutes: number(4),
                breathing: breathing,
              ).save(ref.read(databaseProvider));
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(s.saved)));
              }
            },
            child: Text(s.saveTargets),
          ),
        ],
      ),
    );
  }
}
