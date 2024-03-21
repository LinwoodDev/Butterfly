---
title: "自分で作ってください"
sidebar_position: 1
---

1. git とフラッタをインストール (ベータ版)
2. リポジトリを複製
3. アプリのディレクトリに移動します
4. フラッターツールを使用してアプリケーションをコンパイルする
   * `Flutter build apk`
   * `flutter build appbundle`
   * `flutter build web`
   * `flutter build linux`
   * `フラッタビルドウィンドウ`
   * `flutter build ios --release --no-codesign`\
     その後、"Payload" という名前のフォルダを作成し、Runner.app をコピーして zip します。 次に、".zip" の名前を ".ipa" に変更します。
5. コンパイルされたファイルはビルドディレクトリにあります
