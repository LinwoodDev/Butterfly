---
title: "Erstellen Sie Ihr eigenes"
---

1. Installiere Git und Flutter (Beta)
2. Repository klonen
3. Navigiere zum App-Verzeichnis
4. Benutze das Flutter-Werkzeug, um die Anwendung zu kompilieren
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     Erstellen Sie danach einen Ordner namens "Payload", kopiere Runner.app hinein und zippe den Payload-Ordner. Benennen Sie anschließend „.zip“ in „.ipa“ um.
5. Die kompilierten Dateien befinden sich im Build-Verzeichnis
