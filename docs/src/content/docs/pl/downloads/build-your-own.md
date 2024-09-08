---
title: Zbuduj swój własny
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
     później utwórz folder o nazwie "Payload", skopiuj do niego Runner.app i zip folder payload. Następnie zmień nazwę ".zip" na ".ipa".
5. Skompilowane pliki są w katalogu kompilacji
