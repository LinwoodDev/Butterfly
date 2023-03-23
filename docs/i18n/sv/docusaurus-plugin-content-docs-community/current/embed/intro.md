---
title: Bädda in
sidebar_label: Introduktion
---

Inbäddning är ett enkelt sätt att inkludera appen på din webbplats. Lägg till följande kod på din webbplats:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Alternativ

| Alternativ | Typ                             | Standard | Beskrivning                                                                                                                                             |
| ---------- | ------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| save       | Boolean (true, false)           | true     | Aktivera spara. Om inaktiverad, visas endast en avgångsknapp                                                                                            |
| editable   | Boolean (true, false)           | true     | Aktivera redigering. Om inaktiverad, kommer dokumentet att skrivas enbart                                                                               |
| language   | Sträng (..., system, användare) | system   | Språk i dokumentet. Om systemet, kommer språket att upptäckas från webbläsaren. Om användaren kommer språket att ställas in efter användarens preferens |

## Händelser

Exempel på hur du använder den:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Spara...', data.detail.message);
  }
});
```

### save

> Händelsen `spara` släpps ut när användaren klickar på knappen Spara.

Parametrar:

* `data` (Typ `Sträng`): Dokumentets data.

### exit

> Händelsen `exit` avges när användaren klickar på utgångsknappen.

Parametrar:

* `data` (Typ `Sträng`): Dokumentets data.

### change

> Händelsen `ändra` släpps ut när användaren ändrar dokumentet.

Parametrar:

* `data` (Typ `Sträng`): Dokumentets data.

## Metoder

Exempel på hur du använder den:

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

> Metoden `getData` returnerar data från dokumentet.

Inga parametrar. Returer: `Sträng`

### setData

> Metoden `setData` anger data för dokumentet.

Parametrar:

* `data` (Typ `Sträng`): Dokumentets data.

### render

> Metoden `render` renderar dokumentet till en png bild.

Parametrar:

* `bredd` (Typ `Nummer`): Bredden på bilden.
* `höjd` (Typ `Nummer`): Höjden på bilden.
* `skala` (Typ `Nummer`): Skalan på bilden.
* `renderBakgrund` (Typ `Boolesk`): Om sann kommer bakgrunden att renderas.

Returer: `Sträng` (Base64-kodad bild)

### renderSVG

> Metoden `renderSVG` renderar dokumentet till en svg-bild.

Parametrar:

* `bredd` (Typ `Nummer`): Bredden på bilden.
* `höjd` (Typ `Nummer`): Höjden på bilden.
* `renderBakgrund` (Typ `Boolesk`): Om sann kommer bakgrunden att renderas.

Returer: `Sträng` (SVG)
