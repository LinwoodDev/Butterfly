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
| Sprache     | String (..., System, Benutzer) | user     | Sprache des Dokuments. Wenn System wird die Sprache vom Browser erkannt. Wenn Benutzer, wird die Sprache auf die Benutzereinstellungen gesetzt |

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

Parameter:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Typ `Number`): Die Breite des Bildes.
- `height` (Typ `Number`): Die Höhe des Bildes.
- `scale` (Typ `Number`): Die Skalierung des Bildes.
- `renderBackground` (Typ `Boolean`): Wenn true, wird der Hintergrund gerendert.

Rückgabe: `String` (Base64-kodiertes Bild)

### renderSVG

> Die Methode `renderSVG` rendert das Dokument als SVG-Bild.

Parameter:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Typ `Number`): Die Breite des Bildes.
- `height` (Typ `Number`): Die Höhe des Bildes.
- `renderBackground` (Typ `Boolean`): Wenn true, wird der Hintergrund gerendert.

Rückgabe: `String` (SVG)
