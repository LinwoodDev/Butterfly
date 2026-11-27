---
title: Selfhosting
---

![Wersja stabilna](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge)
![Nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Bardzo łatwo jest hostować swój własny serwer motyli.

## Prosty serwer

Zainstaluj flutter i zbuduj aplikację za pomocą:

```bash
cd app
flutter pub get
flutter build web
```

Wszystkie pliki znajdują się w katalogu app/build/web.

## Docker

### Dockerhub

Możesz ściągnąć najnowszą wersję obrazu z Dockerhub za pomocą:

```bash
docker pull linwooddev/butterfly
```

Tagi są następujące:

- `:latest` to bieżąca główna gałąź
- `:dev` to bieżąca gałąź rozwoju
- `:stable` jest najnowszym stabilnym wydaniem (podobnie jak tag git)
- `:nightly` jest najnowszym wydaniem nightly (podobnie jak tag git)
- Tagi zaczynające się od `:v` są wydaniami

Uruchom serwer używając `docker run -p 8080:80 -d linwooddev/butterfly`.

### Selfbuilding

Sklonuj repozytorium i zbuduj `Dockerfile` za pomocą: `docker build -t linwood-butterfly`.
Uruchom serwer za pomocą: `docker run -p 8080:80 -d linwood-butterfly`.
