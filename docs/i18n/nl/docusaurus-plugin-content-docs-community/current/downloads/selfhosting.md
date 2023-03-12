---
title: "Selfhosting"
sidebar_position: 5
---

![Stabiele versie van release](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nachtelijke versie versie](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Het is heel makkelijk om je eigen vlinderserver te hosten.

## Eenvoudige server

Installeer de flutter en bouw de app met gebruik:

```bash
cd app
flutter pub get
flutter build web
```

Alle bestanden staan in de map `app/build/web`.

## Docker

Kloon de repository en maak het `Docker-bestand` met behulp van: `docker build -t linwood-boterfly`. Start de server met: `docker run -p 8080:8080 -d linwood-boterfly`.

