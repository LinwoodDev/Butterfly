---
title: Bouw je eigen
---

1. Installeer git en flutter (bèta)
2. Kloon de repository
3. Navigeer naar de app directory
4. Gebruik het flutter gereedschap om de applicatie te compileren
   - `flutter build apk`
   - `flutter build appbundle`
   - `Fluit build web`
   - `flutter build linux`
   - 'vensters flutterbouwen'
   - `flutter build ios --release --no-codesign`\
     daarna, maak een map genaamd "Payload", kopieer Runner.app erin en plaats de payload map. Wijzig de naam ".zip" naar ".ipa".
5. De gecompileerde bestanden zijn in de build-map
