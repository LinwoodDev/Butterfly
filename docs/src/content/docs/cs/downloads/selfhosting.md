---
title: Selfhosting
---

![Verze stabilní](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FButterfly%2Fstable%2Faplikace%2Fpubspec. aml&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FButterfly%2Fnightly%2Faplikace%2Fpubspec.yaml\&style=for-the-badge)

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

Klonuj repozitář a vytvoř `Dockerfile` pomocí `docker build -t linwood-butterfly`.
Spusťte server pomocí `docker run -p 80:8080 -d linwood-butterfly`.
