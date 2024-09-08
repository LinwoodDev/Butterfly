---
title: Selfhosting
---

![Stable release version](https://img.shields.io/badge/dynamic/yaml?color=c4840d\&label=Stable\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml\&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Es ist sehr einfach, Ihren eigenen Schmetterlings-Webserver zu beherbergen.

## Einfacher Server

Installieren Sie Flutter und bauen Sie die App aus:

```bash
cd app
flutter pub get
flutter build web
```

All the files are in the `app/build/web` directory.

## Docker

Clone the repository and build the `Dockerfile` using: `docker build -t linwood-butterfly`.
Start the server using: `docker run -p 8080:8080 -d linwood-butterfly`.
