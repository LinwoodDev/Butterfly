---
title: "Compilazione"
sidebar_position: 1
---

1. Installare git e flutter (beta)
2. Clona il repository
3. Apri la directory dell'app
4. Utilizza lo strumento di flutter per compilare l'applicazione
   * `flutter build apk`
   * `flutter build appbundle`
   * `flutter build web`
   * `flutter build linux`
   * `flutter build windows`
   * `flutter build ios --release --no-codesign`\
     dopo, crea una cartella chiamata "Payload", copia Runner.app in esso e zip la cartella payload. Quindi rinominare ".zip" in ".ipa".
5. I file compilati saranno nella cartella di compilazione
