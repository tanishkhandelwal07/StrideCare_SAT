import '../../../design/tokens.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design/section_page.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../storage/care_database.dart';
import '../../clinic/targets.dart';

final mealProvider = FutureProvider.family<bool, String>(
  (ref, key) async => await ref.watch(databaseProvider).preference(key) == '1',
);

class WellnessPage extends ConsumerStatefulWidget {
  const WellnessPage({super.key});
  @override
  ConsumerState<WellnessPage> createState() => _WellnessState();
}

class _WellnessState extends ConsumerState<WellnessPage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context),
        key = 'meal-${DateUtils.dateOnly(DateTime.now()).toIso8601String()}';
    final cuisines = [
      s.northIndian,
      s.southIndian,
      s.mediterranean,
      s.eastAsian,
    ];
    final recipes = [
      [(s.recipe, s.recipeSteps), (s.eggMeal, s.eggSteps)],
      [(s.idli, s.idliMethod), (s.fish, s.fishMethod)],
      [(s.beans, s.beansMethod), (s.chicken, s.chickenMethod)],
      [(s.tofu, s.tofuMethod), (s.salmon, s.salmonMethod)],
    ];
    return SectionPage(
      title: s.wellness,
      message: s.wellnessHint,
      footer: s.wellnessAdvice,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.meal, style: Theme.of(context).textTheme.headlineSmall),
          Wrap(
            children: [
              for (var i = 0; i < cuisines.length; i++)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: CareTokens.gap,
                  ),
                  child: ChoiceChip(
                    label: Text(cuisines[i]),
                    selected: selected == i,
                    onSelected: (_) => setState(() => selected = i),
                  ),
                ),
            ],
          ),
          for (final recipe in recipes[selected])
            ExpansionTile(
              key: ValueKey(recipe.$1),
              title: Text(recipe.$1),
              children: [
                Padding(
                  padding: const EdgeInsets.all(CareTokens.inset),
                  child: Text(recipe.$2),
                ),
              ],
            ),
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
