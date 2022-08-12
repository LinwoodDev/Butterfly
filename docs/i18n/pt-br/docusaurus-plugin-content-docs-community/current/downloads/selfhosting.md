---
title: "Selfhosting"
sidebar_position: 5
---

![Versão de lançamento estável](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Versão de lançamento noturna](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

É muito fácil hospedar seu próprio servidor web de borboleta.

## Servidor simples

Instale o flutter e construa o aplicativo usando:

```bash
cd app
flutter pub get
flutter build web
```

Todos os arquivos estão no diretório `app/build/web`.

## Atracador

Clone o repositório e crie o `arquivo Dockerfile` usando: `docker build -t linwood-butterfly`. Inicie o servidor usando: `docker run -p 8080:8080 -d linwood-butterfly`.

