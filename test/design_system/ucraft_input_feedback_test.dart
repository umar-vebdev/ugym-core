import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ugym_core/ugym_core.dart';

void main() {
  Widget wrapTheme({required ThemeData theme, required Widget child}) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: Center(
          child: Padding(padding: const EdgeInsets.all(16), child: child),
        ),
      ),
    );
  }

  group('UcraftTextField', () {
    testWidgets('renders label, enforces min 52dp height, and accepts text', (
      tester,
    ) async {
      for (final theme in [UcraftTheme.light(), UcraftTheme.dark()]) {
        final controller = TextEditingController();
        addTearDown(controller.dispose);

        await tester.pumpWidget(
          wrapTheme(
            theme: theme,
            child: UcraftTextField(
              label: 'Email',
              hintText: 'user@example.com',
              helperText: 'Enter verified email',
              controller: controller,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Enter verified email'), findsOneWidget);

        final fieldSize = tester.getSize(find.byType(TextField));
        expect(fieldSize.height, greaterThanOrEqualTo(52));

        await tester.enterText(find.byType(TextField), 'test@ugym.tj');
        expect(controller.text, 'test@ugym.tj');
      }
    });

    testWidgets('renders error icon + message instead of helper text', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.light(),
          child: const UcraftTextField(
            label: 'Email',
            helperText: 'Should be hidden',
            errorText: 'Invalid email address',
          ),
        ),
      );

      expect(find.text('Invalid email address'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Should be hidden'), findsNothing);
    });

    testWidgets('supports disabled, readOnly, and success border states', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.dark(),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UcraftTextField(label: 'Disabled', enabled: false),
              UcraftTextField(label: 'ReadOnly', readOnly: true),
              UcraftTextField(label: 'Valid', isSuccess: true),
            ],
          ),
        ),
      );

      final fields = tester.widgetList<TextField>(find.byType(TextField));
      final list = fields.toList();

      expect(list[0].enabled, isFalse);
      expect(list[1].readOnly, isTrue);

      final successBorder =
          list[2].decoration?.enabledBorder as OutlineInputBorder?;
      expect(successBorder?.borderSide.color, UcraftColors.dark.success);
      expect(successBorder?.borderSide.width, UcraftElevation.borderStrong);
    });

    testWidgets('uses the theme border color for an ordinary text field', (
      tester,
    ) async {
      final base = UcraftTheme.light();
      final strong = UcraftColors.light.borderStrong;
      await tester.pumpWidget(
        wrapTheme(
          theme: base.copyWith(
            inputDecorationTheme: InputDecorationThemeData(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: strong),
              ),
            ),
          ),
          child: const UcraftTextField(label: 'Email'),
        ),
      );

      final field = tester.widget<TextField>(find.byType(TextField));
      final border = field.decoration?.enabledBorder as OutlineInputBorder?;
      expect(border?.borderSide.color, strong);
      expect(border?.borderRadius, UcraftRadius.borderSm);
    });
  });

  group('Ucraft async states', () {
    testWidgets('UcraftLoadingState supports spinner and skeleton modes', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.light(),
          child: const UcraftLoadingState(message: 'Loading...'),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading...'), findsOneWidget);

      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.dark(),
          child: const UcraftLoadingState(isSkeleton: true, skeletonCount: 2),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Container), findsNWidgets(2));
    });

    testWidgets('UcraftEmptyState renders content and triggers action', (
      tester,
    ) async {
      var tapped = 0;

      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.light(),
          child: UcraftEmptyState(
            title: 'No memberships',
            description: 'Browse gyms to get started',
            actionLabel: 'Browse Gyms',
            onAction: () => tapped++,
          ),
        ),
      );

      expect(find.text('No memberships'), findsOneWidget);
      expect(find.text('Browse gyms to get started'), findsOneWidget);

      await tester.tap(find.byType(UcraftButton));
      expect(tapped, 1);
    });

    testWidgets('UcraftErrorState renders message and triggers retry', (
      tester,
    ) async {
      var retried = 0;

      await tester.pumpWidget(
        wrapTheme(
          theme: UcraftTheme.dark(),
          child: UcraftErrorState(
            title: 'Connection failed',
            message: 'Please check your internet connection.',
            retryLabel: 'Retry',
            onRetry: () => retried++,
          ),
        ),
      );

      expect(find.text('Connection failed'), findsOneWidget);
      expect(
        find.text('Please check your internet connection.'),
        findsOneWidget,
      );

      await tester.tap(find.byType(UcraftButton));
      expect(retried, 1);
    });
  });
}
