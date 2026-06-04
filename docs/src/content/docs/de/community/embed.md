---
title: Einbetten
---

Einbetten ist eine einfache Möglichkeit, die App in Ihre Website einzubinden.
Fügen Sie den folgenden Code Ihrer Webseite hinzu:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Optionen

| Option      | Typ                                                                                               | Standard | Beschreibung                                                                                                                                                                   |
| ----------- | ------------------------------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| speichern   | Boolean (true, false)                                                          | true     | Speichern aktivieren. Wenn deaktiviert, wird nur eine Beenden-Schaltfläche angezeigt                                                                           |
| bearbeitbar | Boolean (true, false)                                                          | true     | Bearbeiten aktivieren. Wenn deaktiviert, wird das Dokument schreibgeschützt                                                                                    |
| Sprache     | String (..., System, Benutzer) | System   | Sprache des Dokuments. Wenn System wird die Sprache vom Browser erkannt. Wenn Benutzer, wird die Sprache auf die Benutzereinstellungen gesetzt |

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

> Das Ereignis `save` wird ausgelöst, wenn der Benutzer auf die Schaltfläche zum Speichern klickt.

Parameter:

- `data` (Typ `List<int>`): Die Daten des Dokuments.

### beenden

> Das Ereignis `exit` wird ausgelöst, wenn der Benutzer auf die Schaltfläche zum Beenden klickt.

Parameter:

- `data` (Typ `List<int>`): Die Daten des Dokuments.

### change

> Das Ereignis `change` wird ausgelöst, wenn der Benutzer das Dokument ändert.

Parameter:

- `data` (Typ `List<int>`): Die Daten des Dokuments.

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

- `width` (Typ `Number`): Die Breite des Bildes.
- `height` (Typ `Number`): Die Höhe des Bildes.
- `scale` (Typ `Number`): Die Skalierung des Bildes.
- `renderBackground` (Typ `Boolean`): Wenn true, wird der Hintergrund gerendert.

Rückgabe: `String` (Base64-kodiertes Bild)

### renderSVG

> Die Methode `renderSVG` rendert das Dokument als SVG-Bild.

Parameter:

- `width` (Typ `Number`): Die Breite des Bildes.
- `height` (Typ `Number`): Die Höhe des Bildes.
- `renderBackground` (Typ `Boolean`): Wenn true, wird der Hintergrund gerendert.

Rückgabe: `String` (SVG)
