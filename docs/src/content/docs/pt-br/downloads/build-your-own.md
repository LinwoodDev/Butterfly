---
title: "Construa seu próprio"
---

1. Instale o git e o flutter (beta)
2. Clonar o repositório
3. Navegue até o diretório de aplicativos
4. Use a ferramenta de aglutro para compilar o aplicativo
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web`
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
      after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. Os arquivos compilados estão no diretório de compilação
