# ugym_core — чек-лист задач

**Текущий этап:** C0 — Фундамент общего пакета (завершён)
**Статусы:** `[ ]` не начата · `[~]` в работе · `[x]` готова · `[!]` заблокирована (причина в заметках)

## Правила ведения файла

- Нумерация: `C{этап}-{номер}`, подзадачи `C0-02a`, `C0-02b`.
- Завершённые задачи сворачиваются в одну строку в разделе «Готово».
- Одна задача = одна вещь, проверяется командами `dart format`, `flutter analyze`, `flutter test`.

---

## Готово

- [x] **C0-01** Инициализирован Flutter-пакет `ugym_core` (`pubspec.yaml`, `publish_to: none`), настроены строгие правила `analysis_options.yaml` (strict-casts/inference/raw-types + линты), очищена точка входа `lib/ugym_core.dart` и проверен smoke-тест (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-02** (обновлено по `D-003`: переведено с устаревшего `package:flutter/material.dart` на `material_ui: ^1.1.0` без `// ignore`) Реализованы токены uCraft Design System 1.0 (`UcraftBrandColors`, `UcraftColors` Light/Dark `ThemeExtension`, `UcraftTypography` Inter + GeistMono, `UcraftSpacing` 4px, `UcraftRadius`, `UcraftElevation`, `UcraftMotion`) и `UcraftTheme.light()` / `UcraftTheme.dark()` + `context.ucraftColors`; 8 тестов зелёные (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-03a** Реализованы компоненты `UcraftButton` (`primary`/`secondary`/`tertiary`/`destructive`, `default`/`pressed`/`focused`/`disabled`/`loading` с блокировкой повторов и сохранением ширины, тач-таргет `>=48x48dp`) и `UcraftCard` (`standard`/`highlight`/`onTap` без теней с границей 1dp); 16 тестов зелёные в Light/Dark (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-03b** Реализованы `UcraftTextField` (высота `>=52dp`, радиус `8dp`, состояния ошибки с иконкой+текстом, успеха, `disabled` и `readOnly`) и виджеты асинхронных состояний (`UcraftLoadingState` спиннер/скелетон, `UcraftEmptyState`, `UcraftErrorState`); 22 теста зелёные в Light/Dark (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-04** Добавлены зависимости `dio` и `flutter_secure_storage` (`D-002`); реализованы `TokenStorage` (`SecureTokenStorage` / `InMemoryTokenStorage`), `UgymApiException` и `UgymErrorMapper` (`{error: {code, message, details}}`, `errors`, сетевые таймауты), `UgymUuid.v4()`, `UgymNetworkInterceptor` (`Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, колбэки `401`/`SUBSCRIPTION_EXPIRED`) и `UgymHttpClient`; 27 тестов зелёные (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-05** Реализованы форматтеры `MoneyFormatter` (`minorUnits` → `TJS` + точный парсинг без float-погрешностей), `WeightFormatter` (`grams` ↔ `кг` + расчёт 1RM по формуле Эпли) и `DateFormatter` (`UTC` → `Asia/Dushanbe` / целевая TZ, минутные окна `0..1439` → `HH:MM`); 33 теста зелёные (`format ✓`, `analyze ✓`, `test ✓`).

---

## Этап C0 — Фундамент общего пакета

Все задачи этапа `C0` (`C0-01`–`C0-05`) выполнены.
