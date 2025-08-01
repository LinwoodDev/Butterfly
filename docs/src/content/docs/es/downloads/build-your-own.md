---
title: "Construye tu propio"
---

1. Instalar git y flujido (beta)
2. Clonar el repositorio
3. Navegar al directorio de aplicaciones
4. Utilice la herramienta de flutter para compilar la aplicación
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Los archivos compilados están en el directorio de compilación
