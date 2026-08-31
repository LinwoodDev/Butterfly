---
title: Einbetten
---

Einbetten ist eine einfache Möglichkeit, die App in Ihre Website einzubinden.
Fügen Sie den folgenden Code Ihrer Webseite hinzu:

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed"
  width="100%"
  height="500px"
  allowtransparency="true"
></iframe>
```

## Optionen

| Option      | Typ                                                                                               | Standard | Beschreibung                                                                                                                                                                   |
| ----------- | ------------------------------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| speichern   | Boolean (true, false)                                                          | true     | Speichern aktivieren. Wenn deaktiviert, wird nur eine Beenden-Schaltfläche angezeigt                                                                           |
| bearbeitbar | Boolean (true, false)                                                          | true     | Bearbeiten aktivieren. Wenn deaktiviert, wird das Dokument schreibgeschützt                                                                                    |
| fullScreen  | String (enabled, layoutOnly, startInLayout, forced, disabled)                  | enabled  | Configure full-screen behavior. Embeds never enter browser or system full screen automatically                                                                 |
| Sprache     | String (..., System, Benutzer) | user     | Sprache des Dokuments. Wenn System wird die Sprache vom Browser erkannt. Wenn Benutzer, wird die Sprache auf die Benutzereinstellungen gesetzt |
| fileName    | String                                                                                            |          | Display this file name in the embed title. It is visual only and does not change the document metadata                                                         |

### Full-screen modes

| Wert          | Initial layout | Toggle | Browser/system full screen |
| ------------- | -------------- | ------ | -------------------------- |
| enabled       | Normal         | Ja     | When enabled by the user   |
| layoutOnly    | Normal         | Ja     | Nie                        |
| startInLayout | Vollbild       | Ja     | Nie                        |
| forced        | Vollbild       | Nein   | Nie                        |
| disabled      | Normal         | Nein   | Nie                        |

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

## Ereignisse

Listen for events with `window.addEventListener('message', ...)`.

### speichern

> Das Ereignis `save` wird ausgelöst, wenn der Benutzer auf die Schaltfläche zum Speichern klickt.

Parameter:

- `message` (Type `List<int>`): The data of the document.

### beenden

> Das Ereignis `exit` wird ausgelöst, wenn der Benutzer auf die Schaltfläche zum Beenden klickt.

Parameter:

- `message` (Type `List<int>`): The data of the document.

### change

> Das Ereignis `change` wird ausgelöst, wenn der Benutzer das Dokument ändert.

Parameter:

- `message` (Type `List<int>`): The data of the document.

## Methoden

Call methods with `iframe.contentWindow.postMessage(...)`. Methods that return
data send another message back with the same `type`.

### getData

> Die Methode `getData` gibt die Daten des Dokuments zurück.

Keine Parameter.
Rückgabe: `List<int>`

### setData

> Die Methode `setData` setzt die Daten des Dokuments.

Parameter:

- `data` (Typ `List<int>`): Die Daten des Dokuments.

### render

> Die Methode `render` rendert das Dokument als PNG-Bild.

All parameters are optional. With no camera or size parameters, Butterfly
exports the current visible canvas view. To export from the document origin,
set `x: 0`, `y: 0`, `scale: 1`, and `rotation: 0` together with the desired
output size.

Padding expands the output dimensions: the final width is `width + left + right`
and the final height is `height + top + bottom`.

Parameter:

| Parameter          | Typ       | Standard                | Beschreibung                                                                                |
| ------------------ | --------- | ----------------------- | ------------------------------------------------------------------------------------------- |
| `x`                | `Number`  | Current view x          | Document x position of the exported view.                                   |
| `y`                | `Number`  | Current view y          | Document y position of the exported view.                                   |
| `width`            | `Number`  | Current viewport width  | Output width in pixels.                                                     |
| `height`           | `Number`  | Current viewport height | Output height in pixels.                                                    |
| `scale`            | `Number`  | Current zoom            | Camera zoom used for the export.                                            |
| `rotation`         | `Number`  | Current rotation        | Camera rotation in radians.                                                 |
| `padding`          | `Object`  | All sides `0`           | Extra output pixels added with `top`, `right`, `bottom`, and `left` fields. |
| `renderBackground` | `Boolean` | `true`                  | Whether to include the document background.                                 |

Rückgabe: `String` (Base64-kodiertes Bild)

### renderSVG

> Die Methode `renderSVG` rendert das Dokument als SVG-Bild.

It accepts the same optional view parameters as `render`. Omitting them exports
the current visible canvas view; explicitly setting an identity camera exports
from the document origin.

Parameter:

| Parameter          | Typ       | Standard                | Beschreibung                                                                                |
| ------------------ | --------- | ----------------------- | ------------------------------------------------------------------------------------------- |
| `x`                | `Number`  | Current view x          | Document x position of the exported view.                                   |
| `y`                | `Number`  | Current view y          | Document y position of the exported view.                                   |
| `width`            | `Number`  | Current viewport width  | Output width in pixels.                                                     |
| `height`           | `Number`  | Current viewport height | Output height in pixels.                                                    |
| `scale`            | `Number`  | Current zoom            | Camera zoom used for the export.                                            |
| `rotation`         | `Number`  | Current rotation        | Camera rotation in radians.                                                 |
| `padding`          | `Object`  | All sides `0`           | Extra output pixels added with `top`, `right`, `bottom`, and `left` fields. |
| `renderBackground` | `Boolean` | `true`                  | Whether to include the document background.                                 |

Rückgabe: `String` (SVG)
