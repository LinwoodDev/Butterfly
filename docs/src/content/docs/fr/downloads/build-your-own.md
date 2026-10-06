---
title: "Construisez la vôtre"
---

1. Installer git et flutter (bêta)
2. Cloner le dépôt
3. Naviguer vers le répertoire de l'application
4. Utilisez l'outil flotteur pour compiler l'application
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Les fichiers compilés sont dans le répertoire de compilation
