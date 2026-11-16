# Handoff — ugym_core (Shared Package)

**Обновлено:** 2026-11-16
**Текущий этап:** C0 — Фундамент общего пакета
**Текущая задача:** `C0-04` `[x]` завершена; следующая — `C0-05`

## Что сделано в последней сессии

- **`C0-01`**: создан Flutter-пакет `ugym_core` (`Flutter 3.50.0`, `Dart 3.14.0`), настроены `pubspec.yaml` и строгие правила `analysis_options.yaml`.
- **`C0-02`**: реализованы токены **uCraft Design System 1.0 (Midnight & Cobalt)** и темы `UcraftTheme.light()` / `UcraftTheme.dark()`.
- **`C0-03a` / `C0-03b`**: реализованы базовые UI-компоненты (`UcraftButton`, `UcraftCard`, `UcraftTextField`, `UcraftLoadingState`, `UcraftEmptyState`, `UcraftErrorState`) с поддержкой Light/Dark.
- **`C0-04`**: добавлены `dio` и `flutter_secure_storage` (`D-002`); реализованы `TokenStorage` (`SecureTokenStorage`, `InMemoryTokenStorage`), `UgymApiException` + `UgymErrorMapper`, `UgymUuid.v4()`, `UgymNetworkInterceptor` (`Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, колбэки `401` и `SUBSCRIPTION_EXPIRED`) и `UgymHttpClient`.
- Все проверки пройдены: `dart format` ✓, `flutter analyze` ✓ (`No issues found!`), `flutter test` ✓ (`27 passed`).

## Точный следующий шаг

- Выполнить задачу **`C0-05`**: реализовать общие форматтеры (`MoneyFormatter` minor→TJS, `WeightFormatter` grams↔kg, `DateFormatter` UTC → локальная TZ / `Asia/Dushanbe` + форматирование минутных окон `HH:MM`) и unit-тесты.
