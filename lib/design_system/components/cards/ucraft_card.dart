import 'package:material_ui/material_ui.dart';

import '../../themes/ucraft_theme.dart';
import '../../tokens/ucraft_elevation.dart';
import '../../tokens/ucraft_radius.dart';
import '../../tokens/ucraft_spacing.dart';

/// Visual variants for [UcraftCard].
enum UcraftCardVariant { standard, highlight }

/// Canonical uCraft Design System 1.0 card container (elevation 0 + 1dp border).
final class UcraftCard extends StatelessWidget {
  const UcraftCard({
    super.key,
    required this.child,
    this.variant = UcraftCardVariant.standard,
    this.onTap,
    this.padding,
    this.semanticLabel,
  });

  final Widget child;
  final UcraftCardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    final bool isHighlight = variant == UcraftCardVariant.highlight;

    final Color backgroundColor = isHighlight
        ? colors.primarySubtle
        : colors.surface;
    final BorderRadius borderRadius = isHighlight
        ? UcraftRadius.borderLg
        : UcraftRadius.borderMd;
    final EdgeInsetsGeometry resolvedPadding =
        padding ??
        EdgeInsets.all(
          isHighlight ? UcraftSpacing.space5 : UcraftSpacing.cardPadding,
        );

    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: colors.border,
        width: UcraftElevation.borderDefault,
      ),
    );

    final Widget paddedChild = Padding(padding: resolvedPadding, child: child);

    final Widget cardBody = onTap != null
        ? ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              highlightColor: colors.surfaceSecondary,
              splashColor: colors.surfaceSecondary,
              child: paddedChild,
            ),
          )
        : paddedChild;

    final Widget material = Material(
      color: backgroundColor,
      elevation: 0,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: cardBody,
    );

    if (onTap != null || semanticLabel != null) {
      return Semantics(
        button: onTap != null,
        label: semanticLabel,
        child: material,
      );
    }

    return material;
  }
}
