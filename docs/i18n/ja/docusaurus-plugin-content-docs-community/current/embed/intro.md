---
title: 埋め込み
sidebar_label: はじめに
---

埋め込みはあなたのウェブサイトにアプリを含める簡単な方法です。 次のコードをウェブサイトに追加します。

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## オプション

| Option   | タイプ                   | デフォルト  | 説明                                                                               |
| -------- | --------------------- | ------ | -------------------------------------------------------------------------------- |
| save     | Boolean (true, false) | true   | 保存を有効にする 無効にすると、終了ボタンだけが表示されます                                                   |
| editable | Boolean (true, false) | true   | 編集を有効にする 編集を有効にする 編集を有効にする 編集を有効にする 編集を有効にする 無効にすると、ドキュメントは読み取り専用になります           |
| language | 文字列 (...、システム、ユーザー)   | system | 文書の言語 文書の言語 文書の言語 文書の言語 文書の言語 システムの場合、言語はブラウザから検出されます。 ユーザーの場合、言語はユーザーの好みに設定されます |

## イベント

使用例:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### save

> `save` イベントは、ユーザーがセーブボタンをクリックすると発生します。

パラメータ:

* `data` (Type `List<int>`): ドキュメントのデータ。

### exit

> `exit` イベントは、ユーザが終了ボタンをクリックしたときに発生します。

パラメータ:

* `data` (Type `List<int>`): ドキュメントのデータ。

### change

> `change` イベントは、ユーザーがドキュメントを変更したときに発生します。

パラメータ:

* `data` (Type `List<int>`): ドキュメントのデータ。

## メソッド

使い方の例

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'getData') {
    console.log(data.detail.message);
  }
});
```

### getData

> `getData` メソッドは、ドキュメントのデータを返します。

パラメータはありません。 戻り値: `リスト<int>`

### setData

> `setData` メソッドは、ドキュメントのデータを設定します。

パラメータ:

* `data` (Type `List<int>`): ドキュメントのデータ。

### render

> `render` メソッドはドキュメントを png 画像にレンダリングします。

パラメータ:

* `width` (Type `Number`): 画像の幅。
* `height` (Type `Number`): 画像の高さ。
* `scale` (Type `Number`): 画像のスケール。
* `renderBackground` (Type `Boolean`): true の場合、背景がレンダリングされます。

戻り値: `String` (Base64 encoded image)

### renderSVG

> `renderSVG` メソッドはドキュメントを svg イメージにレンダリングします。

パラメータ:

* `width` (Type `Number`): 画像の幅。
* `height` (Type `Number`): 画像の高さ。
* `renderBackground` (Type `Boolean`): true の場合、背景がレンダリングされます。

戻り値: `String` (SVG)
