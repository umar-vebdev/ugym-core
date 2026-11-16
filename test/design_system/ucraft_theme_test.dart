// Flutter 3.50 transitional deprecation; keep SDK material import without extra deps.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugym_core/ugym_core.dart';

void main() {
  group('UcraftColors', () {
    test('light theme matches canonical Midnight & Cobalt tokens', () {
      const colors = UcraftColors.light;
      expect(colors.background, const Color(0xFFF9FAFB));
      expect(colors.surface, const Color(0xFFFFFFFF));
      expect(colors.foreground, const Color(0xFF111827));
      expect(colors.primary, const Color(0xFF3563CC));
      expect(colors.accent, const Color(0xFF507DE8));
      expect(colors.success, const Color(0xFF15803D));
      expect(colors.warning, const Color(0xFFA16207));
      expect(colors.destructive, const Color(0xFFB91C1C));
    });

    test('dark theme matches canonical Midnight & Cobalt tokens', () {
      const colors = UcraftColors.dark;
      expect(colors.background, const Color(0xFF111827));
      expect(colors.surface, const Color(0xFF1F2937));
      expect(colors.foreground, const Color(0xFFF9FAFB));
      expect(colors.primary, const Color(0xFF82A5FF));
      expect(colors.onPrimary, const Color(0xFF111827));
      expect(colors.border, const Color(0xFF374151));
    });
  });

  group('UcraftTheme', () {
    testWidgets('provides light UcraftColors via context.ucraftColors', (
      tester,
    ) async {
      late UcraftColors resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: UcraftTheme.light(),
          home: Builder(
            builder: (context) {
              resolved = context.ucraftColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved.background, UcraftColors.light.background);
      expect(resolved.primary, UcraftColors.light.primary);
    });

    testWidgets('provides dark UcraftColors via context.ucraftColors', (
      tester,
    ) async {
      late UcraftColors resolved;

      await tester.pumpWidget(
        MaterialApp(
          theme: UcraftTheme.dark(),
          home: Builder(
            builder: (context) {
              resolved = context.ucraftColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved.background, UcraftColors.dark.background);
      expect(resolved.surface, UcraftColors.dark.surface);
    });
  });

  group('Ucraft scale tokens', () {
    test('spacing uses 4px grid', () {
      expect(UcraftSpacing.space1, 4);
      expect(UcraftSpacing.space4, 16);
      expect(UcraftSpacing.screenHorizontalPadding, 20);
    });

    test('radius and motion match specification', () {
      expect(UcraftRadius.sm, 8);
      expect(UcraftRadius.md, 12);
      expect(UcraftMotion.buttonFeedback.inMilliseconds, 100);
      expect(UcraftMotion.bottomSheet.inMilliseconds, 300);
    });

    test('typography uses Inter and GeistMono', () {
      expect(UcraftTypography.display.fontFamily, 'Inter');
      expect(UcraftTypography.mono.fontFamily, 'GeistMono');
      expect(UcraftTypography.bodyLarge.fontSize, 16);
    });
  });
}
