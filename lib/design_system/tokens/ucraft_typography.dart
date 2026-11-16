import 'package:material_ui/material_ui.dart';

/// Typography scale and font families for uCraft Design System 1.0.
abstract final class UcraftTypography {
  static const String primaryFontFamily = 'Inter';
  static const String monoFontFamily = 'GeistMono';
  static const List<String> fallbackFontFamilies = ['Roboto'];

  static const TextStyle display = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
  );

  /// Closest Flutter weight to 650 is w600.
  static const TextStyle headline = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );

  static const TextStyle title = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 26 / 18,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static const TextStyle body = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 21 / 14,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 21 / 14,
  );

  static const TextStyle label = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 18 / 13,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 17 / 12,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: primaryFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 16 / 11,
  );

  /// Technical / tabular numeric style using Geist Mono.
  static const TextStyle mono = TextStyle(
    fontFamily: monoFontFamily,
    fontFamilyFallback: fallbackFontFamilies,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 21 / 14,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextTheme buildTextTheme(Color foreground, Color secondary) {
    return TextTheme(
      displayLarge: display.copyWith(color: foreground),
      headlineLarge: headlineLarge.copyWith(color: foreground),
      headlineMedium: headline.copyWith(color: foreground),
      titleLarge: titleLarge.copyWith(color: foreground),
      titleMedium: title.copyWith(color: foreground),
      bodyLarge: bodyLarge.copyWith(color: foreground),
      bodyMedium: body.copyWith(color: foreground),
      labelLarge: label.copyWith(color: foreground),
      bodySmall: caption.copyWith(color: secondary),
      labelSmall: overline.copyWith(color: secondary),
    );
  }
}
