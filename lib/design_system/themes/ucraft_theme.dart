import 'package:material_ui/material_ui.dart';

import '../tokens/ucraft_colors.dart';
import '../tokens/ucraft_elevation.dart';
import '../tokens/ucraft_radius.dart';
import '../tokens/ucraft_typography.dart';

/// Builds Material 3 themes with uCraft's semantic colors and typography.
abstract final class UcraftTheme {
  static ThemeData light() =>
      material3(brightness: Brightness.light, colors: UcraftColors.light);

  static ThemeData dark() =>
      material3(brightness: Brightness.dark, colors: UcraftColors.dark);

  static ThemeData material3({
    required Brightness brightness,
    required UcraftColors colors,
    VisualDensity visualDensity = VisualDensity.standard,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primarySubtle,
      onPrimaryContainer: colors.foreground,
      secondary: colors.primary,
      onSecondary: colors.onPrimary,
      secondaryContainer: colors.primarySubtle,
      onSecondaryContainer: colors.foreground,
      error: colors.destructive,
      onError: brightness == Brightness.light
          ? UcraftBrandColors.white
          : UcraftBrandColors.midnight,
      surface: colors.surface,
      onSurface: colors.foreground,
      onSurfaceVariant: colors.foregroundSecondary,
      surfaceContainerLowest: colors.surface,
      surfaceContainerLow: colors.background,
      surfaceContainer: colors.surfaceSecondary,
      surfaceContainerHigh: colors.surfaceSecondary,
      surfaceContainerHighest: colors.surfaceTertiary,
      outline: colors.borderStrong,
      outlineVariant: colors.border,
      errorContainer: colors.destructiveBackground,
      onErrorContainer: colors.destructiveForeground,
    );

    return ThemeData(
      useMaterial3: true,
      visualDensity: visualDensity,
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
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: const RoundedRectangleBorder(
          borderRadius: UcraftRadius.border2xl,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        modalBackgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(UcraftRadius.xxl),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        elevation: 0,
        height: 64,
        indicatorColor: colorScheme.secondaryContainer,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 24,
            color: selected ? colors.primary : colors.foregroundMuted,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return UcraftTypography.caption.copyWith(
            fontWeight: FontWeight.w500,
            color: selected ? colors.primary : colors.foregroundMuted,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surface,
        elevation: 0,
        indicatorColor: colors.primarySubtle,
        selectedIconTheme: IconThemeData(size: 24, color: colors.primary),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: colors.foregroundMuted,
        ),
        selectedLabelTextStyle: UcraftTypography.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.primary,
        ),
        unselectedLabelTextStyle: UcraftTypography.caption.copyWith(
          fontWeight: FontWeight.w500,
          color: colors.foregroundMuted,
        ),
      ),
      extensions: [colors],
    );
  }
}

/// Convenient semantic token lookup via `context.ucraftColors`.
extension UcraftThemeContext on BuildContext {
  bool get ucraftCompact =>
      Theme.of(this).visualDensity == VisualDensity.compact;

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
