---
title: "Construiți-vă propriul"
sidebar_position: 1
---

1. Instalează git și flutter (beta)
2. Clonează depozitul
3. Navigați în directorul de aplicații
4. Folosiți instrumentul flutter pentru a compila aplicația
   * `flutter construit apk`
   * `flutter construit apppachet`
   * `flutter construit web`
   * `flutter construit linux`
   * `flutter construit ferestre`
   * `flutter build ios --release --no-codesign`\
     după aceea, creați un folder numit "Payload", copiați Runner.app în el şi arhivați folderul payload. Apoi redenumiţi ".zip" în ".ipa".
5. Fișierele compilate sunt în directorul de construcții
