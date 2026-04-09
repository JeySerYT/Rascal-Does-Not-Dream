# Rascal Does Not Dream

Mai Sakurajima Theme for PulseSync (Yandex Music)

## О теме

Тема для Яндекс Музыки с персонажем Mai Sakurajima из аниме "Rascal Does Not Dream of Bunny Girl Senpai".

## Установка

### Автоматическая сборка

```bash
npm install
npm run build:pulsesync
```

После сборки появится архив в папке `dist/`.

### Ручная установка

1. Склонируйте репозиторий
2. Скопируйте папку `Rascal Does Not Dream` в папку тем PulseSync
3. Активируйте тему в приложении

## Структура проекта

```
.
├── package.json              # Конфигурация сборки
├── README.md                # Этот файл
├── .gitignore               # Игнорируемые файлы
└── Rascal Does Not Dream/   # Папка темы
    ├── metadata.json        # Метаданные темы
    ├── project/            # CSS и JS
    │   ├── style.css
    │   ├── script.js
    │   └── handleEvents.json
    └── assets/              # Изображения
        ├── mai-vibe.gif
        ├── player.gif
        ├── load.gif
        └── metadata/
            ├── icon.gif
            └── banner.gif
```

## Используемые цвета

- Основной фон: `#1a1025` (темно-фиолетовый)
- Контент: `#241630` (фиолетовый)
- Акцент: `#9b6bb5` (фиолетовый)

## Автор

JeySerYT

## Лицензия

CC0-1.0
