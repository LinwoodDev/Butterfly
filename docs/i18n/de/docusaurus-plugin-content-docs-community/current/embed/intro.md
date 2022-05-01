---
title: Einbetten
sidebar_label: Einleitung
---

Einbetten ist eine einfache Möglichkeit, die App in Ihre Website einzubinden. Fügen Sie den folgenden Code Ihrer Webseite hinzu:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Optionen

| Option     | Typ                            | Standard | Beschreibung                                                                                             |
| ---------- | ------------------------------ | -------- | -------------------------------------------------------------------------------------------------------- |
| speichern  | Boolesche (wahr, falsch)       | true     | Speichern aktivieren. Wenn deaktiviert, wird nur ein Beenden-Button angezeigt                            |
| editierbar | Boolesche (wahr, falsch)       | true     | Bearbeiten aktivieren. Wenn deaktiviert, wird das Dokument schreibgeschützt                              |
| thema      | benutzer, System, hell, dunkel | benutzer | Das zu verwendende Theme. Wenn Benutzer, wird das Thema vom Benutzer in den Einstellungen ausgewählt     |
| sprache    | String                         | benutzer | Die zu verwendende Sprache. Wenn Benutzer, wird die Sprache vom Benutzer in den Einstellungen ausgewählt |

## Ereignisse

Beispiele wie man es verwendet:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('save', (data) => {
  console.log('Speichern...');
});
```

### speichern

> Das Ereignis `speichern` wird abgesendet, wenn der Benutzer auf den Speicherknopf klickt.

Parameter:

* `Daten` (Typ `Zeichenkette`): Die Daten des Dokuments.

### beenden

> Das `Exit` Event wird abgesendet, wenn der Benutzer auf den Exit-Button klickt.

Parameter:

* `Daten` (Typ `Zeichenkette`): Die Daten des Dokuments.

### ändern

> Das `Änderungs-` Ereignis wird abgesendet, wenn der Benutzer das Dokument ändert.

Parameter:

* `Daten` (Typ `Zeichenkette`): Die Daten des Dokuments.

## Methoden

Beispiel wie man es nutzt:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.dispatchEvent(new CustomEvent('getData', {}));
embedElement.addEventListener('message', (data) => {
  if(data.type === 'getData') {
    console.log(data.message);
  }
});
```

### getData

> Die `getData` Methode gibt die Daten des Dokuments zurück.

Keine Parameter. Rückgabewerte: `Zeichenkette`

### setData

> Die `setData` Methode legt die Daten des Dokuments fest.

Parameter:

* `Daten` (Typ `Zeichenkette`): Die Daten des Dokuments.

### rendern

> Die `Rendering-` Methode macht das Dokument zu einem PNG-Bild.

Parameter:

* `Breite` (Typ `Nummer`): Die Breite des Bildes.
* `Höhe` (Typ `Nummer`): Die Höhe des Bildes.
* `Skala` (Typ `Nummer`): Die Skala des Bildes.
* `RenderHintergrund` (Typ `Boolesche`): Falls aktiviert, wird der Hintergrund gerendert.

Gibt zurück: `String` (Base64 kodiertes Bild)

### renderSVG

> Die `RenderSVG` Methode macht das Dokument zu einem svg-Bild.

Parameter:

* `Breite` (Typ `Nummer`): Die Breite des Bildes.
* `Höhe` (Typ `Nummer`): Die Höhe des Bildes.
* `RenderHintergrund` (Typ `Boolesche`): Falls aktiviert, wird der Hintergrund gerendert.

Rückgabewerte: `Zeichenkette` (SVG)
