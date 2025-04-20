---
title: ショートカット
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
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `P`: パックを開く
- `Ctrl` + `Alt` + `S`: 設定を開く

### プロジェクト

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: 元に戻す
- `Ctrl` + `Y`: やり直します
- `Ctrl` + `Shift` + `P`: ウェイポイントダイアログを開く
- `Ctrl` + `B`: 背景ダイアログを開く
- `Ctrl` + `S`: 保存
- `Alt` + `S`: パスを変更
- `Ctrl` + (`1` - `0`): ツールに切り替える
- `Ctrl` + `+`: 拡大
- `Ctrl` + `-`: 縮小

## ペン

デフォルトでは、ペンは次のように機能するように設定されています。

- `Pen`: ペンとして設定されています。
- `First` (サポートされている場合はプライマリボタン): 押したまま手動ツールに変更します。
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to customize your toolbar, see [The Document View](../intro/#important-notes).

format@@0(toolbar_numbered.png)