import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ugym_core/ugym_core.dart';

void main() {
  testWidgets(
    'UcraftStatusPill, UcraftProgressBar, UcraftSectionHeader, UcraftListSection, and UcraftSegmentedTabs render cleanly in Light & Dark themes',
    (tester) async {
      var headerActionTapped = 0;
      var rowTapped = 0;
      String selectedTab = 'a';

      for (final theme in [UcraftTheme.light(), UcraftTheme.dark()]) {
        final expectedColors = theme.brightness == Brightness.dark
            ? UcraftColors.dark
            : UcraftColors.light;

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(UcraftSpacing.space5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const UcraftCard(
                      variant: UcraftCardVariant.highlight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          UcraftStatusPill(
                            icon: Icons.check_circle_outline,
                            label: 'Активен',
                            tone: UcraftStatusTone.success,
                          ),
                          SizedBox(height: UcraftSpacing.space3),
                          UcraftProgressBar(
                            value: 0.5,
                            leadingLabel: 'Осталось 46 дней',
                            trailingLabel: 'до 04.01.2027',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: UcraftSpacing.space6),
                    UcraftSectionHeader(
                      title: 'Сегодня в клубе',
                      actionLabel: 'Все',
                      onAction: () => headerActionTapped++,
                    ),
                    const SizedBox(height: UcraftSpacing.space2),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return UcraftSegmentedTabs<String>(
                          items: const [
                            UcraftSegmentedTabItem(
                              value: 'a',
                              label: 'Занятия',
                            ),
                            UcraftSegmentedTabItem(
                              value: 'b',
                              label: 'Шаблоны',
                            ),
                          ],
                          selected: selectedTab,
                          onSelected: (next) {
                            setState(() => selectedTab = next);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: UcraftSpacing.space3),
                    UcraftListSection(
                      children: [
                        UcraftListRow(
                          monoLeadingWidth: true,
                          leading: const Text(
                            '18:30',
                            style: UcraftTypography.mono,
                          ),
                          title: 'Силовая группа',
                          subtitle: 'Зал 2, тренер Фарход',
                          trailing: const Text(
                            '5 мест',
                            style: UcraftTypography.caption,
                          ),
                          onTap: () => rowTapped++,
                        ),
                        const UcraftListRow(
                          monoLeadingWidth: true,
                          leading: Text('20:00', style: UcraftTypography.mono),
                          title: 'Йога',
                          subtitle: 'Студия, тренер Мадина',
                          trailing: Text(
                            '12 мест',
                            style: UcraftTypography.caption,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: 0,
                onDestinationSelected: (_) {},
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Обзор'),
                  NavigationDestination(
                    icon: Icon(Icons.people),
                    label: 'Клиенты',
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Активен'), findsOneWidget);
        expect(find.text('Осталось 46 дней'), findsOneWidget);
        expect(find.text('до 04.01.2027'), findsOneWidget);
        expect(find.text('Сегодня в клубе'), findsOneWidget);
        expect(find.text('Силовая группа'), findsOneWidget);
        expect(find.text('Йога'), findsOneWidget);

        // Two rows -> exactly one Divider between them, none after the last.
        expect(
          find.descendant(
            of: find.byType(UcraftListSection),
            matching: find.byType(Divider),
          ),
          findsOneWidget,
        );

        // Highlight card uses borderless primarySubtle surface.
        final cardMaterial = tester.widget<Material>(
          find
              .descendant(
                of: find.byType(UcraftCard),
                matching: find.byType(Material),
              )
              .first,
        );
        expect(cardMaterial.color, expectedColors.primarySubtle);
        final shape = cardMaterial.shape! as RoundedRectangleBorder;
        expect(shape.side, BorderSide.none);
      }

      await tester.tap(find.text('Все'));
      await tester.tap(find.text('Силовая группа'));
      await tester.tap(find.text('Шаблоны'));
      await tester.pumpAndSettle();

      expect(headerActionTapped, 1);
      expect(rowTapped, 1);
      expect(selectedTab, 'b');
    },
  );
}
