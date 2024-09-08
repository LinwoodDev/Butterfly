---
title: Selfhosting
---

![Stable release version](https://img.shields.io/badge/dynamic/yaml?color=c4840d\&label=Stable\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml\&style=for-the-badge)
![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

あなた自身のバタフライウェブサーバーをホストすることは非常に簡単です。

## シンプルなサーバー

Flutterをインストールし、アプリをビルドします。

```bash
cd app
flutter pub get
flutter build web
```

全てのファイルは`app/build/web`ディレクトリにあります。

## Docker

リポジトリをクローンし、`docker build -t linwood-butterfly`を使用してビルドします。
`docker run -p 8080:8080 -d linwood-butterfly` を使用してサーバーを起動します。
