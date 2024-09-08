---
title: Selfhosting
---

![Stabilna wersja wydania](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fmotyla%2Fstabilnego%2Fapp%2Fpubspec. aml&style=for-the-badge)
![Wersja wydania nocnego](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Bardzo łatwo jest hostować swój własny serwer motyli.

## Prosty serwer

Zainstaluj flutter i zbuduj aplikację za pomocą:

```bash
cd app
flutter pub get
flutter build web
```

Wszystkie pliki znajdują się w katalogu `app/build/web`.

## Dokujący

Sklonuj repozytorium i zbuduj `Dockerfile` za pomocą: `docker build -t linwood-butterfly`.
Uruchom serwer za pomocą: `docker run -p 8080:8080 -d linwood-butterfly`.
