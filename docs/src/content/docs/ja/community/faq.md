---
title: よく寄せられる質問
---

よくある質問をいくつか紹介します。

## ウェブ

### Webバージョンをインストールするにはどうすればいいですか?

タイトルバーにあるインストールボタンをクリックして、Web版をインストールすることができます。
その後、このアプリをオフラインで使用できます。

### バタフライがBraveにロードされません

「指紋認証をブロックする」シールドを攻撃的に設定したユーザーは、単に「標準」または「指紋認証をブロック」に変更する必要があります。
アドレスバーのシールドアイコンをクリックして設定を変更します。
ブラウザを最新バージョンに更新してみてください。

## モバイル

### S-Pen won't be recognized

> [#270](https://github.com/LinwoodDev/Butterfly/issues/270)

フラッターフレームワークで提供される入力を使っています。
This is the issue to track it: [flutter/flutter#42846](https://github.com/flutter/flutter/issues/42846).

### Butterfly is slow

Butterfly is optimized every update, but sometimes the problem could be from your device.

1. First, turn off your device's power saver mode.
2. Then, set your screen refresh rate to its highest available (if supported by your device)

This allows Butterfly to refresh faster and feel more responsive.

If these steps dont help, please dont hesitate to complain in Discord, Matrix, or in Github.

### Butterfly restarts in the background

Disable battery optimization for Butterfly.  
Battery optimizations prevent apps from running normally in the background to save power.

Samsung, among other brands, usually put heavy battery restrictions on apps that crash frequently or overheat the device.

If you dont know how to disable battery optimization for Butterfly, this website may help: [Dont kill my app!](https://dontkillmyapp.com/)

### iOS support

> [#244](https://github.com/LinwoodDev/Butterfly/issues/244)

Butterfly is available on iOS as preview. Click [here](https://butterfly.linwood.dev/downloads/ios) to download it. See [here](https://github.com/LinwoodDev/Butterfly/issues/244#issuecomment-1935460878) why it's not available on the App Store.

## デスクトップ

### スタイルの入力が認識されません

> [#238](https://github.com/LinwoodDev/Butterfly/issues/238)

フラッターフレームワークで提供される入力を使っています。
There are already issues to track it:
Windows: [flutter/flutter#65248](https://github.com/flutter/flutter/issues/65248) and [flutter/flutter#102836](https://github.com/flutter/flutter/issues/102836).
Linux: [flutter/flutter#63209](https://github.com/flutter/flutter/issues/63209)

これらの問題は少し古いです。 ウェブバージョンは今のところ正常に動作するはずです。
