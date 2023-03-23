---
title: "Selfhosting"
sidebar_position: 5
---

![إصدار الإصدار المستقر](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![إصدار الإصدار الليلي](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

من السهل جدا استضافة خادم الويب الخاص بك الفراشة.

## خادم بسيط

قم بتثبيت طلاقة وبناء التطبيق باستخدام:

```bash
cd app
flutter pub get
flutter build web
```

جميع الملفات موجودة في دليل `app/build/web`.

## دوكر

استنسخ المستودع و قم ببناء `ملف Dockerfil` باستخدام: `جهاز الإرساء إنشاء -t linwood-butterfly`. ابدأ الخادم بإستخدام: `docker تشغيل -p 8080:8080 -d linwood-butterfly`.

