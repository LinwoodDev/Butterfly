---
title: "Selfhosting"
sidebar_position: 5
---

![Stabil utgåva](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Det är mycket lätt att vara värd för din egen fjäril webbserver.

## Enkel server

Installera fladder och bygg appen med:

```bash
cd app
flutter pub get
flutter build web
```

Alla filer finns i katalogen `app/build/web`.

## Docker

Klona utvecklingskatalogen och bygg `Dockerfile` med att: `docker build -t linwood-butterfly`. Starta servern med: `docker run -p 8080:8080 -d linwood-fjärilen`.

