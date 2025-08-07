---
title: "Создайте свой собственный"
---

1. Установить git и flutter (бета-версия)
2. Клонировать репозиторий
3. Перейдите в каталог приложения
4. Используйте инструмент flutter для компиляции приложения
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Скомпилированные файлы находятся в каталоге сборки
