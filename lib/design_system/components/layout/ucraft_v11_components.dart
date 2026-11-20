import 'package:material_ui/material_ui.dart';

import '../../themes/ucraft_theme.dart';
import '../../tokens/ucraft_elevation.dart';
import '../../tokens/ucraft_radius.dart';
import '../../tokens/ucraft_spacing.dart';
import '../../tokens/ucraft_typography.dart';
import '../buttons/ucraft_button.dart';

/// Semantic color tone for [UcraftStatusPill].
enum UcraftStatusTone { success, warning, destructive, info, neutral }

/// Canonical uCraft 1.1 status pill (`icon + text`, never color alone).
final class UcraftStatusPill extends StatelessWidget {
  const UcraftStatusPill({
    super.key,
    required this.icon,
    required this.label,
    this.tone = UcraftStatusTone.neutral,
  });

  final IconData icon;
  final String label;
  final UcraftStatusTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    final compact = context.ucraftCompact;
    final (bg, fg) = switch (tone) {
      UcraftStatusTone.success => (
        colors.successBackground,
        colors.successForeground,
      ),
      UcraftStatusTone.warning => (
        colors.warningBackground,
        colors.warningForeground,
      ),
      UcraftStatusTone.destructive => (
        colors.destructiveBackground,
        colors.destructiveForeground,
      ),
      UcraftStatusTone.info => (colors.infoBackground, colors.infoForeground),
      UcraftStatusTone.neutral => (
        colors.surfaceSecondary,
        colors.foregroundSecondary,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: UcraftSpacing.space2,
        vertical: UcraftSpacing.space1,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: UcraftRadius.borderFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 12 : 16, color: fg),
          const SizedBox(width: UcraftSpacing.space1),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: UcraftTypography.caption.copyWith(
                fontSize: compact ? UcraftTypography.overline.fontSize : null,
                fontWeight: compact ? FontWeight.w500 : FontWeight.w600,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Canonical uCraft 1.1 progress indicator with real-data labels (§27.4).
final class UcraftProgressBar extends StatelessWidget {
  const UcraftProgressBar({
    super.key,
    required this.value,
    this.leadingLabel,
    this.trailingLabel,
  });

  final double value;
  final String? leadingLabel;
  final String? trailingLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    final double clamped = value.isFinite ? value.clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: UcraftRadius.borderFull,
          child: SizedBox(
            height: UcraftSpacing.space2,
            child: ColoredBox(
              color: colors.borderStrong,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: clamped,
                  child: Container(
                    height: UcraftSpacing.space2,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: UcraftRadius.borderFull,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (leadingLabel != null || trailingLabel != null) ...[
          const SizedBox(height: UcraftSpacing.space2),
          Row(
            children: [
              if (leadingLabel != null)
                Expanded(
                  child: Text(
                    leadingLabel!,
                    style: UcraftTypography.caption.copyWith(
                      color: colors.foregroundSecondary,
                    ),
                  ),
                )
              else
                const Spacer(),
              if (trailingLabel != null)
                Text(
                  trailingLabel!,
                  style: UcraftTypography.caption.copyWith(
                    fontFamily: UcraftTypography.monoFontFamily,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: colors.foregroundSecondary,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Canonical uCraft 1.1 section header with baseline-aligned tertiary action (§27.6).
final class UcraftSectionHeader extends StatelessWidget {
  const UcraftSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style:
                (context.ucraftCompact
                        ? UcraftTypography.bodyLarge
                        : UcraftTypography.title)
                    .copyWith(
                      color: colors.foreground,
                      fontWeight: FontWeight.w600,
                    ),
          ),
        ),
        if (actionLabel != null && onAction != null)
          UcraftButton(
            label: actionLabel!,
            variant: UcraftButtonVariant.tertiary,
            onPressed: onAction,
          ),
      ],
    );
  }
}

/// Canonical uCraft 1.1 list row replacing stacked bordered cards (§27.2).
final class UcraftListRow extends StatelessWidget {
  const UcraftListRow({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.bottom,
    this.onTap,
    this.monoLeadingWidth = false,
  });

  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? bottom;
  final VoidCallback? onTap;
  final bool monoLeadingWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.ucraftColors;
    final compact = context.ucraftCompact;

    final Widget? leadingWidget = leading == null
        ? null
        : (monoLeadingWidth
              ? SizedBox(
                  width: UcraftSpacing.space12,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: leading!,
                  ),
                )
              : leading!);

    final Widget rowContent = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: compact ? UcraftSpacing.space2 : UcraftSpacing.space3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leadingWidget != null) ...[
                  leadingWidget,
                  const SizedBox(width: UcraftSpacing.space3),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: UcraftTypography.bodyMedium.copyWith(
                          color: colors.foreground,
                        ),
                      ),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: UcraftSpacing.space1),
                        Text(
                          subtitle!,
                          style: UcraftTypography.caption.copyWith(
                            color: colors.foregroundMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: UcraftSpacing.space3),
                  trailing!,
                ],
              ],
            ),
            if (bottom != null) ...[
              const SizedBox(height: UcraftSpacing.space2),
              bottom!,
            ],
          ],
        ),
      ),
    );

    if (onTap == null) {
      return rowContent;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: UcraftRadius.borderSm,
        highlightColor: colors.surfaceSecondary,
        splashColor: colors.surfaceSecondary,
        child: rowContent,
      ),
    );
  }
}

/// Renders repeated list rows separated by 1dp `border` dividers with none at the end (§27.2).
final class UcraftListSection extends StatelessWidget {
  const UcraftListSection({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }
    final colors = context.ucraftColors;
    final rows = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          children[i],
          if (i + 1 < children.length)
            Divider(
              height: UcraftElevation.dividerWidth,
              thickness: UcraftElevation.dividerWidth,
              color: colors.border,
            ),
        ],
      ],
    );
    if (!context.ucraftCompact) return rows;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UcraftSpacing.space3),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: UcraftRadius.borderMd,
        border: Border.all(color: colors.border),
      ),
      child: rows,
    );
  }
}

/// Option model for [UcraftSegmentedTabs].
final class UcraftSegmentedTabItem<T> {
  const UcraftSegmentedTabItem({required this.value, required this.label});

  final T value;
  final String label;
}

/// Quiet segmented selector using `primarySubtle` instead of competing Primary buttons (§26.2).
final class UcraftSegmentedTabs<T> extends StatelessWidget {
  const UcraftSegmentedTabs({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.enabled = true,
  });

  final List<UcraftSegmentedTabItem<T>> items;
  final T? selected;
  final ValueChanged<T> onSelected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final compact = context.ucraftCompact;
    final colors = context.ucraftColors;
    final tabs = Wrap(
      spacing: compact ? UcraftSpacing.space1 : UcraftSpacing.space2,
      runSpacing: compact ? 0 : UcraftSpacing.space2,
      children: [
        for (final item in items)
          _SegmentedPill<T>(
            item: item,
            isSelected: item.value == selected,
            onTap: enabled ? () => onSelected(item.value) : null,
          ),
      ],
    );
    if (!compact) return tabs;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: UcraftSpacing.space1),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: UcraftRadius.borderMd,
        border: Border.all(color: colors.border),
      ),
      child: tabs,
    );
  }
}

final class _SegmentedPill<T> extends StatelessWidget {
  const _SegmentedPill({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final UcraftSegmentedTabItem<T> item;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.ucraftColors;
    if (context.ucraftCompact) {
      return Semantics(
        selected: isSelected,
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.standard,
            tapTargetSize: MaterialTapTargetSize.padded,
            minimumSize: const Size(48, 32),
            padding: const EdgeInsets.symmetric(
              horizontal: UcraftSpacing.space2,
            ),
            backgroundColor: isSelected ? c.surface : Colors.transparent,
            foregroundColor: isSelected ? c.primary : c.foregroundSecondary,
            shape: const RoundedRectangleBorder(
              borderRadius: UcraftRadius.borderSm,
            ),
            side: isSelected ? BorderSide(color: c.border) : null,
            textStyle: UcraftTypography.caption.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          child: Text(item.label),
        ),
      );
    }
    final Color bg = isSelected ? c.primarySubtle : c.surface;
    final Color fg = isSelected ? c.primary : c.foregroundSecondary;
    final Color borderColor = isSelected ? c.primarySubtle : c.border;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: UcraftRadius.borderFull,
          side: BorderSide(
            color: borderColor,
            width: UcraftElevation.borderDefault,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: UcraftRadius.borderFull,
          highlightColor: c.surfaceSecondary,
          splashColor: c.surfaceSecondary,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: UcraftSpacing.space3,
                vertical: UcraftSpacing.space2,
              ),
              child: Text(
                item.label,
                style: UcraftTypography.bodyMedium.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: fg,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
