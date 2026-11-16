# ugym_core — чек-лист задач

**Текущий этап:** C0 — Фундамент общего пакета
**Статусы:** `[ ]` не начата · `[~]` в работе · `[x]` готова · `[!]` заблокирована (причина в заметках)

## Правила ведения файла

- Нумерация: `C{этап}-{номер}`, подзадачи `C0-02a`, `C0-02b`.
- Завершённые задачи сворачиваются в одну строку в разделе «Готово».
- Одна задача = одна вещь, проверяется командами `dart format`, `flutter analyze`, `flutter test`.

---

## Готово

- [x] **C0-01** Инициализирован Flutter-пакет `ugym_core` (`pubspec.yaml`, `publish_to: none`), настроены строгие правила `analysis_options.yaml` (strict-casts/inference/raw-types + линты), очищена точка входа `lib/ugym_core.dart` и проверен smoke-тест (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-02** (заметка: в Flutter 3.50 `package:flutter/material.dart` помечен как transitional deprecated в пользу внешнего `material_ui`, поэтому добавлен точечный `// ignore: deprecated_member_use` на импорт без добавления новой зависимости) Реализованы токены uCraft Design System 1.0 (`UcraftBrandColors`, `UcraftColors` Light/Dark `ThemeExtension`, `UcraftTypography` Inter + GeistMono, `UcraftSpacing` 4px, `UcraftRadius`, `UcraftElevation`, `UcraftMotion`) и `UcraftTheme.light()` / `UcraftTheme.dark()` + `context.ucraftColors`; 8 тестов зелёные (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-03a** Реализованы компоненты `UcraftButton` (`primary`/`secondary`/`tertiary`/`destructive`, `default`/`pressed`/`focused`/`disabled`/`loading` с блокировкой повторов и сохранением ширины, тач-таргет `>=48x48dp`) и `UcraftCard` (`standard`/`highlight`/`onTap` без теней с границей 1dp); 16 тестов зелёные в Light/Dark (`format ✓`, `analyze ✓`, `test ✓`).
- [x] **C0-03b** Реализованы `UcraftTextField` (высота `>=52dp`, радиус `8dp`, состояния ошибки с иконкой+текстом, успеха, `disabled` и `readOnly`) и виджеты асинхронных состояний (`UcraftLoadingState` спиннер/скелетон, `UcraftEmptyState`, `UcraftErrorState`); 22 теста зелёные в Light/Dark (`format ✓`, `analyze ✓`, `test ✓`).

---

## Этап C0 — Фундамент общего пакета

**ТЗ:** [uCraft_Design_System.md](specs/uCraft_Design_System.md)

- [ ] **C0-04** Сетевое ядро (`Dio` + интерцепторы `Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, `ErrorMapper`) и `SecureStorage`
  - Проверка: unit-тесты интерцепторов и маппера ошибок
- [ ] **C0-05** Общие форматтеры (`MoneyFormatter`, `WeightFormatter`, `DateFormatter` UTC → локальная TZ) и unit-тесты
  - Проверка: `dart format --output=none --set-exit-if-changed . && flutter analyze && flutter test`
