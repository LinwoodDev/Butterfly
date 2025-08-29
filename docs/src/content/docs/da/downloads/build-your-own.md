---
title: "Byg din egen"
---

1. Installer git og flutter (beta)
2. Klon depotet
3. Navigér til app-mappen
4. Brug flagerværktøjet til at kompilere programmet
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. De kompilerede filer er i byggemappen
