---
title: "Kendiniz Geliştirin"
---

1. Git ve flutter (beta)'yı yükleyin
2. Bu depoyu klonla
3. Uygulama dizinine gidin
4. Uygulamayı derlemek için flutter aracını kullanın
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Derlenmiş dosyalar derleme dizinindedir
