---
title: "自分で作ってください"
---

1. git とフラッタをインストール (ベータ版)
2. リポジトリを複製
3. アプリのディレクトリに移動します
4. フラッターツールを使用してアプリケーションをコンパイルする
   - `flutter build apk`
   - `flutter build appbundle`
   - `flutter build web --wasm --release --no-web-resources-cdn`, then
     `dart pub get -C ../tools` and `dart run ../tools/build_web_service_worker.dart` to enable offline loading
   - `flutter build linux`
   - `flutter build windows`
   - `flutter build ios --release --no-codesign`\
     after that, create a folder named "Payload", copy Runner.app into it and zip the payload folder. Then rename ".zip" to ".ipa".
5. コンパイルされたファイルはビルドディレクトリにあります
