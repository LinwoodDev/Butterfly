---
title: 埋め込み
---

埋め込みはあなたのウェブサイトにアプリを含める簡単な方法です。
次のコードをウェブサイトに追加します。

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## オプション

| Option | タイプ                                                                                    | デフォルト | 説明                                                       |
| ------ | -------------------------------------------------------------------------------------- | ----- | -------------------------------------------------------- |
| 保存     | ブール値 (true, false)                                                  | true  | 保存を有効にする 無効にすると、終了ボタンだけが表示されます                           |
| 編集可能   | ブール値 (true, false)                                                  | true  | 編集を有効にする 無効にすると、ドキュメントは読み取り専用になります                       |
| 言語     | 文字列 (...、システム、ユーザー) | システム  | 文書の言語 システムの場合、言語はブラウザから検出されます。 ユーザーの場合、言語はユーザーの好みに設定されます |

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

### 保存

> ユーザーがセーブボタンをクリックすると、`save` イベントが発生します。

パラメータ:

- `data` (Type `List<int>`): ドキュメントのデータ。

### 終了

> 終了ボタンをクリックすると、`exit` イベントが発生します。

パラメータ:

- `data` (Type `List<int>`): ドキュメントのデータ。

### 変更

> `change` イベントは、ユーザーがドキュメントを変更したときに発生します。

パラメータ:

- `data` (Type `List<int>`): ドキュメントのデータ。

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

> `getData` メソッドはドキュメントのデータを返します。

パラメータはありません。
戻り値: `List<int>`

### setData

> `setData` メソッドはドキュメントのデータを設定します。

パラメータ:

- `data` (Type `List<int>`): ドキュメントのデータ。

### レンダリング

> `render` メソッドはドキュメントを png 画像にレンダリングします。

パラメータ:

- `width` (Type `Number`): 画像の幅。
- `height` (Type `Number`): 画像の高さ。
- `scale` (Type `Number`): イメージのスケール。
- `renderBackground` (Type `Boolean`): true の場合、背景がレンダリングされます。

戻り値: `String` (Base64 エンコードされた画像)

### renderSVG

> `renderSVG` メソッドはドキュメントを svg イメージにレンダリングします。

パラメータ:

- `width` (Type `Number`): 画像の幅。
- `height` (Type `Number`): 画像の高さ。
- `renderBackground` (Type `Boolean`): true の場合、背景がレンダリングされます。

戻り値: `String` (SVG)
