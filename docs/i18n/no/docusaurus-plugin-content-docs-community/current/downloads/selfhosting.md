---
title: "Selfhosting"
sidebar_position: 5
---

![Stable utgivelsesversjon](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Slipp versjon for nattlig](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Det er veldig lett å arrangere din egen sommerfugl server.

## Enkel server

Installer flutter og bygg appen ved hjelp av

```bash
cd app
flutter pub get
flutter build web
```

All the files are in the `app/build/web` directory.

## Docker

Klon depotet og bygg `Dockerfile` bruker: `docker build -t linwood-butterfly`. Start serveren ved å bruke: `docker run -p 80:8080 -d linwood-butterfly`.

