import '../progress/sample_week.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../storage/care_database.dart';
import '../../design/tokens.dart';
import '../../l10n/generated/app_localizations.dart';

final profileProvider = StreamProvider<User?>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.users).watchSingleOrNull();
});

class LanguageChoice extends Notifier<String?> {
  @override
  String? build() => null;
  void select(String value) => state = value;
}

final languageProvider = NotifierProvider<LanguageChoice, String?>(
  LanguageChoice.new,
);

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({super.key, this.contacts});
  final List<EmergencyContact>? contacts;
  @override
  ConsumerState<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding> {
  final inputs = List.generate(10, (_) => TextEditingController());
  final form = GlobalKey<FormState>();
  int page = 0;
  String? injury, side;
  DateTime? date;
  bool saving = false;
  String? error;
  bool get editing => widget.contacts != null;
  @override
  void initState() {
    super.initState();
    if (editing) {
      page = 6;
      for (final c in widget.contacts!) {
        final i = 3 + (c.position - 1) * 3;
        inputs[i].text = c.name;
        inputs[i + 1].text = c.phoneE164;
        inputs[i + 2].text = c.relationship;
      }
    }
  }

  @override
  void dispose() {
    for (final field in inputs) {
      field.dispose();
    }
    super.dispose();
  }

  String value(int i) => inputs[i].text.trim();
  String phone(int i) => value(i).replaceAll(RegExp(r'[\s()\-]'), '');
  Future<void> advance() async {
    final s = AppLocalizations.of(context);
    if (!form.currentState!.validate()) return;
    if ((page == 3 && injury == null) ||
        (page == 4 && date == null) ||
        (page == 5 && side == null)) {
      setState(() => error = s.requiredField);
      return;
    }
    if (page < (editing ? 7 : 8)) {
      setState(() {
        page++;
        error = null;
      });
      return;
    }
    setState(() => saving = true);
    final db = ref.read(databaseProvider);
    final locale = Localizations.localeOf(context).languageCode;
    try {
      await db.transaction(() async {
        if (editing) {
          await db.customStatement(
            'DELETE FROM emergency_contacts WHERE user_id=1',
          );
        } else {
          await db.customStatement(
            'INSERT INTO users(id,name,height_cm,age,locale) VALUES(1,?,?,?,?)',
            [value(0), double.parse(value(1)), int.parse(value(2)), locale],
          );
        }
        for (var slot = 0; slot < 2; slot++) {
          final i = 3 + 3 * slot;
          await db.customStatement(
            'INSERT INTO emergency_contacts VALUES(1,?,?,?,?)',
            [slot + 1, value(i), phone(i + 1), value(i + 2)],
          );
        }
        if (!editing) {
          await db.customStatement(
            'INSERT INTO injury_profiles VALUES(1,?,?,?)',
            [injury, date!.toIso8601String(), side],
          );
        }
        if (value(9).isNotEmpty) {
          await db.setPreference('physio_code', value(9));
        }
        db.markTablesUpdated({
          db.users,
          db.emergencyContacts,
          db.injuryProfiles,
        });
      });
      if (editing && mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        setState(() {
          error = s.saveError;
          saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final status = [
      'language',
      'name',
      'measurements',
      'injury',
      'date',
      'side',
      'contact1',
      'contact2',
      'code',
    ][page];
    final title = [
      s.language,
      s.personName,
      s.measurements,
      s.injury,
      s.dateLabel,
      s.side,
      s.firstContact,
      s.secondContact,
      s.codeLabel,
    ][page];
    Widget field(int i, String label, {TextInputType? keyboard}) => Padding(
      padding: const EdgeInsets.only(bottom: CareTokens.inset),
      child: TextFormField(
        controller: inputs[i],
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label),
        validator: (raw) {
          if (i == 9) return null;
          if (value(i).isEmpty) return s.requiredField;
          if (i == 1 &&
              !((double.tryParse(value(i)) ?? 0) > 0 &&
                  double.parse(value(i)) <= 300)) {
            return s.invalidNumber;
          }
          if (i == 2 &&
              !((int.tryParse(value(i)) ?? 0) > 0 &&
                  int.parse(value(i)) <= 125)) {
            return s.invalidNumber;
          }
          if (i == 4 || i == 7) {
            if (!RegExp(r'^\+[1-9][0-9]{6,14}$').hasMatch(phone(i))) {
              return s.invalidNumber;
            }
            if (i == 7 && phone(4) == phone(7)) return s.differentPhone;
          }
          return null;
        },
      ),
    );
    Widget choices(
      Map<String, String> options,
      String? selected,
      ValueChanged<String> choose,
    ) => Column(
      children: [
        for (final e in options.entries)
          ListTile(
            minTileHeight: CareTokens.touch,
            title: Text(e.value),
            trailing: Icon(
              selected == e.key
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
            ),
            selected: selected == e.key,
            onTap: () => setState(() {
              choose(e.key);
              error = null;
            }),
          ),
      ],
    );
    final i = page == 6 ? 3 : 6;
    return Scaffold(
      appBar: editing ? AppBar() : null,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: CareTokens.readingWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.all(CareTokens.margin),
              children: [
                Text(s.appName, style: CareTokens.brand),
                const Divider(),
                const SizedBox(height: CareTokens.section),
                Text(
                  editing ? '${page - 5} / 2' : '${page + 1} / 9',
                  style: CareTokens.label,
                ),
                Text(title, style: CareTokens.heading),
                const SizedBox(height: CareTokens.margin),
                Form(
                  key: form,
                  child: Column(
                    key: ValueKey(status),
                    children: [
                      switch (page) {
                        0 => choices(
                          {'en': 'English', 'hi': 'हिन्दी', 'pa': 'ਪੰਜਾਬੀ'},
                          Localizations.localeOf(context).languageCode,
                          ref.read(languageProvider.notifier).select,
                        ),
                        1 => field(0, s.nameLabel),
                        2 => Column(
                          children: [
                            field(
                              1,
                              s.heightLabel,
                              keyboard: TextInputType.number,
                            ),
                            field(
                              2,
                              s.ageLabel,
                              keyboard: TextInputType.number,
                            ),
                          ],
                        ),
                        3 => choices(
                          {
                            'hip': s.hip,
                            'knee': s.knee,
                            'ankle': s.ankle,
                            'joint': s.joint,
                            'stroke': s.stroke,
                          },
                          injury,
                          (v) => injury = v,
                        ),
                        4 => OutlinedButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: date ?? now,
                              firstDate: DateTime(now.year - 100),
                              lastDate: now,
                            );
                            if (picked != null && mounted) {
                              setState(() {
                                date = picked;
                                error = null;
                              });
                            }
                          },
                          child: Text(
                            date == null
                                ? s.dateLabel
                                : MaterialLocalizations.of(context)
                                      .formatFullDate(date!),
                          ),
                        ),
                        5 => choices(
                          {
                            'left': s.leftSide,
                            'right': s.rightSide,
                            'both': s.bothSides,
                          },
                          side,
                          (v) => side = v,
                        ),
                        6 || 7 => Column(
                          children: [
                            Text(s.contactNote),
                            const SizedBox(height: CareTokens.margin),
                            field(i, s.nameLabel),
                            field(
                              i + 1,
                              s.phone,
                              keyboard: TextInputType.phone,
                            ),
                            field(i + 2, s.relationship),
                          ],
                        ),
                        _ => field(9, s.codeLabel),
                      },
                    ],
                  ),
                ),
                if (error != null)
                  Text(
                    error!,
                    style: CareTokens.body.copyWith(color: CareTokens.alert),
                  ),
                const SizedBox(height: CareTokens.margin),
                FilledButton(
                  onPressed: saving ? null : advance,
                  child: Text(
                    page == (editing ? 7 : 8) ? s.finishSetup : s.nextStep,
                  ),
                ),
                if (page == 0 && !editing) const SampleWeekButton(),
                if (page > (editing ? 6 : 0))
                  TextButton(
                    onPressed: saving
                        ? null
                        : () => setState(() {
                            page--;
                            error = null;
                          }),
                    child: Text(
                      MaterialLocalizations.of(context).backButtonTooltip,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
