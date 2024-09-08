---
title: Integrer
---

Embedding er en enkel måte å inkludere appen på nettstedet ditt.
Legg til følgende kode til nettstedet ditt:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Alternativer

| Alternativ | Type:                                                                           | Standard | Beskrivelse                                                                                                                                                                        |
| ---------- | ----------------------------------------------------------------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| lagre      | Boolsk (sann, usann)                                                         | sann     | Aktiver lagring. Hvis deaktivert, vil bare en avslutning-knappen bli vist                                                                                          |
| redigerbar | Boolsk (sann, usann)                                                         | sann     | Aktiver redigering. Hvis deaktivert vil dokumentet være skrivebeskyttet                                                                                            |
| språk      | Streng (..., system, bruker) | system   | Språket til dokumentet. Dersom systemet er lagt, vil språket bli oppdaget fra nettleseren. Hvis bruker vil språket settes til brukerens preferanse |

## Hendelser

Eksempler på bruk av den:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### lagre

> "Lagre"-hendelsen kommer ut når brukeren klikker på lagreknappen.

Parametre:

- `data` (skriv `List<int>`): Dataen til dokumentet.

### avslutt

> Hendelsen `exit` blir sluppet ut når brukeren klikker på Avkjør-knappen.

Parametre:

- `data` (skriv `List<int>`): Dataen til dokumentet.

### endre

> Hendelsen `change` sendes ut når brukeren endrer dokumentet.

Parametre:

- `data` (skriv `List<int>`): Dataen til dokumentet.

## Metoder

Eksempel på hvordan man bruker den:

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

> `getData`-metoden returnerer dataene til dokumentet.

Ingen parametere.
Returner: `Liste<int>`

### settData

> `setData`-metoden angir dataene for dokumentet.

Parametre:

- `data` (skriv `List<int>`): Dataen til dokumentet.

### generer

> `render`-metoden gjengir dokumentet til et png bilde.

Parametre:

- `width` (Skriv `Number`): Bredde på bildet.
- `height` (Skriv `Number`): høyden på bildet.
- `skala` (Skriv inn `Number`): Skalaen på bildet.
- `renderBackground` (skriv `Boolean`): Hvis true, vil bakgrunnen bli gjengitt.

Returer: `String` (Base64 kodet bilde)

### rendersvegg

> "renderSVG"-metoden gjengir dokumentet til et svg-bilde.

Parametre:

- `width` (Skriv `Number`): Bredde på bildet.
- `height` (Skriv `Number`): høyden på bildet.
- `renderBackground` (skriv `Boolean`): Hvis true, vil bakgrunnen bli gjengitt.

Returer: `String` (SVG)
