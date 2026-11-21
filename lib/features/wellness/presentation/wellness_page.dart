import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design/section_page.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../storage/care_database.dart';
import '../../clinic/targets.dart';

final mealProvider = FutureProvider.family<bool, String>(
  (ref, key) async => await ref.watch(databaseProvider).preference(key) == '1',
);

class WellnessPage extends ConsumerWidget {
  const WellnessPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppLocalizations.of(context),
        key = 'meal-${DateUtils.dateOnly(DateTime.now()).toIso8601String()}';
    return SectionPage(
      title: s.wellness,
      message: s.wellnessHint,
      footer: s.wellnessAdvice,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.meal, style: Theme.of(context).textTheme.headlineSmall),
          ExpansionTile(title: Text(s.recipe), children: [Text(s.recipeSteps)]),
          ExpansionTile(title: Text(s.eggMeal), children: [Text(s.eggSteps)]),
          CheckboxListTile(
            title: Text(s.logged),
            value: ref.watch(mealProvider(key)).value ?? false,
            onChanged: (v) async {
              await ref
                  .read(databaseProvider)
                  .setPreference(key, v == true ? '1' : '0');
              if (context.mounted) ref.invalidate(mealProvider(key));
            },
          ),
          Text(s.supplement),
          const Divider(),
          ListTile(
            leading: Icon(
              ref.watch(targetsProvider).value?.breathing == true
                  ? Icons.check
                  : Icons.lock_outline,
            ),
            title: Text(
              ref.watch(targetsProvider).value?.breathing == true
                  ? s.breathing
                  : s.approvalLock,
            ),
          ),
        ],
      ),
    );
  }
}
