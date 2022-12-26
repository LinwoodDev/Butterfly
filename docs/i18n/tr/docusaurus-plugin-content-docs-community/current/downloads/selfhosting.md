---
title: "Bireysel barındırma"
sidebar_position: 5
---

![Kararlı sürüm](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly (Kod tabanından) sürümü](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

Kendi butterfly web sunucunuzu barındırmak çok kolaydır.

## Basit sunucu

Flutter'ı yükleyin ve aşağıdakileri kullanarak uygulamayı oluşturun:

```bash
cd app
flutter pub get
flutter build web
```

Bütün klasörler `app/build/web` yolu içerisindedir.

## Docker

Depoyu klonlayın ve `Dockerfile` kullanarak oluşturun: `docker build -t linwood-butterfly`. Sunucuyu şunu kullanarak başlatın: `docker run -p 8080:8080 -d linwood-butterfly`.

