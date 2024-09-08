---
title: Selfhosting
---

![Стабильная версия](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec. aml&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnight%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

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

Скопируйте репозиторий и создайте `Dockerfile` с помощью: `docker build -t linwood-butterfly`.
Запустить сервер с помощью: `docker run -p 8080:8080 -d linwood-butterfly`.
