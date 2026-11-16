# Handoff — ugym_core (Shared Package)

**Обновлено:** 2026-11-16
**Текущий этап:** C0 — Фундамент общего пакета (завершён)
**Текущая задача:** Все задачи этапа `C0` завершены (`C0-01`–`C0-05` `[x]`)

## Что сделано в последней сессии

- **`C0-01`–`C0-05`**: пакет `ugym_core` полностью готов как базовое ядро для `uGym` и `uGym Business`:
  - **uCraft Design System 1.0** (`material_ui: ^1.1.0`, `D-003`): токены (`UcraftColors` Light/Dark `ThemeExtension`, `UcraftTypography`, `UcraftSpacing`, `UcraftRadius`, `UcraftElevation`, `UcraftMotion`), темы `UcraftTheme.light()` / `UcraftTheme.dark()`, компоненты (`UcraftButton`, `UcraftCard`, `UcraftTextField`, `UcraftLoadingState`, `UcraftEmptyState`, `UcraftErrorState`).
  - **Сетевое ядро и хранилище**: `UgymHttpClient`, `UgymNetworkInterceptor` (`Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, колбэки `401`/`SUBSCRIPTION_EXPIRED`), `UgymApiException` + `UgymErrorMapper`, `TokenStorage` (`SecureTokenStorage`, `InMemoryTokenStorage`).
  - **Форматтеры**: `MoneyFormatter` (`minorUnits` → `TJS`), `WeightFormatter` (`grams` ↔ `кг`, 1RM Эпли), `DateFormatter` (`UTC` → `Asia/Dushanbe`, минутные окна `HH:MM`).
- Все проверки пройдены: `dart format` ✓, `flutter analyze` ✓ (`No issues found!`), `flutter test` ✓ (`33 passed`).

## Точный следующий шаг

- Подключить `ugym_core` и начать этап `M0` в `/home/umar/ugym-mobile/uGym` или `B0` в `/home/umar/ugym-mobile/uGym Business` (после установки Android SDK для сборки под Android или сразу на уровне Dart/Flutter-кода и тестов).
