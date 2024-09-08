---
title: Selfhosting
---

![Stable release version](https://img.shields.io/badge/dynamic/yaml?color=c4840d\&label=Stable\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml\&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Det är mycket lätt att vara värd för din egen fjäril webbserver.

## Enkel server

Installera fladder och bygg appen med:

```bash
cd app
flutter pub get
flutter build web
```

All the files are in the `app/build/web` directory.

## Docker

Clone the repository and build the `Dockerfile` using: `docker build -t linwood-butterfly`.
Start the server using: `docker run -p 8080:8080 -d linwood-butterfly`.
