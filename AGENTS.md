# ugym_core — постоянные инструкции для агента (AGENTS.md)

Этот файл читается в начале каждой сессии. Он обязателен к исполнению всегда, без исключений.

## 1. Источники истины (читать в начале КАЖДОЙ сессии)

Прежде чем что-либо делать, **полностью прочитай** эти файлы (пути от корня пакета):

1. `docs/specs/uCraft_Design_System.md`
2. `docs/HANDOFF.md`
3. `docs/TASKS.md`
4. `docs/DECISIONS.md`

## 2. О пакете

**`ugym_core`** — общий Dart/Flutter-пакет для приложений **uGym** (`tj.ugym.client`) и **uGym Business** (`tj.ugym.business`).
Он содержит:
- реализацию дизайн-системы **uCraft Design System 1.0 (Midnight & Cobalt)** (`tokens`, `themes`, `components`, `patterns`);
- сетевое ядро (`Dio`, интерцепторы `Auth`, `Accept-Language`, `X-Request-Id`, `Idempotency-Key`, `ErrorMapper`);
- форматтеры (`MoneyFormatter`, `WeightFormatter`, `DateFormatter`);
- обёртку безопасного хранения (`SecureStorage`).

Пакет **не должен** содержать бизнес-логики конкретного приложения (`uGym` или `uGym Business`).

Язык общения и документов: **русский**. Код, идентификаторы и сообщения коммитов: **английский**.

## 3. Сессионный ритуал и цикл задачи

1. Прочитать `uCraft_Design_System.md`, `HANDOFF.md`, `TASKS.md`, `DECISIONS.md`.
2. Проверить `git status` и `git log --oneline -10`, сверить `HANDOFF.md` с кодом.
3. Статусы в `TASKS.md`: `[ ]` не начата, `[~]` в работе, `[x]` готова, `[!]` заблокирована.
4. Одна задача = одна вещь (до ~5 файлов + тесты), после каждой задачи — обновление `TASKS.md`, `HANDOFF.md` и коммит (`C0-01: ...`).

## 4. Проверки перед закрытием задачи

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

## 5. Правила дизайн-системы и кода

- Никаких произвольных HEX-цветов, отступов, радиусов и шрифтов — всё строго по `docs/specs/uCraft_Design_System.md`.
- Обязательная поддержка **Light** (по умолчанию) и **Dark** тем.
- Шрифты: **Inter** и **Geist Mono**. Иконки: **Lucide**.
- Никакого захардкоженного пользовательского текста в компонентах (все подписи передаются извне или через локализацию).
- Не добавлять внешние зависимости в `pubspec.yaml` без записи в `docs/DECISIONS.md`.
