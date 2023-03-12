---
title: "Selfhosting"
sidebar_position: 5
---

![安定版のリリース](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightlyリリースバージョン](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

あなた自身のバタフライウェブサーバーをホストすることは非常に簡単です。

## シンプルなサーバー

Flutterをインストールし、アプリをビルドします。

```bash
cd app
flutter pub get
flutter build web
```

全てのファイルは `app/build/web` ディレクトリにあります。

## Docker

リポジトリをクローンし、 `Dockerfile` を使用してビルドします。 `docker build -t linwood-バタフライ`. `docker run -p 8080:8080 -d linwood-バタフライ`.

