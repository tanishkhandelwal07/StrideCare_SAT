import 'package:material_ui/material_ui.dart';

import 'tokens.dart';

ThemeData careTheme() {
  const scheme = ColorScheme.light(
    primary: CareTokens.teal,
    onPrimary: CareTokens.surface,
    secondary: CareTokens.marigold,
    onSecondary: CareTokens.ink,
    surface: CareTokens.surface,
    onSurface: CareTokens.ink,
    onSurfaceVariant: CareTokens.muted,
    outline: CareTokens.rule,
    error: CareTokens.alert,
    onError: CareTokens.surface,
    surfaceTint: CareTokens.surface,
  );
  return ThemeData(
    useMaterial3: true,
    fontFamily: CareTokens.sans,
    fontFamilyFallback: CareTokens.fallback,
    colorScheme: scheme,
    scaffoldBackgroundColor: CareTokens.paper,
    textTheme: const TextTheme(
      headlineLarge: CareTokens.heading,
      displayMedium: CareTokens.figures,
      bodyLarge: CareTokens.body,
      bodyMedium: CareTokens.body,
      labelLarge: CareTokens.label,
    ),
    dividerTheme: const DividerThemeData(
      color: CareTokens.rule,
      thickness: CareTokens.hairline,
      space: CareTokens.hairline,
    ),
    cardTheme: const CardThemeData(
      color: CareTokens.surface,
      elevation: CareTokens.flat,
      shape: RoundedRectangleBorder(side: CareTokens.border),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(CareTokens.touch, CareTokens.touch),
        textStyle: CareTokens.label,
      ),
    ),
  );
}
