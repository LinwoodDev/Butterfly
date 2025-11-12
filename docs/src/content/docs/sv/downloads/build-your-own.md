---
title: "Bygg din egen"
---

1. Installera git och fladder (beta)
2. Klona förrådet
3. Navigera till app-katalogen
4. Använd fladderverktyget för att sammanställa applikationen
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. De kompilerade filerna finns i kompileringskatalogen
