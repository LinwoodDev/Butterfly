---
title: "بناء الخاص بك"
---

1. تثبيت git و flutter (بيتا)
2. استنساخ المستودع
3. انتقل إلى دليل التطبيق
4. استخدام أداة التردد لتجميع التطبيق
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. الملفات المجمعة موجودة في دليل البناء
