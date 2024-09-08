---
title: Construiți-vă propriul
---

1. Instalează git și flutter (beta)
2. Clonează depozitul
3. Navigați în directorul de aplicații
4. Folosiți instrumentul flutter pentru a compila aplicația
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     după aceea, creați un folder numit "Payload", copiați Runner.app în el şi arhivați folderul payload. Apoi redenumiţi ".zip" în ".ipa".
5. Fișierele compilate sunt în directorul de construcții
