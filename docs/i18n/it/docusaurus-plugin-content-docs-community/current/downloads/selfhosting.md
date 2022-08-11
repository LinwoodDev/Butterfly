---
title: "Selfhosting"
sidebar_position: 5
---

![Release versione stabile](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Release versione nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

It is very easy to host your own butterfly web server.

## Simple server

Install flutter and build the app using:

```bash
cd app
flutter pub get
flutter build web
```

All the files are in the `app/build/web` directory.

## Docker

Clone the repository and build the `Dockerfile` using: `docker build -t linwood-butterfly`. Start the server using: `docker run -p 8080:8080 -d linwood-butterfly`.

