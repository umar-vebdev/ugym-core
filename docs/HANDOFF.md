# Handoff — ugym_core (Shared Package)

**Обновлено** 2026-11-20
**Текущий этап** C0 — общие компоненты uCraft
**Текущая задача** `C0-08` — роли цветов и компоненты Material 3

## Что сделано в последней сессии

- **`C0-01`–`C0-05`**: пакет `ugym_core` полностью готов как базовое ядро для `uGym` и `uGym Business`:
  - **uCraft Design System 1.0** (`material_ui: ^1.1.0`, `D-003`): токены (`UcraftColors` Light/Dark `ThemeExtension`, `UcraftTypography`, `UcraftSpacing`, `UcraftRadius`, `UcraftElevation`, `UcraftMotion`), темы `UcraftTheme.light()` / `UcraftTheme.dark()`, компоненты (`UcraftButton`, `UcraftCard`, `UcraftTextField`, `UcraftLoadingState`, `UcraftEmptyState`, `UcraftErrorState`).
  - **Сетевое ядро и хранилище**: `UgymHttpClient`, `UgymHealthService` (`GET /api/v1/health`), `UgymNetworkInterceptor` (`Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, колбэки `401`/`SUBSCRIPTION_EXPIRED`), `UgymApiException` + `UgymErrorMapper`, `TokenStorage` (`SecureTokenStorage`, `InMemoryTokenStorage`).
  - **Форматтеры**: `MoneyFormatter` (`minorUnits` → `TJS`), `WeightFormatter` (`grams` ↔ `кг`, 1RM Эпли), `DateFormatter` (`UTC` → `Asia/Dushanbe`, минутные окна `HH:MM`).
- Все проверки пройдены: `dart format` ✓, `flutter analyze` ✓ (`No issues found!`), `flutter test` ✓ (`34 passed`).
- **C0-06**. Цвет границы обычного поля берётся из `InputDecorationTheme.enabledBorder` при наличии настройки. Базовые темы сохраняют прежние цвета. Форматирование, анализ и все 36 тестов прошли.

- **C0-07a**. Компактное оформление управляется через `VisualDensity.compact`. Проверены кнопки с зоной нажатия 48 dp и компактные поля.

- **C0-07b**. В компактном профиле вкладки и списки сгруппированы на общей поверхности с границей. Состояния используют меньшие иконки и отступы. Форматирование, анализ и 39 тестов прошли.

## Точный следующий шаг

- Проверить экраны в uGym Business с компактным профилем.
