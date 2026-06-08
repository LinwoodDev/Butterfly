---
title: Yerleştirme
---

Yerleştirme işlemi, uygulamayı web sitenize dahil etmenin basit bir yoludur.
Aşağıdaki kodu web sitenize ekleyin:

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed"
  width="100%"
  height="500px"
  allowtransparency="true"
></iframe>
```

## Şeçenekler

| Seçenek  | Tür                                                                                           | Varsayılan | Tanım                                                                                                                                                             |
| -------- | --------------------------------------------------------------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| kaydet   | Boolean (true, false)                                                      | true       | Kaydetmeyi etkinleştirin. Eğer devre dışı bırakılırsa, yalnızca bir çıkış düğmesi gösterilir                                                      |
| editable | Boolean (true, false)                                                      | true       | Düzenlemeyi etkinleştir. Eğer devre dışı bırakılırsa, belge salt okunur olur                                                                      |
| dil      | String (..., system, user) | user       | Belge dili. Eğer sistem ise, dil tarayıcıdan algılanacaktır. Eğer kullanıcı ise, dil kullanıcıların tercihine göre ayarlanacaktır |

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
  src="https://web.butterfly.linwood.dev/embed?save=true&editable=true"
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
  });

  butterfly.addEventListener('load', () => {
    sendToButterfly('getData');

    sendToButterfly('render', {
      x: 0,
      y: 0,
      width: 600,
      height: 400,
      scale: 1,
      renderBackground: true,
    });
  });
</script>
```

To load document bytes into the embed, send an array of byte values:

```javascript
sendToButterfly('setData', documentBytes);
```

## Etkinlikler

Listen for events with `window.addEventListener('message', ...)`.

### kaydet

> The `save` event is emitted when the user clicks the save button.

Parametreler:

- `message` (Type `List<int>`): The data of the document.

### çıkış

> The `exit` event is emitted when the user clicks the exit button.

Parametreler:

- `message` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parametreler:

- `message` (Type `List<int>`): The data of the document.

## Yöntemler

Call methods with `iframe.contentWindow.postMessage(...)`. Methods that return
data send another message back with the same `type`.

### getData

> The `getData` method returns the data of the document.

Tür
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parametreler:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parametreler:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parametreler:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
