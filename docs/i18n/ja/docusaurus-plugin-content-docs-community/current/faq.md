---
id: "faq"
slug: "/faq"
title: "よく寄せられる質問"
sidebar_label: "FAQ"
---

よくある質問をいくつか紹介します。

## ウェブ

### Webバージョンをインストールするにはどうすればいいですか?

タイトルバーにあるインストールボタンをクリックして、Web版をインストールすることができます。 その後、このアプリをオフラインで使用できます。

### ウェブに画像を挿入できません

> [#167](https://github.com/LinwoodCloud/Butterfly/issues/167)

現在デコードされている画像は canvaskit では動作しません。 このオプションが必要な場合は、 [この課題](https://github.com/flutter/flutter/issues/102683) に投票してください!

### バタフライがBraveにロードされません

「指紋認証をブロックする」シールドを攻撃的に設定したユーザーは、単に「標準」または「指紋認証をブロック」に変更する必要があります。 アドレスバーのシールドアイコンをクリックして設定を変更します。 ブラウザを最新バージョンに更新してみてください。

## モバイル

### Sペンのサイドボタンを押したままZでクラッシュ3する

> [#289](https://github.com/LinwoodCloud/Butterfly/issues/289)

これはフラッターとサムスンZ折り目3の既知の問題です。 この問題を修正するには、 [](https://github.com/flutter/flutter/issues/111068) に投票してください！

## デスクトップ

### スタイルの入力が認識されません

> [#238](https://github.com/LinwoodCloud/Butterfly/issues/238)

フラッターフレームワークで提供される入力を使っています。 追跡するには既に問題があります: Windows: [flutter/flutter#65248](https://github.com/flutter/flutter/issues/65248) と [flutter/flutter#102836](https://github.com/flutter/flutter/issues/102836). Linux: [flutter/flutter#63209](https://github.com/flutter/flutter/issues/63209)

これらの問題は少し古いです。 ウェブバージョンは今のところ正常に動作するはずです。
