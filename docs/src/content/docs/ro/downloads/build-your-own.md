---
title: "Construiți-vă propriul"
---

1. Instalează git și flutter (beta)
2. Clonează depozitul
3. Navigați în directorul de aplicații
4. Folosiți instrumentul flutter pentru a compila aplicația
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Fișierele compilate sunt în directorul de construcții
