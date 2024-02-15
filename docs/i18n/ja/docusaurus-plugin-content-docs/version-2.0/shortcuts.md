---
title: ショートカット
sidebar_position: 2
---

## Keyboard

エディタで使用できるショートカットがいくつかあります。
いくつかはボタンの下に書かれています。

### 全般

- `Ctrl` + `N`: 新しいファイル
- `Ctrl` + `Shift` + `N`: テンプレートから新しいファイル
- `Ctrl` + `E`: ファイルをエクスポート
- `Ctrl` + `P`: ファイルを印刷
- `Ctrl` + `Shift` + `E`: ファイルを画像としてエクスポート
- `Ctrl` + `Alt` + `E`: ファイルを svg としてエクスポート
- `Ctrl` + `Alt` + `Shift` + `E`: ファイルを svg としてエクスポート
- `Ctrl` + `Alt` + `P`: パックを開く
- `Ctrl` + `Alt` + `S`: 設定を開く

### プロジェクト

- `Ctrl` + `Z`: 元に戻す
- `Ctrl` + `Y`: やり直します
- `Ctrl` + `Shift` + `P`: ウェイポイントダイアログを開く
- `Ctrl` + `B`: 背景ダイアログを開く
- `Ctrl` + `Shift` + `A`: 領域ダイアログを開く
- `Ctrl` + `S`: 保存
- `Alt` + `S`: パスを変更
- `Ctrl` + (`1` - `0`): ツールに切り替える
- `Ctrl` + `+`: 拡大
- `Ctrl` + `-`: 縮小

## ペン

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## {#configure} を設定

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
