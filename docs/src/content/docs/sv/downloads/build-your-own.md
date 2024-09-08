---
title: Bygg din egen
---

1. Installera git och fladder (beta)
2. Klona förrådet
3. Navigera till app-katalogen
4. Använd fladderverktyget för att sammanställa applikationen
   - `fladder bygga apk`
   - `flutter build appbundle`
   - `fladder bygga web`
   - `fladder bygga linux`
   - `fladder bygga fönster`
   - `flutter build ios --release --no-codesign`\
     efter det, skapa en mapp som heter "Payload", kopiera Runner.app till det och zippa mappen nyttolast. Byt sedan namn på ".zip" till ".ipa".
5. De kompilerade filerna finns i kompileringskatalogen
