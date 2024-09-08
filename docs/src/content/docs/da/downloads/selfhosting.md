---
title: Selfhosting
---

![Stabil udgivelsesversion](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fsommerfugl%2Fstabil%2Fapp%2Fpubspec. aml&style=for-the-badge)
![Natlige udgivelsesversion](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nat\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Det er meget nemt at være vært for din egen butterfly webserver.

## Simpel server

Installér flutter og opbyg app'en med:

```bash
cd app
flutter pub get
flutter build web
```

Alle filerne er i mappen 'app/build/web'.

## Docker

Klon depotet og opbyg `Dockerfile` med: `docker build -t linwood-butterfly`.
Start serveren med: `docker køre -p 8080:8080 -d linwood-butterfly`.
