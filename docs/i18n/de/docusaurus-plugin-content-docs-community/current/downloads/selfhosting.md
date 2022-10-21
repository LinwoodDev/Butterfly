---
title: "Selfhosting"
sidebar_position: 5
---

![Stable Release-Version](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nachts Release Version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Es ist sehr einfach, Ihren eigenen Schmetterlings-Webserver zu beherbergen.

## Einfacher Server

Installieren Sie Flutter und bauen Sie die App aus:

```bash
cd app
flutter pub get
flutter build web
```

Alle Dateien befinden sich im `app/build/web` Verzeichnis.

## Docker

Klonen Sie das Projektarchiv und bauen Sie die `Dockerdatei` unter Verwendung von `docker build -t linwood-butterfly`. Starte den Server unter Verwendung von `docker run -p 8080:8080 -d linwood-butterfly`.

