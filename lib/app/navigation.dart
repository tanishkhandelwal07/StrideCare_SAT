import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stridecare/design/tokens.dart';
import 'package:stridecare/features/today/presentation/today_page.dart';
import 'package:stridecare/features/progress/presentation/progress_page.dart';
import 'package:stridecare/features/wellness/presentation/wellness_page.dart';
import 'package:stridecare/features/medicine/presentation/medicine_page.dart';
import 'package:stridecare/features/settings/presentation/settings_page.dart';
import 'package:stridecare/l10n/generated/app_localizations.dart';

enum CareTab {
  today(Icons.wb_sunny_outlined, TodayPage()),
  progress(Icons.show_chart_outlined, ProgressPage()),
  wellness(Icons.spa_outlined, WellnessPage()),
  medicine(Icons.medication_outlined, MedicinePage()),
  settings(Icons.settings_outlined, SettingsPage());

  const CareTab(this.icon, this.page);
  final IconData icon;
  final Widget page;

  String label(AppLocalizations strings) => switch (this) {
    today => strings.today,
    progress => strings.progress,
    wellness => strings.wellness,
    medicine => strings.medicine,
    settings => strings.settings,
  };
}

class CurrentTab extends Notifier<CareTab> {
  @override
  CareTab build() => CareTab.today;
  void select(CareTab tab) => state = tab;
}

final currentTabProvider = NotifierProvider<CurrentTab, CareTab>(
  CurrentTab.new,
);

class CareNavigation extends ConsumerWidget {
  const CareNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentTabProvider);
    final strings = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(bottom: false, child: current.page),
      bottomNavigationBar: Material(
        color: CareTokens.surface,
        shape: const Border(top: CareTokens.border),
        child: SafeArea(
          top: false,
          child: Align(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: CareTokens.maxWidth),
              child: _TabBar(
                labels: [for (final tab in CareTab.values) tab.label(strings)],
                current: current,
                onSelect: ref.read(currentTabProvider.notifier).select,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.labels,
    required this.current,
    required this.onSelect,
  });
  final List<String> labels;
  final CareTab current;
  final ValueChanged<CareTab> onSelect;

  double _labelWidth(BuildContext context, String label) {
    final text = TextPainter(
      text: TextSpan(text: label, style: CareTokens.label),
      textScaler: MediaQuery.textScalerOf(context),
      textDirection: Directionality.of(context),
    )..layout();
    final width = text.width.ceilToDouble() + CareTokens.gap;
    text.dispose();
    return math.max(CareTokens.touch, width);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        final widths = [
          for (final label in labels) _labelWidth(context, label),
        ];
        final needed = widths.reduce((a, b) => a + b);
        final compactHeight =
            MediaQuery.sizeOf(context).height < CareTokens.lowHeight;
        final singleRow = needed <= available || compactHeight;
        final extra = math.max(0.0, available - needed) / labels.length;
        final columns = (available / widths.reduce(math.max)).floor().clamp(
          1,
          3,
        );
        final children = [
          for (final tab in CareTab.values)
            SizedBox(
              width: singleRow
                  ? widths[tab.index] + extra
                  : available / columns,
              child: _TabButton(
                icon: tab.icon,
                label: labels[tab.index],
                selected: current == tab,
                onTap: () => onSelect(tab),
              ),
            ),
        ];
        if (singleRow) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: children),
          );
        }
        return Wrap(alignment: WrapAlignment.center, children: children);
      },
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? CareTokens.teal : CareTokens.muted;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      onTap: onTap,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: CareTokens.touch),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: CareTokens.gap),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: CareTokens.stroke,
                  width: CareTokens.icon,
                  color: selected ? CareTokens.teal : CareTokens.surface,
                ),
                const SizedBox(height: CareTokens.small),
                Icon(icon, size: CareTokens.icon, color: color),
                const SizedBox(height: CareTokens.small),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: CareTokens.label.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
