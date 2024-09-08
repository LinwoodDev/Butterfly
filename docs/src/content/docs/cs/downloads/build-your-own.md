---
title: Vytvořte si vlastní
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
     poté vytvořte složku s názvem "Payload", zkopírujte Runner.app do ní a zipněte složku payload. Pak přejmenujte ".zip" na ".ipa".
5. Kompilované soubory jsou v adresáři sestavení
