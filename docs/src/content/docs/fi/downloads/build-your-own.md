---
title: Rakenna oma
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
     sen jälkeen, luo kansio nimeltä "Payload", kopioi Runner.app siihen ja zip payload kansioon. Nimeä sitten ".zip" muotoon ".ipa".
5. Käännetyt tiedostot ovat koostamishakemistossa
