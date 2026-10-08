---
title: "Bouw je eigen"
---

1. Installeer git en flutter (bèta)
2. Kloon de repository
3. Navigeer naar de app directory
4. Gebruik het flutter gereedschap om de applicatie te compileren
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. De gecompileerde bestanden zijn in de build-map
