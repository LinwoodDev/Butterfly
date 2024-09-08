---
title: Selfhosting
---

![Stable release version](https://img.shields.io/badge/dynamic/yaml?color=c4840d\&label=Stable\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml\&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Het is heel makkelijk om je eigen vlinderserver te hosten.

## Eenvoudige server

Installeer de flutter en bouw de app met gebruik:

```bash
cd app
flutter pub get
flutter build web
```

Alle bestanden zijn in de `app/build/web` map.

## Docker

Kloon de repository en bouw het `Dockerfile` gebruikt: `docker build -t linwood-butterfly`.
Start de server met behulp van `docker run -p 8080:8080 -d linwood-butterfly`.
