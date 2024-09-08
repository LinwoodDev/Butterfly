---
title: Selfhosting
---

![إصدار الإصدار المستقر](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url={ ps%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec. aml&style=for-the-badge)
![الإصدار الليلي](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=pips%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbufly%2Fمساء%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

من السهل جدا استضافة خادم الويب الخاص بك الفراشة.

## خادم بسيط

قم بتثبيت طلاقة وبناء التطبيق باستخدام:

```bash
cd app
flutter pub get
flutter build web
```

جميع الملفات موجودة في دليل "app/build/web".

## دوكر

استنساخ المستودع وبناء `Dockerfile' باستخدام: `docker build-t linwood-butterfly`.
بدء تشغيل الخادم باستخدام `docker تشغيل -p 8080:8080 -d linwood-butterfly\`.
