---
title: Indlejr
---

Embedding is a simple way to include the app in your website.
Add the following code to your website:

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed"
  width="100%"
  height="500px"
  allowtransparency="true"
></iframe>
```

## Indstillinger

| Valgmulighed | Type                                                                                            | Standard | Varebeskrivelse                                                                                                                                                             |
| ------------ | ----------------------------------------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| gem          | Boolean (true, false)                                                        | true     | Enable save. If disabled, only an exit button will be shown                                                                                                 |
| editable     | Boolean (true, false)                                                        | true     | Enable editing. If disabled, the document will be read-only                                                                                                 |
| sprog        | Streng (..., system, bruger) | user     | Language of the document. If system, the language will be detected from the browser. If user, the language will set to the users preference |

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

## Begivenheder

Listen for events with `window.addEventListener('message', ...)`.

### gem

> The `save` event is emitted when the user clicks the save button.

Parametre:

- `message` (Type `List<int>`): The data of the document.

### afslut

> The `exit` event is emitted when the user clicks the exit button.

Parametre:

- `message` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parametre:

- `message` (Type `List<int>`): The data of the document.

## Metoder

Call methods with `iframe.contentWindow.postMessage(...)`. Methods that return
data send another message back with the same `type`.

### getData

> The `getData` method returns the data of the document.

No parameters.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parametre:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parametre:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parametre:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
