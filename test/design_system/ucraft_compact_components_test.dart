import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ugym_core/ugym_core.dart';

void main() {
  testWidgets('compact tabs share a surface and keep all options interactive', (
    tester,
  ) async {
    var selected = 'Visits';
    await tester.pumpWidget(
      MaterialApp(
        theme: UcraftTheme.light().copyWith(
          visualDensity: VisualDensity.compact,
        ),
        home: Scaffold(
          body: UcraftSegmentedTabs<String>(
            items: const [
              UcraftSegmentedTabItem(value: 'Visits', label: 'Visits'),
              UcraftSegmentedTabItem(value: 'Sales', label: 'Sales'),
            ],
            selected: selected,
            onSelected: (value) => selected = value,
          ),
        ),
      ),
    );
    final options = find.byType(TextButton);
    expect(options, findsNWidgets(2));
    expect(tester.getSize(options.first).height, 48);
    await tester.tap(find.text('Sales'));
    expect(selected, 'Sales');
  });

  testWidgets('compact button keeps the 48dp tap target and smaller fill', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: UcraftTheme.light().copyWith(
          visualDensity: VisualDensity.compact,
        ),
        home: Scaffold(
          body: Center(
            child: UcraftButton(label: 'Save', onPressed: () => tapped = true),
          ),
        ),
      ),
    );
    final button = find.byType(FilledButton);
    expect(
      tester
          .widget<FilledButton>(button)
          .style!
          .minimumSize!
          .resolve({})!
          .height,
      36,
    );
    expect(tester.getSize(button).height, 48);
    await tester.tapAt(tester.getTopLeft(button) + const Offset(12, 2));
    expect(tapped, isTrue);
  });

  testWidgets('compact text field retains a 48dp interactive height', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: UcraftTheme.light().copyWith(
          visualDensity: VisualDensity.compact,
        ),
        home: const Scaffold(body: UcraftTextField(label: 'Email')),
      ),
    );
    final field = find.byType(TextField);
    expect(tester.getSize(field).height, 48);
    expect(tester.widget<TextField>(field).style!.fontSize, 14);
  });
}
