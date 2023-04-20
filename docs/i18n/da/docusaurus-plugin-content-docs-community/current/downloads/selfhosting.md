---
title: "Selfhosting"
sidebar_position: 5
---

![Stabil version](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Det er meget nemt at være vært for din egen butterfly webserver.

## Simpel server

Installér flutter og opbyg app'en med:

```bash
cd app
flutter pub get
flutter build web
```

Alle filerne er i mappen `app/build/web`.

## Docker

Klon depotet og opbyg `Dockerfilen` vha. `docker build -t linwood-butterfly`. Start serveren med: `docker run -p 8080:8080 -d linwood-butterfly`.

