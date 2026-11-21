import 'package:material_ui/material_ui.dart';

abstract final class CareTokens {
  static const paper = Color(0xFFFAF6F0);
  static const surface = Color(0xFFFFFFFF);
  static const rule = Color(0xFFE8E0D4);
  static const teal = Color(0xFF1F5F5B);
  static const marigold = Color(0xFFD9822B);
  static const ink = Color(0xFF2B2B2B);
  static const muted = Color(0xFF6B645B);
  static const alert = Color(0xFFC8503E);

  static const serif = 'Fraunces';
  static const sans = 'Nunito Sans';
  static const fallback = ['Noto Sans Devanagari', 'Noto Sans Gurmukhi'];
  static const bodySize = 18.0;
  static const labelSize = 17.0;
  static const brandSize = 26.0;
  static const titleSize = 48.0;
  static const hairline = 1.0;
  static const stroke = 2.0;
  static const flat = 0.0;
  static const small = 4.0;
  static const gap = 8.0;
  static const inset = 16.0;
  static const margin = 24.0;
  static const section = 36.0;
  static const touch = 56.0;
  static const illustrationSize = 96.0;
  static const icon = 24.0;
  static const maxWidth = 1040.0;
  static const spreadWidth = 760.0;
  static const metricSize = 68.0;
  static const corner = 8.0;
  static const readingWidth = 490.0;
  static const accentWidth = 32.0;
  static const lowHeight = 440.0;

  static const body = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: fallback,
    fontSize: bodySize,
    height: 1.5,
    color: ink,
  );
  static const label = TextStyle(
    fontFamily: sans,
    fontFamilyFallback: fallback,
    fontSize: labelSize,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
  static const heading = TextStyle(
    fontFamily: serif,
    fontFamilyFallback: fallback,
    fontSize: titleSize,
    height: 1.16,
    color: ink,
    fontWeight: FontWeight.w500,
  );
  static const brand = TextStyle(
    fontFamily: serif,
    fontFamilyFallback: fallback,
    fontSize: brandSize,
    color: teal,
    fontWeight: FontWeight.w600,
  );
  static const figures = TextStyle(
    fontFamily: serif,
    fontFamilyFallback: fallback,
    fontSize: titleSize,
    color: ink,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const border = BorderSide(color: rule, width: hairline);
}
