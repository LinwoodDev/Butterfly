---
title: Insluiten
---

Insluiten is een eenvoudige manier om de app toe te voegen aan uw website.
Voeg de volgende code toe aan je website:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Instellingen

| Optie      | Type                                                                                                | Standaard | Beschrijving                                                                                                                                                                           |
| ---------- | --------------------------------------------------------------------------------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| opslaan    | Boolean (waar, onwaar)                                                           | waar      | Schakel opslaan in. Indien uitgeschakeld wordt alleen een afsluitknop weergegeven                                                                                      |
| bewerkbaar | Boolean (waar, onwaar)                                                           | waar      | Bewerken inschakelen. Indien uitgeschakeld zal het document alleen-lezen zijn                                                                                          |
| taal       | String (..., systeem, gebruiker) | systeem   | Taal van het document. Indien systeem wordt de taal van de browser gedetecteerd. Als gebruiker wordt de taal ingesteld op de voorkeur van de gebruiker |

## Evenementen

Voorbeelden hoe je het gebruikt:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### opslaan

> Het 'opslaan' event wordt uitgestoten wanneer de gebruiker op de knop 'opslaan' klikt.

Parameters:

- `data` (Type `List<int>`): De gegevens van het document.

### afsluiten

> Het `exit` evenement wordt uitgestoten wanneer de gebruiker op de afsluitknop klikt.

Parameters:

- `data` (Type `List<int>`): De gegevens van het document.

### Wijzigen

> De 'veranderen' gebeurtenis wordt uitgestoten wanneer de gebruiker het document wijzigt.

Parameters:

- `data` (Type `List<int>`): De gegevens van het document.

## Methoden

Voorbeeld hoe je het moet gebruiken:

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

> De `getData` methode heeft de data van het document geretourneerd.

Geen parameters.
Retourneert: `Lijst<int>`

### stelgegevens

> De `setData` methode bepaalt de data van het document.

Parameters:

- `data` (Type `List<int>`): De gegevens van het document.

### renderen

> De `render` methode geeft het document weer naar een png afbeelding.

Parameters:

- `width` (Type `Number`): De breedte van de afbeelding.
- `height` (Type `Number`): De hoogte van de afbeelding.
- `scale` (Type `Number`): De schaal van de afbeelding.
- `renderBackground` (Type `Boolean`): Indien waar, dan wordt de achtergrond gerenderd.

Retourneert: `String` (Base64 gecodeerde afbeelding)

### renderSVG

> De `renderSVG` methode maakt het document tot een svg afbeelding.

Parameters:

- `width` (Type `Number`): De breedte van de afbeelding.
- `height` (Type `Number`): De hoogte van de afbeelding.
- `renderBackground` (Type `Boolean`): Indien waar, dan wordt de achtergrond gerenderd.

Retourneert: `String` (SVG)
