import 'package:material_ui/material_ui.dart';
import 'package:stridecare/l10n/generated/app_localizations.dart';

import 'tokens.dart';

class SectionPage extends StatelessWidget {
  const SectionPage({
    super.key,
    required this.title,
    required this.message,
    this.footer,
    this.illustration,
    this.content,
  });
  final String title;
  final String message;
  final String? footer;
  final Widget? illustration;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    final intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: CareTokens.stroke,
          width: CareTokens.accentWidth,
          color: CareTokens.marigold,
        ),
        const SizedBox(height: CareTokens.inset),
        Semantics(header: true, child: Text(title, style: CareTokens.heading)),
        const SizedBox(height: CareTokens.gap),
        Text(message, style: CareTokens.body),
        ?illustration,
      ],
    );
    final workspace = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ?content,
        if (footer case final advice?) ...[
          const SizedBox(height: CareTokens.inset),
          Text(
            advice,
            style: CareTokens.body.copyWith(color: CareTokens.muted),
          ),
        ],
      ],
    );
    return ListView(
      key: ValueKey(title),
      padding: const EdgeInsets.all(CareTokens.margin),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: CareTokens.maxWidth),
            child: Semantics(
              container: true,
              explicitChildNodes: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: CareTokens.margin,
                    runSpacing: CareTokens.gap,
                    children: [
                      Text(
                        AppLocalizations.of(context).appName,
                        style: CareTokens.brand,
                      ),
                      Text(
                        MaterialLocalizations.of(context)
                            .formatFullDate(DateTime.now()),
                        style: CareTokens.label.copyWith(
                          color: CareTokens.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: CareTokens.inset),
                  const Divider(),
                  const SizedBox(height: CareTokens.section),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= CareTokens.spreadWidth &&
                          MediaQuery.textScalerOf(context)
                                  .scale(CareTokens.bodySize) <=
                              CareTokens.brandSize) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 2, child: intro),
                            const SizedBox(width: CareTokens.section),
                            Expanded(flex: 3, child: workspace),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          intro,
                          const SizedBox(height: CareTokens.margin),
                          workspace,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
