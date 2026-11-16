# ugym_core — чек-лист задач

**Текущий этап:** C0 — Фундамент общего пакета
**Статусы:** `[ ]` не начата · `[~]` в работе · `[x]` готова · `[!]` заблокирована (причина в заметках)

## Правила ведения файла

- Нумерация: `C{этап}-{номер}`, подзадачи `C0-02a`, `C0-02b`.
- Завершённые задачи сворачиваются в одну строку в разделе «Готово».
- Одна задача = одна вещь, проверяется командами `dart format`, `flutter analyze`, `flutter test`.

---

## Готово

*(пока нет завершённых задач)*

---

## Этап C0 — Фундамент общего пакета

**ТЗ:** [uCraft_Design_System.md](specs/uCraft_Design_System.md)

- [ ] **C0-01** Инициализация Flutter-пакета `ugym_core` (`flutter create --template=package ugym_core`), настройка `pubspec.yaml` и строгих правил `analysis_options.yaml`
  - Проверка: `flutter analyze && flutter test`
- [ ] **C0-02** Токены дизайн-системы uCraft (`colors`, `typography` Inter + Geist Mono, `spacing` 4px, `radius`, `elevation`, `motion`) и темы `Light` / `Dark` (`ThemeExtension`)
  - Проверка: `flutter test` (токены и контраст Light/Dark)
- [ ] **C0-03** Базовые UI-компоненты uCraft (`Primary`/`Secondary`/`Tertiary`/`Destructive` кнопки, `TextField` с состояниями, `Standard`/`Interactive`/`Highlight` карточки, `Loading`/`Empty`/`Error` состояния)
  - Проверка: widget-тесты в Light и Dark темах
- [ ] **C0-04** Сетевое ядро (`Dio` + интерцепторы `Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, `ErrorMapper`) и `SecureStorage`
  - Проверка: unit-тесты интерцепторов и маппера ошибок
- [ ] **C0-05** Общие форматтеры (`MoneyFormatter`, `WeightFormatter`, `DateFormatter` UTC → локальная TZ) и unit-тесты
  - Проверка: `dart format --output=none --set-exit-if-changed . && flutter analyze && flutter test`
