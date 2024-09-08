---
title: Indlejr
---

Indlejring er en enkel måde at inkludere appen på din hjemmeside.
Tilføj følgende kode til dit websted:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Indstillinger

| Valgmulighed | Type                                                                                            | Standard | Varebeskrivelse                                                                                                                                                            |
| ------------ | ----------------------------------------------------------------------------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| gem          | Boolsk (sandt, falsk)                                                        | sandt    | Aktiver gemning. Hvis deaktiveret, vil kun en afslutningsknap blive vist                                                                                   |
| redigerbar   | Boolsk (sandt, falsk)                                                        | sandt    | Aktiver redigering. Hvis deaktiveret, vil dokumentet være skrivebeskyttet                                                                                  |
| sprog        | Streng (..., system, bruger) | system   | Sprog for dokumentet. Hvis systemet, sproget vil blive opdaget fra browseren. Hvis bruger, vil sproget blive sat til brugernes præferencer |

## Begivenheder

Eksempler på hvordan man bruger det:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### gem

> Den `save` begivenhed udsendes, når brugeren klikker på Gem knappen.

Parametre:

- `data` (Type `Liste<int>`): Dokumentets data.

### afslut

> Begivenheden 'exit' udsendes, når brugeren klikker på exit knappen.

Parametre:

- `data` (Type `Liste<int>`): Dokumentets data.

### skift

> The `change` event is emitted when the user changes the document (Automatic Copy)

Parametre:

- `data` (Type `Liste<int>`): Dokumentets data.

## Metoder

Eksempel på, hvordan den bruges:

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

> Metoden `getData` returnerer dokumentets data.

Ingen parametre.
Returnering: `Liste<int>`

### setData

> Metoden `setData` angiver dokumentets data.

Parametre:

- `data` (Type `Liste<int>`): Dokumentets data.

### gengiver

> Metoden 'render' gør dokumentet til et png billede.

Parametre:

- `width` (Type `Number`): Bredden af billedet.
- `højde` (Type `Number`): Højden af billedet.
- `skala` (Type `Number`): Billedets skala.
- `renderBackground` (Type `Boolean`): Hvis sandt, vil baggrunden blive gengivet.

Returnering: `String` (Base64 kodet billede)

### renderSVG

> Metoden `renderSVG` gør dokumentet til et svg-billede.

Parametre:

- `width` (Type `Number`): Bredden af billedet.
- `højde` (Type `Number`): Højden af billedet.
- `renderBackground` (Type `Boolean`): Hvis sandt, vil baggrunden blive gengivet.

Returnering: `String` (SVG)
