import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;

import '../../../design/section_page.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../storage/care_database.dart';
import '../../profile/profile.dart';
import '../../clinic/targets.dart';
import '../../walk/walk_views.dart';

final connectedAccountProvider = Provider<bool>((ref) => false);

final sizeProvider = FutureProvider<double>(
  (ref) async =>
      double.tryParse(
        await ref.watch(databaseProvider).preference('textSize') ?? '',
      ) ??
      1,
);

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context), db = ref.watch(databaseProvider);
    return SectionPage(
      title: s.settings,
      message: s.settingsHint,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const PairCane()),
            ),
            child: Text(s.pairTitle),
          ),
          const Divider(),
          Text(s.language),
          DropdownButton<String>(
            value: Localizations.localeOf(context).languageCode,
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'hi', child: Text('हिन्दी')),
              DropdownMenuItem(value: 'pa', child: Text('ਪੰਜਾਬੀ')),
            ],
            onChanged: (v) async {
              if (v == null) return;
              ref.read(languageProvider.notifier).select(v);
              await db.update(db.users).write(UsersCompanion(locale: Value(v)));
            },
          ),
          const Divider(),
          TextButton(
            onPressed: () async {
              final contacts = await db.select(db.emergencyContacts).get();
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => Onboarding(contacts: contacts),
                  ),
                );
              }
            },
            child: Text(s.contactEdit),
          ),
          Text(
            ref.watch(connectedAccountProvider) ? s.sharedPrivacy : s.privacy,
          ),
          if (ref.watch(connectedAccountProvider)) ...[
            const Divider(),
            Text(s.targets),
            if (ref.watch(targetsProvider).value?.maxSpeed case final speed?)
              Text('${s.maxSpeed} · ${speed.toStringAsFixed(2)}'),
            if (ref.watch(targetsProvider).value?.maxCadence
                case final cadence?)
              Text('${s.maxCadence} · ${cadence.round()}'),
          ],
          const Divider(),
          Text(s.textSize),
          DropdownButton<double>(
            value: ref.watch(sizeProvider).value ?? 1,
            items: [
              for (final scale in [1.0, 1.25, 1.5, 2.0])
                DropdownMenuItem(
                  value: scale,
                  child: Text('${(scale * 100).round()}%'),
                ),
            ],
            onChanged: (v) async {
              if (v == null) return;
              await db.setPreference('textSize', v.toString());
              if (context.mounted) ref.invalidate(sizeProvider);
            },
          ),
        ],
      ),
    );
  }
}
