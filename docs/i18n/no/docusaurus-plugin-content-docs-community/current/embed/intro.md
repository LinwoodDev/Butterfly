---
title: Integrer
sidebar_label: Introduksjon
---

Embedding er en enkel måte å inkludere appen på nettstedet ditt. Legg til følgende kode til nettstedet ditt:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Alternativer

| Alternativ | Type:                        | Standard | Beskrivelse                                                                                                                                        |
| ---------- | ---------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| save       | Boolean (true, false)        | true     | Aktiver lagring. Hvis deaktivert, vil bare en avslutning-knappen bli vist                                                                          |
| editable   | Boolean (true, false)        | true     | Aktiver redigering. Hvis deaktivert vil dokumentet være skrivebeskyttet                                                                            |
| language   | Streng (..., system, bruker) | system   | Språket til dokumentet. Dersom systemet er lagt, vil språket bli oppdaget fra nettleseren. Hvis bruker vil språket settes til brukerens preferanse |

## Hendelser

Eksempler på bruk av den:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('melding', (data) => {
  (data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }

```

### save

> `Lagre` -hendelsen slås ut når brukeren klikker på lagreknappen.

Parametre:

* `data` (type `streng`): Dataen til dokumentet.

### exit

> `avslutt` hendelsen slås ut når brukeren klikker på avslutningsknappen.

Parametre:

* `data` (type `streng`): Dataen til dokumentet.

### change

> `Endre` hendelse sendes ut når brukeren endrer dokumentet.

Parametre:

* `data` (type `streng`): Dataen til dokumentet.

## Metoder

Eksempel på hvordan man bruker den:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'getData') {
    console.log(data.detail.message);

});
```

### getData

> `getData` -metoden returnerer dataene i dokumentet.

Ingen parametere. Returnere: `Tekst`

### setData

> Metoden `settData` angir data i dokumentet.

Parametre:

* `data` (type `streng`): Dataen til dokumentet.

### render

> `render` method renders the document to a png image.

Parametre:

* `bredde` (skriv `nummer`): Bredden på bildet.
* `høyde` (Skriv `nummer`): høyden på bildet.
* `scale` (Type `Number`): Skalaen på bildet.
* `bakgrunn` (skriv `boolsk`): Hvis sann, vil bakgrunnen bli gjengitt.

Returer: `Streng` (Base64 kodet bilde)

### renderSVG

> `renderSVG` -metoden gjengir dokumentet til et svg-bilde.

Parametre:

* `bredde` (skriv `nummer`): Bredden på bildet.
* `høyde` (Skriv `nummer`): høyden på bildet.
* `bakgrunn` (skriv `boolsk`): Hvis sann, vil bakgrunnen bli gjengitt.

Returnere: `Streng` (SVG)
