# Rascal Does Not Dream

Mai Sakurajima Theme for PulseSync (Yandex Music)

## О теме

Тема для Яндекс Музыки с персонажем Mai Sakurajima из аниме "Rascal Does Not Dream of Bunny Girl Senpai".

## Установка

### Автоматическая сборка

```bash
yarn
yarn build
```

После сборки в папке `dist/Rascal Does Not Dream/` появятся все файлы темы.

### Ручная установка

1. Склонируйте репозиторий
2. Скопируйте папку `dist/Rascal Does Not Dream` в папку аддонов PulseSync
3. Активируйте тему в приложении

## Команды

```bash
yarn dev      # dev mode с hot reload в папку аддонов PulseSync
yarn build    # production сборка
yarn sync     # копирование dist в папку аддонов
yarn build:sync # build + sync
yarn format   # форматирование кода
```

## Структура проекта

```
.
├── package.json
├── tsconfig.json
├── vite.config.ts
├── addon.config.mjs
├── .prettierrc.json
├── .gitignore
├── .prettierignore
├── LICENSE
├── README.md
├── src/
│   ├── main.ts
│   ├── pulsesync.ts
│   ├── styles.css
│   └── template/
│       ├── constants.ts
│       ├── dom.ts
│       └── mount.ts
├── scripts/
│   ├── dev-build.mjs
│   ├── sync-addon.mjs
│   └── pulsesync-paths.mjs
├── addon/
│   ├── handleEvents.json
│   ├── LICENSE
│   └── README.md
└── Assets/
    ├── mai-vibe.gif
    ├── player.gif
    ├── load.gif
    ├── fonts/
    │   └── CherryBombOne-Regular.ttf
    └── metadata/
        ├── icon.gif
        └── banner.gif
```

## Контрибьюторы

- JeySerYT - автор темы
- TripleY - со-автор темы

## Ссылки

- PulseSync: https://pulsesync.dev/
- GitHub Repo: https://github.com/JeySerYT/Rascal-Does-Not-Dream

## Лицензия

Copyright (c) 2026 JeySerYT. All rights reserved.