import 'package:material_ui/material_ui.dart';

/// Canonical brand colors of uCraft Design System 1.0 (Midnight & Cobalt).
///
/// Screens and widgets should prefer semantic tokens from [UcraftColors]
/// rather than referencing raw brand colors directly.
abstract final class UcraftBrandColors {
  static const Color cobalt = Color(0xFF507DE8);
  static const Color cobaltDark = Color(0xFF3563CC);
  static const Color cobaltDeep = Color(0xFF244DA8);
  static const Color cobaltLight = Color(0xFFEAF0FF);

  static const Color midnight = Color(0xFF111827);
  static const Color slate = Color(0xFF1F2937);
  static const Color slateLight = Color(0xFF374151);

  static const Color snow = Color(0xFFF9FAFB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color mutedGray = Color(0xFF9CA3AF);
}

/// Semantic color tokens for Light and Dark themes.
@immutable
final class UcraftColors extends ThemeExtension<UcraftColors> {
  const UcraftColors({
    required this.background,
    required this.surface,
    required this.surfaceSecondary,
    required this.surfaceTertiary,
    required this.foreground,
    required this.foregroundSecondary,
    required this.foregroundMuted,
    required this.border,
    required this.borderStrong,
    required this.primary,
    required this.primaryHover,
    required this.primaryPressed,
    required this.primarySubtle,
    required this.onPrimary,
    required this.accent,
    required this.focusRing,
    required this.disabledBackground,
    required this.disabledForeground,
    required this.overlay,
    required this.success,
    required this.successBackground,
    required this.successForeground,
    required this.warning,
    required this.warningBackground,
    required this.warningForeground,
    required this.destructive,
    required this.destructiveBackground,
    required this.destructiveForeground,
    required this.info,
    required this.infoBackground,
    required this.infoForeground,
  });

  /// Light theme semantic color tokens (default).
  static const UcraftColors light = UcraftColors(
    background: UcraftBrandColors.snow,
    surface: UcraftBrandColors.white,
    surfaceSecondary: Color(0xFFF3F4F6),
    surfaceTertiary: Color(0xFFE5E7EB),
    foreground: UcraftBrandColors.midnight,
    foregroundSecondary: Color(0xFF4B5563),
    foregroundMuted: Color(0xFF6B7280),
    border: Color(0xFFE5E7EB),
    borderStrong: Color(0xFFD1D5DB),
    primary: UcraftBrandColors.cobaltDark,
    primaryHover: UcraftBrandColors.cobaltDeep,
    primaryPressed: Color(0xFF1D408D),
    primarySubtle: UcraftBrandColors.cobaltLight,
    onPrimary: UcraftBrandColors.white,
    accent: UcraftBrandColors.cobalt,
    focusRing: UcraftBrandColors.cobaltDark,
    disabledBackground: Color(0xFFE5E7EB),
    disabledForeground: Color(0xFF6B7280),
    overlay: Color(0x7A111827), // #111827 at 48% opacity
    success: Color(0xFF15803D),
    successBackground: Color(0xFFDCFCE7),
    successForeground: Color(0xFF166534),
    warning: Color(0xFFA16207),
    warningBackground: Color(0xFFFEF3C7),
    warningForeground: Color(0xFF854D0E),
    destructive: Color(0xFFB91C1C),
    destructiveBackground: Color(0xFFFEE2E2),
    destructiveForeground: Color(0xFF991B1B),
    info: Color(0xFF1D4ED8),
    infoBackground: Color(0xFFDBEAFE),
    infoForeground: Color(0xFF1E40AF),
  );

  /// Dark theme semantic color tokens.
  static const UcraftColors dark = UcraftColors(
    background: UcraftBrandColors.midnight,
    surface: UcraftBrandColors.slate,
    surfaceSecondary: Color(0xFF273244),
    surfaceTertiary: UcraftBrandColors.slateLight,
    foreground: UcraftBrandColors.snow,
    foregroundSecondary: Color(0xFFD1D5DB),
    foregroundMuted: UcraftBrandColors.mutedGray,
    border: UcraftBrandColors.slateLight,
    borderStrong: Color(0xFF4B5563),
    primary: Color(0xFF82A5FF),
    primaryHover: Color(0xFFA6BEFF),
    primaryPressed: Color(0xFF668BE8),
    primarySubtle: Color(0xFF243554),
    onPrimary: UcraftBrandColors.midnight,
    accent: UcraftBrandColors.cobalt,
    focusRing: Color(0xFFA6BEFF),
    disabledBackground: UcraftBrandColors.slateLight,
    disabledForeground: UcraftBrandColors.mutedGray,
    overlay: Color(0x99000000), // #000000 at 60% opacity
    success: Color(0xFF4ADE80),
    successBackground: Color(0xFF143D2B),
    successForeground: Color(0xFF86EFAC),
    warning: Color(0xFFFBBF24),
    warningBackground: Color(0xFF453316),
    warningForeground: Color(0xFFFDE68A),
    destructive: Color(0xFFF87171),
    destructiveBackground: Color(0xFF4A2026),
    destructiveForeground: Color(0xFFFCA5A5),
    info: Color(0xFF93C5FD),
    infoBackground: Color(0xFF1E3558),
    infoForeground: Color(0xFFBFDBFE),
  );

  /// The approved softened palette used for the Material 3 app themes.
  static final UcraftColors softLight = light.copyWith(
    background: const Color(0xFFF5F7FA),
    surfaceSecondary: const Color(0xFFECF1F8),
    surfaceTertiary: const Color(0xFFD7DFED),
    foreground: const Color(0xFF151D2B),
    foregroundSecondary: const Color(0xFF526078),
    foregroundMuted: const Color(0xFF526078),
    border: const Color(0xFFCCD6E4),
    borderStrong: const Color(0xFF7989A4),
    primary: const Color(0xFF315FCB),
    primaryHover: const Color(0xFF244CAA),
    primaryPressed: const Color(0xFF244CAA),
    primarySubtle: const Color(0xFFE4EBF7),
    accent: const Color(0xFF315FCB),
    focusRing: const Color(0xFF315FCB),
    disabledBackground: const Color(0xFFE3EAF7),
    disabledForeground: const Color(0xFF4E608D),
    success: const Color(0xFF116443),
    successBackground: const Color(0xFFE0F6EC),
    successForeground: const Color(0xFF116443),
    warning: const Color(0xFF835219),
    warningBackground: const Color(0xFFFFF0D8),
    warningForeground: const Color(0xFF835219),
    destructive: const Color(0xFFA82B3B),
    destructiveBackground: const Color(0xFFFFEBEF),
    destructiveForeground: const Color(0xFFA82B3B),
  );

  static final UcraftColors softDark = dark.copyWith(
    background: const Color(0xFF111827),
    surface: const Color(0xFF1E293B),
    surfaceSecondary: const Color(0xFF283548),
    surfaceTertiary: const Color(0xFF334155),
    border: const Color(0xFF334155),
    borderStrong: const Color(0xFF64748B),
    foreground: const Color(0xFFF8FAFC),
    foregroundSecondary: const Color(0xFFCBD5E1),
    foregroundMuted: const Color(0xFF94A3B8),
    primary: const Color(0xFF315FCB),
    primaryHover: const Color(0xFF244CAA),
    primaryPressed: const Color(0xFF1D408D),
    onPrimary: const Color(0xFFFFFFFF),
    primarySubtle: const Color(0xFF1D3158),
    accent: const Color(0xFF7AA2FF),
    focusRing: const Color(0xFF7AA2FF),
    disabledBackground: const Color(0xFF283548),
    disabledForeground: const Color(0xFF64748B),
    success: const Color(0xFF34D399),
    successBackground: const Color(0xFF133829),
    successForeground: const Color(0xFF6EE7B7),
    warning: const Color(0xFFFBBF24),
    warningBackground: const Color(0xFF3F2E12),
    warningForeground: const Color(0xFFFDE68A),
    destructive: const Color(0xFFEF4444),
    destructiveBackground: const Color(0xFF451A23),
    destructiveForeground: const Color(0xFFFDA4AF),
    info: const Color(0xFF60A5FA),
    infoBackground: const Color(0xFF1E3558),
    infoForeground: const Color(0xFFBFDBFE),
  );

  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color surfaceTertiary;
  final Color foreground;
  final Color foregroundSecondary;
  final Color foregroundMuted;
  final Color border;
  final Color borderStrong;
  final Color primary;
  final Color primaryHover;
  final Color primaryPressed;
  final Color primarySubtle;
  final Color onPrimary;
  final Color accent;
  final Color focusRing;
  final Color disabledBackground;
  final Color disabledForeground;
  final Color overlay;
  final Color success;
  final Color successBackground;
  final Color successForeground;
  final Color warning;
  final Color warningBackground;
  final Color warningForeground;
  final Color destructive;
  final Color destructiveBackground;
  final Color destructiveForeground;
  final Color info;
  final Color infoBackground;
  final Color infoForeground;

  @override
  UcraftColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceSecondary,
    Color? surfaceTertiary,
    Color? foreground,
    Color? foregroundSecondary,
    Color? foregroundMuted,
    Color? border,
    Color? borderStrong,
    Color? primary,
    Color? primaryHover,
    Color? primaryPressed,
    Color? primarySubtle,
    Color? onPrimary,
    Color? accent,
    Color? focusRing,
    Color? disabledBackground,
    Color? disabledForeground,
    Color? overlay,
    Color? success,
    Color? successBackground,
    Color? successForeground,
    Color? warning,
    Color? warningBackground,
    Color? warningForeground,
    Color? destructive,
    Color? destructiveBackground,
    Color? destructiveForeground,
    Color? info,
    Color? infoBackground,
    Color? infoForeground,
  }) {
    return UcraftColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      foreground: foreground ?? this.foreground,
      foregroundSecondary: foregroundSecondary ?? this.foregroundSecondary,
      foregroundMuted: foregroundMuted ?? this.foregroundMuted,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      primarySubtle: primarySubtle ?? this.primarySubtle,
      onPrimary: onPrimary ?? this.onPrimary,
      accent: accent ?? this.accent,
      focusRing: focusRing ?? this.focusRing,
      disabledBackground: disabledBackground ?? this.disabledBackground,
      disabledForeground: disabledForeground ?? this.disabledForeground,
      overlay: overlay ?? this.overlay,
      success: success ?? this.success,
      successBackground: successBackground ?? this.successBackground,
      successForeground: successForeground ?? this.successForeground,
      warning: warning ?? this.warning,
      warningBackground: warningBackground ?? this.warningBackground,
      warningForeground: warningForeground ?? this.warningForeground,
      destructive: destructive ?? this.destructive,
      destructiveBackground:
          destructiveBackground ?? this.destructiveBackground,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      info: info ?? this.info,
      infoBackground: infoBackground ?? this.infoBackground,
      infoForeground: infoForeground ?? this.infoForeground,
    );
  }

  @override
  UcraftColors lerp(covariant ThemeExtension<UcraftColors>? other, double t) {
    if (other is! UcraftColors) {
      return this;
    }
    return UcraftColors(
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceSecondary:
          Color.lerp(surfaceSecondary, other.surfaceSecondary, t) ??
          surfaceSecondary,
      surfaceTertiary:
          Color.lerp(surfaceTertiary, other.surfaceTertiary, t) ??
          surfaceTertiary,
      foreground: Color.lerp(foreground, other.foreground, t) ?? foreground,
      foregroundSecondary:
          Color.lerp(foregroundSecondary, other.foregroundSecondary, t) ??
          foregroundSecondary,
      foregroundMuted:
          Color.lerp(foregroundMuted, other.foregroundMuted, t) ??
          foregroundMuted,
      border: Color.lerp(border, other.border, t) ?? border,
      borderStrong:
          Color.lerp(borderStrong, other.borderStrong, t) ?? borderStrong,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryHover:
          Color.lerp(primaryHover, other.primaryHover, t) ?? primaryHover,
      primaryPressed:
          Color.lerp(primaryPressed, other.primaryPressed, t) ?? primaryPressed,
      primarySubtle:
          Color.lerp(primarySubtle, other.primarySubtle, t) ?? primarySubtle,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      focusRing: Color.lerp(focusRing, other.focusRing, t) ?? focusRing,
      disabledBackground:
          Color.lerp(disabledBackground, other.disabledBackground, t) ??
          disabledBackground,
      disabledForeground:
          Color.lerp(disabledForeground, other.disabledForeground, t) ??
          disabledForeground,
      overlay: Color.lerp(overlay, other.overlay, t) ?? overlay,
      success: Color.lerp(success, other.success, t) ?? success,
      successBackground:
          Color.lerp(successBackground, other.successBackground, t) ??
          successBackground,
      successForeground:
          Color.lerp(successForeground, other.successForeground, t) ??
          successForeground,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      warningBackground:
          Color.lerp(warningBackground, other.warningBackground, t) ??
          warningBackground,
      warningForeground:
          Color.lerp(warningForeground, other.warningForeground, t) ??
          warningForeground,
      destructive: Color.lerp(destructive, other.destructive, t) ?? destructive,
      destructiveBackground:
          Color.lerp(destructiveBackground, other.destructiveBackground, t) ??
          destructiveBackground,
      destructiveForeground:
          Color.lerp(destructiveForeground, other.destructiveForeground, t) ??
          destructiveForeground,
      info: Color.lerp(info, other.info, t) ?? info,
      infoBackground:
          Color.lerp(infoBackground, other.infoBackground, t) ?? infoBackground,
      infoForeground:
          Color.lerp(infoForeground, other.infoForeground, t) ?? infoForeground,
    );
  }
}
