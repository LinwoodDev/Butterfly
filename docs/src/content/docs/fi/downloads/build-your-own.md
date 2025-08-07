---
title: "Rakenna oma"
---

1. Asenna git ja leikkuri (beta)
2. Monista tietovarasto
3. Siirry sovelluksen hakemistoon
4. Käytä leikkuri työkalua sovelluksen kokoamiseen
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Käännetyt tiedostot ovat koostamishakemistossa
