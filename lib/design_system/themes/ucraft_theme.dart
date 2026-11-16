// Flutter 3.50 transitional deprecation; keep SDK material import without extra deps.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../tokens/ucraft_colors.dart';
import '../tokens/ucraft_elevation.dart';
import '../tokens/ucraft_radius.dart';
import '../tokens/ucraft_typography.dart';

/// Builds Material [ThemeData] configured with uCraft Design System 1.0 tokens.
abstract final class UcraftTheme {
  static ThemeData light() =>
      _build(brightness: Brightness.light, colors: UcraftColors.light);

  static ThemeData dark() =>
      _build(brightness: Brightness.dark, colors: UcraftColors.dark);

  static ThemeData _build({
    required Brightness brightness,
    required UcraftColors colors,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.accent,
      onSecondary: colors.onPrimary,
      error: colors.destructive,
      onError: brightness == Brightness.light
          ? UcraftBrandColors.white
          : UcraftBrandColors.midnight,
      surface: colors.surface,
      onSurface: colors.foreground,
      onSurfaceVariant: colors.foregroundSecondary,
      outline: colors.borderStrong,
      outlineVariant: colors.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      fontFamily: UcraftTypography.primaryFontFamily,
      textTheme: UcraftTypography.buildTextTheme(
        colors.foreground,
        colors.foregroundSecondary,
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: UcraftElevation.dividerWidth,
        space: UcraftElevation.dividerWidth,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: UcraftRadius.borderMd,
          side: BorderSide(
            color: colors.border,
            width: UcraftElevation.borderDefault,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      extensions: [colors],
    );
  }
}

/// Convenient semantic token lookup via `context.ucraftColors`.
extension UcraftThemeContext on BuildContext {
  UcraftColors get ucraftColors {
    final extension = Theme.of(this).extension<UcraftColors>();
    if (extension != null) {
      return extension;
    }
    return Theme.of(this).brightness == Brightness.dark
        ? UcraftColors.dark
        : UcraftColors.light;
  }
}
