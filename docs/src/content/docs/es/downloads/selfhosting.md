---
title: Selfhosting
---

![Stable release version](https://img.shields.io/badge/dynamic/yaml?color=c4840d\&label=Stable\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml\&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

Es muy fácil alojar su propio servidor web de butterfly.

## Servidor simple

Instala flutter y construye la aplicación utilizando:

```bash
cd app
flutter pub get
flutter build web
```

Todos los archivos están en el directorio `app/build/web`.

## Doctor

Clona el repositorio y construye el `Dockerfile` utilizando: `docker build -t linwood-butterfly`.
Inicie el servidor utilizando: `docker run -p 8080:8080 -d linwood-butterfly`.
