---
title: Selfhosting
---

![Versão da versão de lançamento estável](https://img.shields.io/badge/dynamic/yaml?├c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fapp estável%2F%2Fpubspec. aml&style=for-the-badge)
![Versão de lançamento noturna](https://img.shields.io/badge/dynamic/yaml?├f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fapp%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

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

Clone o repositório e crie o `Dockerfile` usando: `docker build -t linwood-butterfly`.
Inicie o servidor usando: `docker run -p 80:808080 -d linwood-butterfly`.
