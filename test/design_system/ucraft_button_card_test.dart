// Flutter 3.50 transitional deprecation; keep SDK material import without extra deps.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ugym_core/ugym_core.dart';

void main() {
  Widget wrapTheme({required ThemeData theme, required Widget child}) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('UcraftButton', () {
    for (final variant in UcraftButtonVariant.values) {
      testWidgets('renders $variant in light and dark themes', (tester) async {
        for (final theme in [UcraftTheme.light(), UcraftTheme.dark()]) {
          var tapped = 0;
          await tester.pumpWidget(
            wrapTheme(
              theme: theme,
              child: UcraftButton(
                label: 'Save',
                variant: variant,
                onPressed: () => tapped++,
              ),
            ),
          );

          expect(find.text('Save'), findsOneWidget);
          await tester.tap(find.byType(UcraftButton));
          expect(tapped, 1);

          final size = tester.getSize(find.byType(UcraftButton));
          expect(size.height, greaterThanOrEqualTo(48));
          expect(size.width, greaterThanOrEqualTo(48));
        }
      });
    }

    testWidgets('prevents duplicate taps and preserves width when loading', (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.light(),
          child: UcraftButton(
            label: 'Confirm Check-In',
            onPressed: () => tapped++,
          ),
        ),
      );

      final idleSize = tester.getSize(find.byType(UcraftButton));

      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.light(),
          child: UcraftButton(
            label: 'Confirm Check-In',
            isLoading: true,
            onPressed: () => tapped++,
          ),
        ),
      );

      final loadingSize = tester.getSize(find.byType(UcraftButton));
      expect(loadingSize.width, idleSize.width);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.tap(find.byType(UcraftButton));
      expect(tapped, 0);
    });

    testWidgets('disabled button ignores taps', (tester) async {
      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.dark(),
          child: const UcraftButton(label: 'Disabled', onPressed: null),
        ),
      );

      final button = tester.widget<TextButton>(find.byType(TextButton));
      expect(button.onPressed, isNull);
    });
  });

  group('UcraftCard', () {
    testWidgets('renders standard and highlight variants in light and dark', (
      tester,
    ) async {
      for (final theme in [UcraftTheme.light(), UcraftTheme.dark()]) {
        final expectedColors = theme.brightness == Brightness.dark
            ? UcraftColors.dark
            : UcraftColors.light;

        await tester.pumpWidget(
          wrapTheme(
            theme: theme,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UcraftCard(child: Text('Standard')),
                UcraftCard(
                  variant: UcraftCardVariant.highlight,
                  child: Text('Highlight'),
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        final materials = tester
            .widgetList<Material>(
              find.descendant(
                of: find.byType(UcraftCard),
                matching: find.byType(Material),
              ),
            )
            .toList();

        expect(materials, hasLength(2));
        expect(materials[0].color, expectedColors.surface);
        expect(materials[0].elevation, 0);
        expect(materials[1].color, expectedColors.primarySubtle);
        expect(materials[1].elevation, 0);
      }
    });

    testWidgets('interactive card handles taps and keeps min 48dp target', (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.light(),
          child: UcraftCard(
            onTap: () => tapped++,
            padding: EdgeInsets.zero,
            child: const Text('Tap me'),
          ),
        ),
      );

      final size = tester.getSize(find.byType(UcraftCard));
      expect(size.height, greaterThanOrEqualTo(48));

      await tester.tap(find.byType(UcraftCard));
      expect(tapped, 1);
    });
  });
}
