---
title: "Selfhosting"
sidebar_position: 5
---

![Stabilní verze vydání](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Je velmi snadné hostit svůj vlastní webový server.

## Jednoduchý server

Nainstalujte flutter a sestavte aplikaci pomocí:

```bash
cd app
flutter pub get
flutter build web
```

Všechny soubory jsou v adresáři `app/build/web`.

## Dokovací modul

Klonovat repozitář a vytvořit soubor `Dockerfile` pomocí `docker build -t linwood-butterfly`. Spustit server pomocí: `docker běh -p 80:8080 -d linwood-butterfly`.

