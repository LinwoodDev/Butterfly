---
title: Embed
---

埋め込みはあなたのウェブサイトにアプリを含める簡単な方法です。
次のコードをウェブサイトに追加します。

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## オプション

| Option   | タイプ                                                                                    | デフォルト  | 説明                                                                                           |
| -------- | -------------------------------------------------------------------------------------- | ------ | -------------------------------------------------------------------------------------------- |
| 保存       | Boolean (true, false)                                               | true   | Enable save. If disabled, only an exit button will be shown                  |
| editable | Boolean (true, false)                                               | true   | Enable editing. 無効にすると、ドキュメントは読み取り専用になります                                    |
| 言語       | 文字列 (...、システム、ユーザー) | system | Language of the document. システムの場合、言語はブラウザから検出されます。 ユーザーの場合、言語はユーザーの好みに設定されます |

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

> The `save` event is emitted when the user clicks the save button.

パラメータ:

- `data` (Type `List<int>`): The data of the document.

### 終了

> The `exit` event is emitted when the user clicks the exit button.

パラメータ:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

パラメータ:

- `data` (Type `List<int>`): The data of the document.

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

> The `getData` method returns the data of the document.

パラメータはありません。
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

パラメータ:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

パラメータ:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

パラメータ:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
