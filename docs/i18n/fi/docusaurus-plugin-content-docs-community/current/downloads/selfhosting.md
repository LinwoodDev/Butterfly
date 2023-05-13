---
title: "Selfhosting"
sidebar_position: 5
---

![Vakaa julkaisuversio](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

On erittäin helppo isännöidä oman perhonen web palvelin.

## Yksinkertainen palvelin

Asenna leikkuri ja rakenna sovellus käyttäen:

```bash
cd app
flutter pub get
flutter build web
```

Kaikki tiedostot ovat `app/build/web` hakemistossa.

## Telakoitsija

Kloonaa repo ja rakenna `Dockerfile` käyttäen: `docker build -t linwood-butterfly`. Käynnistä palvelin käyttäen: `telakka ajaa -p 8080:8080 -d metsäperhonen`.

