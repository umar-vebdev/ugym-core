import 'package:material_ui/material_ui.dart';

import '../../themes/ucraft_theme.dart';
import '../../tokens/ucraft_elevation.dart';
import '../../tokens/ucraft_radius.dart';
import '../../tokens/ucraft_spacing.dart';
import '../../tokens/ucraft_typography.dart';
import '../buttons/ucraft_button.dart';

/// Loading state view supporting both compact spinner and card skeleton placeholders.
final class UcraftLoadingState extends StatelessWidget {
  const UcraftLoadingState({
    super.key,
    this.message,
    this.isSkeleton = false,
    this.skeletonCount = 3,
    this.skeletonHeight = 72,
  });

  final String? message;
  final bool isSkeleton;
  final int skeletonCount;
  final double skeletonHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;

    if (isSkeleton) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < skeletonCount; i++) ...[
            if (i > 0) const SizedBox(height: UcraftSpacing.cardGap),
            Container(
              height: skeletonHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.surfaceSecondary,
                borderRadius: UcraftRadius.borderMd,
                border: Border.all(
                  color: colors.border,
                  width: UcraftElevation.borderDefault,
                ),
              ),
            ),
          ],
        ],
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
          ),
          if (message != null && message!.trim().isNotEmpty) ...[
            const SizedBox(height: UcraftSpacing.space3),
            Text(
              message!,
              style: UcraftTypography.body.copyWith(
                color: colors.foregroundSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Empty state view with icon, title, optional description, and optional action.
final class UcraftEmptyState extends StatelessWidget {
  const UcraftEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(UcraftSpacing.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.surfaceSecondary,
                borderRadius: UcraftRadius.borderMd,
              ),
              child: Icon(icon, size: 24, color: colors.foregroundSecondary),
            ),
            const SizedBox(height: UcraftSpacing.space4),
            Text(
              title,
              style: UcraftTypography.title.copyWith(color: colors.foreground),
              textAlign: TextAlign.center,
            ),
            if (description != null && description!.trim().isNotEmpty) ...[
              const SizedBox(height: UcraftSpacing.space2),
              Text(
                description!,
                style: UcraftTypography.body.copyWith(
                  color: colors.foregroundSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: UcraftSpacing.space6),
              UcraftButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}

/// Recoverable error state view with icon, plain message, and optional retry button.
final class UcraftErrorState extends StatelessWidget {
  const UcraftErrorState({
    super.key,
    required this.message,
    this.title,
    this.retryLabel,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  final String message;
  final String? title;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(UcraftSpacing.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.destructiveBackground,
                borderRadius: UcraftRadius.borderMd,
              ),
              child: Icon(icon, size: 24, color: colors.destructive),
            ),
            const SizedBox(height: UcraftSpacing.space4),
            if (title != null && title!.trim().isNotEmpty) ...[
              Text(
                title!,
                style: UcraftTypography.title.copyWith(
                  color: colors.foreground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: UcraftSpacing.space2),
            ],
            Text(
              message,
              style: UcraftTypography.body.copyWith(
                color: colors.foregroundSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (retryLabel != null && onRetry != null) ...[
              const SizedBox(height: UcraftSpacing.space6),
              UcraftButton(
                label: retryLabel!,
                variant: UcraftButtonVariant.secondary,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
