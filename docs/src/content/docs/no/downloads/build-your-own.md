---
title: Bygg din egen
---

1. Installere git og flutter (beta)
2. Klon kodelageret
3. Naviger til app mappen
4. Bruk fløderverktøyet for å kompilere applikasjonen
   - `flutter build apk`
   - `flutter build appbundle`
   - "flutter build web"
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     siden, opprett en mappe kalt "Payload", kopier Runner.app i den og zip payload mappen. Så endre navn på ".zip" til ".ipa".
5. De kompilerte filene finnes i byggemappen
