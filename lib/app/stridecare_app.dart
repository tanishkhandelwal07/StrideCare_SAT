import 'package:material_ui/material_ui.dart';
import 'package:stridecare/design/theme.dart';
import 'package:stridecare/l10n/generated/app_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/profile/profile.dart';
import '../features/settings/presentation/settings_page.dart';

import 'dart:math' as math;

import '../features/walk/walk_views.dart';
import '../features/clinic/clinic_page.dart';
import '../features/safety/family_page.dart';

class StrideCareApp extends ConsumerWidget {
  const StrideCareApp({super.key, this.locale, this.patientOnly = false});
  final bool patientOnly;
  final Locale? locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final language = ref.watch(languageProvider) ?? profile.value?.locale;
    final scale = ref.watch(sizeProvider).value ?? 1;
    return MaterialApp(
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: TextScaler.linear(
              math.max(scale, media.textScaler.scale(18) / 18),
            ),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      theme: careTheme(),
      locale: language == null ? locale : Locale(language),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: !patientOnly && Uri.base.queryParameters['view'] == 'family'
          ? const FamilyPage()
          : !patientOnly && Uri.base.queryParameters['view'] == 'clinic'
          ? const ClinicPage()
          : profile.when(
              data: (p) => p == null ? const Onboarding() : const WalkShell(),
              loading: () => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
              error: (_, _) => Builder(
                builder: (ctx) => Scaffold(
                  body: Center(
                    child: TextButton(
                      onPressed: () => ref.invalidate(profileProvider),
                      child: Text(AppLocalizations.of(ctx).saveError),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
