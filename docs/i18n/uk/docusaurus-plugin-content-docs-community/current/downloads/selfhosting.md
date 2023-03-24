---
title: "Selfhosting"
sidebar_position: 5
---

![стабільна версія](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Це дуже легко розмістити ваш власний веб-сервер з метеликами.

## Простий сервер

Встановити flutter і побудувати програму за допомогою:

```bash
cd app
flutter pub get
flutter build web
```

Всі файли в каталозі `app/build/web`.

## Докер

Клонувати репозиторій і побудувати `Dockerfile` використовуючи: `docker build -t linwood-butterfly`. Почати роботу сервера: `докер запускає -p 80:8080 -d linwood-butterfly`.

