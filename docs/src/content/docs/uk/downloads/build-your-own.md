---
title: "Створіть свій власний"
---

1. Встановити git і блимати (бета-версія)
2. Скопіювати репозиторій
3. Перейти до каталогу додатків
4. Використовувати інструмент спалаху для компіляції програми
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Скомпільовані файли в каталозі збірки
