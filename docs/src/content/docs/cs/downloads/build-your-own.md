---
title: "Vytvořte si vlastní"
---

1. Instalovat git a flutter (beta)
2. Klonovat repozitář
3. Přejít do adresáře aplikace
4. Použít nástroj flutter pro kompilaci aplikace
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Kompilované soubory jsou v adresáři sestavení
