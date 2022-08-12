---
title: "Selfhosting"
sidebar_position: 5
---

![Release versione stabile](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Release versione nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

È molto facile ospitare il proprio server web di farfalla.

## Server semplice

Installa flutter e crea l'app utilizzando:

```bash
cd app
flutter pub get
flutter build web
```

Tutti i file sono nella directory `app/build/web`.

## Docker

Clone the repository and build the `Dockerfile` using: `docker build -t linwood-butterfly`. Avvia il server utilizzando: `docker run -p 8080:8080 -d linwood-butterfly`.

