---
title: Einbetten
---

Einbetten ist eine einfache Möglichkeit, die App in Ihre Website einzubinden.
Fügen Sie den folgenden Code Ihrer Webseite hinzu:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Optionen

| Option     | Typ                                                                                               | Standard | Beschreibung                                                                                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| speichern  | Boolesche (wahr, falsch)                                                       | wahr     | Speichern aktivieren. Wenn deaktiviert, wird nur ein Beenden-Button angezeigt                                                                                  |
| editierbar | Boolesche (wahr, falsch)                                                       | wahr     | Bearbeiten aktivieren. Wenn deaktiviert, wird das Dokument schreibgeschützt                                                                                    |
| sprache    | String (..., System, Benutzer) | system   | Sprache des Dokuments. Wenn System wird die Sprache vom Browser erkannt. Wenn Benutzer, wird die Sprache auf die Benutzereinstellungen gesetzt |

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

> Das `save` Event wird emittiert, wenn der Benutzer auf den Speicherknopf klickt.

Parameter:

- `data` (Typ `Liste<int>`): Die Daten des Dokuments.

### beenden

> Das `exit` Event wird emittiert, wenn der Benutzer auf den Beenden-Button klickt.

Parameter:

- `data` (Typ `Liste<int>`): Die Daten des Dokuments.

### ändern

> Das `change` Ereignis wird emittiert, wenn der Benutzer das Dokument ändert.

Parameter:

- `data` (Typ `Liste<int>`): Die Daten des Dokuments.

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

> Die `getData` Methode gibt die Daten des Dokuments zurück.

Keine Parameter.
Rückgaben: `Liste<int>`

### setData

> Die `setData` Methode legt die Daten des Dokuments fest.

Parameter:

- `data` (Typ `Liste<int>`): Die Daten des Dokuments.

### rendern

> Die Methode `render` stellt das Dokument zu einem PNG-Bild dar.

Parameter:

- `width` (Typ `Number`): Die Breite des Bildes.
- `height` (Typ `Number`): Die Höhe des Bildes.
- `scale` (Typ `Number`): Der Maßstab des Bildes.
- `renderBackground` (Typ `Boolean`): Wenn true wird der Hintergrund dargestellt.

Gibt `String` zurück (Base64-kodiertes Bild)

### renderSVG

> Die `renderSVG` Methode stellt das Dokument zu einem svg-Bild dar.

Parameter:

- `width` (Typ `Number`): Die Breite des Bildes.
- `height` (Typ `Number`): Die Höhe des Bildes.
- `renderBackground` (Typ `Boolean`): Wenn true wird der Hintergrund dargestellt.

Rückgaben: `String` (SVG)
