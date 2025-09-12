---
title: Einbetten
---

Einbetten ist eine einfache Möglichkeit, die App in Ihre Website einzubinden.
Fügen Sie den folgenden Code Ihrer Webseite hinzu:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Optionen

| Option    | Typ                                                                                               | Standard | Beschreibung                                                                                                                                                                   |
| --------- | ------------------------------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| speichern | Boolean (true, false)                                                          | true     | Speichern aktivieren. Wenn deaktiviert, wird nur ein Beenden-Button angezeigt                                                                                  |
| editable  | Boolean (true, false)                                                          | true     | Bearbeiten aktivieren. Wenn deaktiviert, wird das Dokument schreibgeschützt                                                                                    |
| Sprache   | String (..., System, Benutzer) | system   | Sprache des Dokuments. Wenn System wird die Sprache vom Browser erkannt. Wenn Benutzer, wird die Sprache auf die Benutzereinstellungen gesetzt |

## Ereignisse

Beispiele wie man es verwendet:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### speichern

> The `save` event is emitted when the user clicks the save button.

Parameter:

- `data` (Type `List<int>`): The data of the document.

### beenden

> The `exit` event is emitted when the user clicks the exit button.

Parameter:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parameter:

- `data` (Type `List<int>`): The data of the document.

## Methoden

Beispiel wie man es nutzt:

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

Keine Parameter.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parameter:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parameter:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parameter:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
