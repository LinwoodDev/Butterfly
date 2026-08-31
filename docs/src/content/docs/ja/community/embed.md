---
title: Embed
---

埋め込みはあなたのウェブサイトにアプリを含める簡単な方法です。
次のコードをウェブサイトに追加します。

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed"
  width="100%"
  height="500px"
  allowtransparency="true"
></iframe>
```

## オプション

| Option     | タイプ                                                                                    | デフォルト   | 説明                                                                                                                     |
| ---------- | -------------------------------------------------------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------- |
| 保存         | Boolean (true, false)                                               | true    | Enable save. If disabled, only an exit button will be shown                                            |
| editable   | Boolean (true, false)                                               | true    | Enable editing. 無効にすると、ドキュメントは読み取り専用になります                                                              |
| fullScreen | String (enabled, layoutOnly, startInLayout, forced, disabled)       | enabled | Configure full-screen behavior. Embeds never enter browser or system full screen automatically         |
| 言語         | 文字列 (...、システム、ユーザー) | user    | Language of the document. システムの場合、言語はブラウザから検出されます。 ユーザーの場合、言語はユーザーの好みに設定されます                           |
| fileName   | String                                                                                 |         | Display this file name in the embed title. It is visual only and does not change the document metadata |

### Full-screen modes

| 値             | Initial layout | Toggle | Browser/system full screen |
| ------------- | -------------- | ------ | -------------------------- |
| enabled       | 標準             | はい     | When enabled by the user   |
| layoutOnly    | 標準             | はい     | 一切なし                       |
| startInLayout | 全画面            | はい     | 一切なし                       |
| forced        | 全画面            | いいえ    | 一切なし                       |
| disabled      | 標準             | いいえ    | 一切なし                       |

## Messaging

The embed uses browser `postMessage` events. Send messages to the iframe with
`iframe.contentWindow.postMessage({ type, message }, origin)`. Butterfly sends
messages back to the parent window with the same shape:
`{ type: string, message?: unknown }`.

See the [embedding example](/community/embed-example/) for a live page that sends
messages to the iframe and listens for messages from it.

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed?save=true&editable=true&fileName=Example.bfly"
  width="100%"
  height="500"
></iframe>

<script>
  const butterflyOrigin = 'https://web.butterfly.linwood.dev';
  const butterfly = document.querySelector('#butterfly');

  function sendToButterfly(type, message) {
    butterfly.contentWindow.postMessage({ type, message }, butterflyOrigin);
  }

  window.addEventListener('message', (event) => {
    if (
      event.origin !== butterflyOrigin ||
      event.source !== butterfly.contentWindow
    ) {
      return;
    }

    const { type, message } = event.data ?? {};

    if (type === 'save') {
      const documentBytes = Array.from(message);
      console.log('Save requested by the embed', documentBytes);
    }

    if (type === 'exit') {
      const documentBytes = Array.from(message);
      console.log('Exit requested by the embed', documentBytes);
    }

    if (type === 'change') {
      console.log('Document changed', message);
    }

    if (type === 'getData') {
      console.log('Current document bytes', message);
    }

    if (type === 'render') {
      const image = new Image();
      image.src = `data:image/png;base64,${message}`;
      document.body.append(image);
    }

    if (type === 'renderSVG') {
      const preview = document.createElement('div');
      preview.innerHTML = message;
      document.body.append(preview);
    }
  });

  butterfly.addEventListener('load', () => {
    sendToButterfly('getData');

    // Omit camera and size fields to render the current visible canvas view.
    sendToButterfly('render', {
      renderBackground: true,
    });

    // Set the camera explicitly to render from the document origin instead.
    sendToButterfly('render', {
      x: 0,
      y: 0,
      width: 600,
      height: 400,
      scale: 1,
      rotation: 0,
      padding: { top: 0, right: 0, bottom: 0, left: 0 },
      renderBackground: true,
    });
  });
</script>
```

To load document bytes into the embed, send an array of byte values:

```javascript
sendToButterfly('setData', documentBytes);
```

## イベント

Listen for events with `window.addEventListener('message', ...)`.

### 保存

> The `save` event is emitted when the user clicks the save button.

パラメータ:

- `message` (Type `List<int>`): The data of the document.

### 終了

> The `exit` event is emitted when the user clicks the exit button.

パラメータ:

- `message` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

パラメータ:

- `message` (Type `List<int>`): The data of the document.

## メソッド

Call methods with `iframe.contentWindow.postMessage(...)`. Methods that return
data send another message back with the same `type`.

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

All parameters are optional. With no camera or size parameters, Butterfly
exports the current visible canvas view. To export from the document origin,
set `x: 0`, `y: 0`, `scale: 1`, and `rotation: 0` together with the desired
output size.

Padding expands the output dimensions: the final width is `width + left + right`
and the final height is `height + top + bottom`.

パラメータ:

| Parameter          | タイプ       | デフォルト                   | 説明                                                                                          |
| ------------------ | --------- | ----------------------- | ------------------------------------------------------------------------------------------- |
| `x`                | `Number`  | Current view x          | Document x position of the exported view.                                   |
| `y`                | `Number`  | Current view y          | Document y position of the exported view.                                   |
| `width`            | `Number`  | Current viewport width  | Output width in pixels.                                                     |
| `height`           | `Number`  | Current viewport height | Output height in pixels.                                                    |
| `scale`            | `Number`  | Current zoom            | Camera zoom used for the export.                                            |
| `rotation`         | `Number`  | Current rotation        | Camera rotation in radians.                                                 |
| `padding`          | `Object`  | All sides `0`           | Extra output pixels added with `top`, `right`, `bottom`, and `left` fields. |
| `renderBackground` | `Boolean` | `true`                  | Whether to include the document background.                                 |

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

It accepts the same optional view parameters as `render`. Omitting them exports
the current visible canvas view; explicitly setting an identity camera exports
from the document origin.

パラメータ:

| Parameter          | タイプ       | デフォルト                   | 説明                                                                                          |
| ------------------ | --------- | ----------------------- | ------------------------------------------------------------------------------------------- |
| `x`                | `Number`  | Current view x          | Document x position of the exported view.                                   |
| `y`                | `Number`  | Current view y          | Document y position of the exported view.                                   |
| `width`            | `Number`  | Current viewport width  | Output width in pixels.                                                     |
| `height`           | `Number`  | Current viewport height | Output height in pixels.                                                    |
| `scale`            | `Number`  | Current zoom            | Camera zoom used for the export.                                            |
| `rotation`         | `Number`  | Current rotation        | Camera rotation in radians.                                                 |
| `padding`          | `Object`  | All sides `0`           | Extra output pixels added with `top`, `right`, `bottom`, and `left` fields. |
| `renderBackground` | `Boolean` | `true`                  | Whether to include the document background.                                 |

Returns: `String` (SVG)
