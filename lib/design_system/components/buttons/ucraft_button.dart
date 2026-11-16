// Flutter 3.50 transitional deprecation; keep SDK material import without extra deps.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../../themes/ucraft_theme.dart';
import '../../tokens/ucraft_colors.dart';
import '../../tokens/ucraft_elevation.dart';
import '../../tokens/ucraft_motion.dart';
import '../../tokens/ucraft_radius.dart';
import '../../tokens/ucraft_spacing.dart';
import '../../tokens/ucraft_typography.dart';

/// Supported visual variants for [UcraftButton].
enum UcraftButtonVariant { primary, secondary, tertiary, destructive }

/// Canonical uCraft Design System 1.0 button with loading and state support.
final class UcraftButton extends StatelessWidget {
  const UcraftButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = UcraftButtonVariant.primary,
    this.isLoading = false,
    this.fullWidth = false,
    this.leadingIcon,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final UcraftButtonVariant variant;
  final bool isLoading;
  final bool fullWidth;
  final IconData? leadingIcon;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    final brightness = Theme.of(context).brightness;
    final isDisabled = onPressed == null && !isLoading;
    final isInteractive = onPressed != null && !isLoading;
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final double visualHeight = variant == UcraftButtonVariant.tertiary
        ? 44
        : 48;
    final Color foregroundColor = _resolveForeground(
      colors: colors,
      brightness: brightness,
      isDisabled: isDisabled,
    );

    final style = ButtonStyle(
      animationDuration: disableAnimations
          ? Duration.zero
          : UcraftMotion.buttonFeedback,
      tapTargetSize: MaterialTapTargetSize.padded,
      minimumSize: WidgetStatePropertyAll(Size(48, visualHeight)),
      maximumSize: WidgetStatePropertyAll(Size(double.infinity, visualHeight)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: UcraftSpacing.buttonHorizontalPadding),
      ),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: UcraftRadius.borderSm),
      ),
      elevation: const WidgetStatePropertyAll(0),
      shadowColor: const WidgetStatePropertyAll(Colors.transparent),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        return _resolveBackground(
          colors: colors,
          states: states,
          isDisabled: isDisabled,
        );
      }),
      foregroundColor: WidgetStatePropertyAll(foregroundColor),
      side: WidgetStateProperty.resolveWith((states) {
        return _resolveBorder(
          colors: colors,
          states: states,
          isDisabled: isDisabled,
        );
      }),
      textStyle: WidgetStatePropertyAll(
        UcraftTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
    );

    final Widget content = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 16, color: foregroundColor),
          const SizedBox(width: UcraftSpacing.iconLabelGap),
        ],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

    final Widget buttonBody = Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !isLoading,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: content,
        ),
        if (isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
      ],
    );

    final Widget button = TextButton(
      onPressed: isInteractive ? onPressed : (isLoading ? () {} : null),
      style: style,
      child: buttonBody,
    );

    final Widget sized = SizedBox(
      width: fullWidth ? double.infinity : null,
      height: visualHeight,
      child: button,
    );

    final Widget touchTarget = variant == UcraftButtonVariant.tertiary
        ? ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: Center(widthFactor: fullWidth ? null : 1, child: sized),
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: sized,
          );

    return Semantics(
      button: true,
      enabled: isInteractive,
      label: semanticLabel ?? label,
      child: AbsorbPointer(absorbing: isLoading, child: touchTarget),
    );
  }

  Color _resolveForeground({
    required UcraftColors colors,
    required Brightness brightness,
    required bool isDisabled,
  }) {
    if (isDisabled) {
      return colors.disabledForeground;
    }
    return switch (variant) {
      UcraftButtonVariant.primary => colors.onPrimary,
      UcraftButtonVariant.secondary => colors.foreground,
      UcraftButtonVariant.tertiary => colors.primary,
      UcraftButtonVariant.destructive =>
        brightness == Brightness.dark
            ? UcraftBrandColors.midnight
            : UcraftBrandColors.white,
    };
  }

  Color _resolveBackground({
    required UcraftColors colors,
    required Set<WidgetState> states,
    required bool isDisabled,
  }) {
    if (isDisabled) {
      return variant == UcraftButtonVariant.tertiary
          ? Colors.transparent
          : colors.disabledBackground;
    }

    final isPressed = states.contains(WidgetState.pressed);
    final isHovered = states.contains(WidgetState.hovered);

    return switch (variant) {
      UcraftButtonVariant.primary =>
        isPressed
            ? colors.primaryPressed
            : isHovered
            ? colors.primaryHover
            : colors.primary,
      UcraftButtonVariant.secondary =>
        isPressed || isHovered ? colors.surfaceSecondary : colors.surface,
      UcraftButtonVariant.tertiary =>
        isPressed || isHovered ? colors.surfaceSecondary : Colors.transparent,
      UcraftButtonVariant.destructive =>
        isPressed
            ? colors.destructive.withValues(alpha: 0.85)
            : isHovered
            ? colors.destructive.withValues(alpha: 0.92)
            : colors.destructive,
    };
  }

  BorderSide _resolveBorder({
    required UcraftColors colors,
    required Set<WidgetState> states,
    required bool isDisabled,
  }) {
    if (states.contains(WidgetState.focused) && !isDisabled) {
      return BorderSide(
        color: colors.focusRing,
        width: UcraftElevation.borderFocus,
      );
    }

    if (variant == UcraftButtonVariant.secondary) {
      return BorderSide(
        color: isDisabled ? colors.border : colors.borderStrong,
        width: UcraftElevation.borderStrong,
      );
    }

    return BorderSide.none;
  }
}

