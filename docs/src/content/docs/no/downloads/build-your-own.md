---
title: "Bygg din egen"
---

1. Installere git og flutter (beta)
2. Klon kodelageret
3. Naviger til app mappen
4. Bruk fløderverktøyet for å kompilere applikasjonen
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. De kompilerte filene finnes i byggemappen
