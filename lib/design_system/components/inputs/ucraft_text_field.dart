import 'package:material_ui/material_ui.dart';

import '../../themes/ucraft_theme.dart';
import '../../tokens/ucraft_elevation.dart';
import '../../tokens/ucraft_radius.dart';
import '../../tokens/ucraft_spacing.dart';
import '../../tokens/ucraft_typography.dart';

/// Canonical uCraft Design System 1.0 text input with explicit validation states.
final class UcraftTextField extends StatelessWidget {
  const UcraftTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.isSuccess = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
  });

  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool isSuccess;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    final compact = context.ucraftCompact;
    final textStyle = compact
        ? UcraftTypography.body
        : UcraftTypography.bodyLarge;
    final labelStyle = compact
        ? UcraftTypography.label.copyWith(fontWeight: FontWeight.w500)
        : UcraftTypography.label;
    final bool hasError = errorText != null && errorText!.trim().isNotEmpty;
    final themedBorder = InputDecorationTheme.of(context).enabledBorder;

    final Color defaultBorderColor = hasError
        ? colors.destructive
        : isSuccess
        ? colors.success
        : themedBorder?.borderSide.color ?? colors.border;
    final double defaultBorderWidth = (hasError || isSuccess)
        ? UcraftElevation.borderStrong
        : UcraftElevation.borderDefault;
    final Color focusedBorderColor = hasError
        ? colors.destructive
        : colors.focusRing;

    final OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderRadius: UcraftRadius.borderSm,
      borderSide: BorderSide(
        color: defaultBorderColor,
        width: defaultBorderWidth,
      ),
    );

    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: UcraftRadius.borderSm,
      borderSide: BorderSide(
        color: focusedBorderColor,
        width: UcraftElevation.borderFocus,
      ),
    );

    final OutlineInputBorder disabledBorder = OutlineInputBorder(
      borderRadius: UcraftRadius.borderSm,
      borderSide: BorderSide(
        color: colors.border,
        width: UcraftElevation.borderDefault,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: labelStyle.copyWith(color: colors.foreground)),
          SizedBox(
            height: compact ? UcraftSpacing.space1 : UcraftSpacing.space2,
          ),
        ],
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: obscureText ? 1 : maxLines,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: textStyle.copyWith(
            color: enabled ? colors.foreground : colors.disabledForeground,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: enabled ? colors.surface : colors.disabledBackground,
            constraints: BoxConstraints(
              minHeight: compact ? UcraftSpacing.space12 : 52,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: compact ? UcraftSpacing.space3 : 14,
              vertical: compact ? UcraftSpacing.space2 : 14,
            ),
            hintText: hintText,
            hintStyle: textStyle.copyWith(color: colors.foregroundMuted),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: enabledBorder,
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            disabledBorder: disabledBorder,
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: UcraftSpacing.space2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.error_outline,
                  size: 16,
                  color: colors.destructive,
                ),
              ),
              const SizedBox(width: UcraftSpacing.iconLabelGap),
              Expanded(
                child: Text(
                  errorText!,
                  style: UcraftTypography.caption.copyWith(
                    color: colors.destructive,
                  ),
                ),
              ),
            ],
          ),
        ] else if (helperText != null && helperText!.trim().isNotEmpty) ...[
          const SizedBox(height: UcraftSpacing.space2),
          Text(
            helperText!,
            style: UcraftTypography.caption.copyWith(
              color: colors.foregroundSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
