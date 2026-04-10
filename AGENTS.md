# AGENTS.md - Правила работы с репозиторием

## Формат коммитов

Используй русские префиксы:
- `fix:` - исправление багов
- `feat:` - новая функциональность
- `docs:` - документация
- `chore:` - обновление конфигов
- `refact:` - рефакторинг

Примеры:
```
fix: исправлена ошибка в style.css
feat: добавлена базовая тема
docs: обновлен README.md
chore: обновлен .gitignore
```

## Структура проекта

```
.
├── package.json
├── README.md
├── .gitignore
├── LICENSE
└── Rascal Does Not Dream/   # Папка темы
    ├── metadata.json
    ├── handleEvents.json    # В корне папки темы!
    ├── LICENSE
    ├── README.md
    ├── project/
    │   ├── style.css
    │   └── script.js
    └── assets/
```

## Важные правила

1. **handleEvents.json** должен быть в корне папки темы (рядом с metadata.json), НЕ в project/
2. **LICENSE** - кастомная лицензия (не CC0)
3. При пуше НЕ использовать `&&` в PowerShell - выполнять команды последовательно

## Команды

```bash
# Установка зависимостей
npm install

# Сборка темы
npm run build:pulsesync
```

## Git workflow

```bash
git status              # проверить изменения
git add .               # добавить все файлы
git commit -m "fix: описание"  # создать коммит
git push                # запушить на GitHub
```
