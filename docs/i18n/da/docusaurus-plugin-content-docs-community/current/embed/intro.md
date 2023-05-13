---
title: Indlejr
sidebar_label: Introduktion
---

Indlejring er en enkel måde at inkludere appen på din hjemmeside. Tilføj følgende kode til dit websted:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Indstillinger

| Valgmulighed | Type                         | Standard | Varebeskrivelse                                                                                                                            |
| ------------ | ---------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| save         | Boolean (true, false)        | true     | Aktiver gemning. Hvis deaktiveret, vil kun en afslutningsknap blive vist                                                                   |
| editable     | Boolean (true, false)        | true     | Aktiver redigering. Hvis deaktiveret, vil dokumentet være skrivebeskyttet                                                                  |
| language     | Streng (..., system, bruger) | system   | Sprog for dokumentet. Hvis systemet, sproget vil blive opdaget fra browseren. Hvis bruger, vil sproget blive sat til brugernes præferencer |

## Begivenheder

Eksempler på hvordan man bruger det:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type =='save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### save

> Den `gem` begivenhed udsendes, når brugeren klikker på Gem-knappen.

Parametre:

* `data` (Type `Liste<int>`): Data for dokumentet.

### exit

> Begivenheden `exit` udsendes, når brugeren klikker på exit knappen.

Parametre:

* `data` (Type `Liste<int>`): Data for dokumentet.

### change

> Begivenheden `ændring` udsendes, når brugeren ændrer dokumentet.

Parametre:

* `data` (Type `Liste<int>`): Data for dokumentet.

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

> Metoden `getData` returnerer data fra dokumentet.

Ingen parametre. Returnering: `Liste<int>`

### setData

> Metoden `setData` angiver dokumentets data.

Parametre:

* `data` (Type `Liste<int>`): Data for dokumentet.

### render

> Metoden `render` gør dokumentet til et png billede.

Parametre:

* `bredde` (Type `Nummer`): Bredden af billedet.
* `højde` (Type `Nummer`): Højden af billedet.
* `skala` (Type `Nummer`): Skalaen af billedet.
* `renderBackground` (type `Boolesk`): Hvis sandt, vil baggrunden blive gengivet.

Returnering: `Streng` (Base64 kodet billede)

### renderSVG

> Metoden `renderSVG` gør dokumentet til et svg-billede.

Parametre:

* `bredde` (Type `Nummer`): Bredden af billedet.
* `højde` (Type `Nummer`): Højden af billedet.
* `renderBackground` (type `Boolesk`): Hvis sandt, vil baggrunden blive gengivet.

Returnering: `Streng` (SVG)
