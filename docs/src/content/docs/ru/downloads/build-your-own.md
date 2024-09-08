---
title: Создайте свой собственный
---

1. Установить git и flutter (бета-версия)
2. Клонировать репозиторий
3. Перейдите в каталог приложения
4. Используйте инструмент flutter для компиляции приложения
   - `flutter build apk`
   - `flutter сборка appbundle`
   - `flutter сборка web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     после этого создайте папку с именем "Payload", скопируйте Runner.app в нее и архивируйте папку payload. Затем переименуйте ".zip" в ".ipa".
5. Скомпилированные файлы находятся в каталоге сборки
