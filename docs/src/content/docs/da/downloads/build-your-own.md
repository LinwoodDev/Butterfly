---
title: Byg din egen
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
     efter at, oprette en mappe med navnet "Payload", kopiere Runner.app ind i det og zip nyttelasten mappe. Omdøb derefter ".zip" til ".ipa".
5. De kompilerede filer er i byggemappen
