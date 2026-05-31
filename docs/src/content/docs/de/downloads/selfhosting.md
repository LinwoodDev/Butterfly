---
title: Selfhosting
---

![Stabile Release-Version](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge)
![Nightly-Release-Version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Es ist sehr einfach, Ihren eigenen Schmetterlings-Webserver zu beherbergen.

## Einfacher Server

Installieren Sie Flutter und bauen Sie die App aus:

```bash
cd app
flutter pub get
flutter build web
```

Alle Dateien befinden sich im Verzeichnis `app/build/web`.

## Docker

### Dockerhub

Sie können die neueste Version des Images mit folgendem Befehl von Dockerhub beziehen:

```bash
docker pull linwooddev/butterfly
```

Die Tags sind:

- `:latest` ist der aktuelle Main-Branch
- `:dev` ist der aktuelle Develop-Branch
- `:stable` ist der neueste stabile Release (wie der Git-Tag)
- `:nightly` ist der neueste Nightly-Release (wie der Git-Tag)
- Tags, die mit `:v` beginnen, sind Releases

Starte den Server mit: `docker run -p 8080:80 -d linwooddev/butterfly`.

### Selbst bauen

Klone das Repository und baue das `Dockerfile` mit: `docker build -t linwood-butterfly`.
Starte den Server mit: `docker run -p 8080:80 -d linwood-butterfly`.
