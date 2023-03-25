---
title: "Selfhosting"
sidebar_position: 5
---

![Стабильная версия релиза](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Это очень легко разместить свой собственный бабочный веб-сервер.

## Простой сервер

Установите flutter и постройте приложение с помощью:

```bash
cd app
flutter pub get
flutter build web
```

Все файлы находятся в папке `app/build/web`.

## Докер

Клонируйте репозиторий и создайте `Dockerfile` с помощью: `docker build -t linwood-butterfly`. Запустите сервер с помощью: `docker run -p 80:8080 -d linwood-butterfly`.

