---
title: "Zbuduj swój własny"
---

1. Zainstaluj git i flutter (beta)
2. Sklonuj repozytorium
3. Przejdź do katalogu aplikacji
4. Użyj narzędzia do kompilacji aplikacji
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Skompilowane pliki są w katalogu kompilacji
