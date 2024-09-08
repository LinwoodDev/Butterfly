---
title: Bädda in
---

Inbäddning är ett enkelt sätt att inkludera appen på din webbplats.
Lägg till följande kod på din webbplats:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Alternativ

| Alternativ | Typ                                                                                                | Standard | Beskrivning                                                                                                                                                                             |
| ---------- | -------------------------------------------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| spara      | Boolesk (sant, falskt)                                                          | sant     | Aktivera spara. Om inaktiverad, visas endast en avgångsknapp                                                                                                            |
| redigerbar | Boolesk (sant, falskt)                                                          | sant     | Aktivera redigering. Om inaktiverad, kommer dokumentet att skrivas enbart                                                                                               |
| språk      | Sträng (..., system, användare) | system   | Språk i dokumentet. Om systemet, kommer språket att upptäckas från webbläsaren. Om användaren kommer språket att ställas in efter användarens preferens |

## Händelser

Exempel på hur du använder den:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### spara

> Händelsen `save` avges när användaren klickar på knappen "Spara".

Parametrar:

- `data` (Skriv `List<int>`): Dokumentets data.

### avsluta

> Händelsen "exit" avges när användaren klickar på exitknappen.

Parametrar:

- `data` (Skriv `List<int>`): Dokumentets data.

### ändra

> Händelsen `change` avges när användaren ändrar dokumentet.

Parametrar:

- `data` (Skriv `List<int>`): Dokumentets data.

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

> Metoden `getData` returnerar data i dokumentet.

Inga parametrar.
Returer: `Lista<int>`

### setData

> `setData`-metoden anger dokumentets data.

Parametrar:

- `data` (Skriv `List<int>`): Dokumentets data.

### renderare

> `render`-metoden renderar dokumentet till en png-bild.

Parametrar:

- `width` (Skriv `Number`): Bredden på bilden.
- `height` (Skriv `Number`): Höjden på bilden.
- `scale` (Skriv `Number`): Skalan på bilden.
- `renderBackground` (Skriv `Boolean`): Om det är sant kommer bakgrunden att renderas.

Returer: `String` (Base64-kodad bild)

### renderSVG

> `renderSVG`-metoden renderar dokumentet till en svg-bild.

Parametrar:

- `width` (Skriv `Number`): Bredden på bilden.
- `height` (Skriv `Number`): Höjden på bilden.
- `renderBackground` (Skriv `Boolean`): Om det är sant kommer bakgrunden att renderas.

Returer: `String` (SVG)
