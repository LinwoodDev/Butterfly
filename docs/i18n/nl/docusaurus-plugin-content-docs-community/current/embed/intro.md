---
title: Insluiten
sidebar_label: Introductie
---

Insluiten is een eenvoudige manier om de app toe te voegen aan uw website. Voeg de volgende code toe aan je website:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Instellingen

| Optie    | Type                             | Standaard | Beschrijving                                                                                                                                           |
| -------- | -------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| save     | Boolean (true, false)            | true      | Schakel opslaan in. Indien uitgeschakeld wordt alleen een afsluitknop weergegeven                                                                      |
| editable | Boolean (true, false)            | true      | Bewerken inschakelen. Indien uitgeschakeld zal het document alleen-lezen zijn                                                                          |
| language | String (..., systeem, gebruiker) | system    | Taal van het document. Indien systeem wordt de taal van de browser gedetecteerd. Als gebruiker wordt de taal ingesteld op de voorkeur van de gebruiker |

## Evenementen

Voorbeelden hoe je het gebruikt:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'opslaan') {
    console.log('Saving...', data.detail.message);
  }
});
```

### save

> De `save` event wordt uitgestoten wanneer de gebruiker op de save knop klikt.

Parameters:

* `gegevens` (Type `Lijst<int>`): De gegevens van het document.

### exit

> Het `afsluiten` event wordt uitgestoten wanneer de gebruiker op de afsluitknop klikt.

Parameters:

* `gegevens` (Type `Lijst<int>`): De gegevens van het document.

### change

> De `wijziging` gebeurtenis wordt uitgestoten wanneer de gebruiker het document wijzigt.

Parameters:

* `gegevens` (Type `Lijst<int>`): De gegevens van het document.

## Methoden

Voorbeeld hoe je het moet gebruiken:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'getData') {
    console.log(data.detail.bericht);
  }
});
```

### getData

> De `getData` methode geeft de data van het document terug.

Geen parameters. Retourneert: `Lijst<int>`

### setData

> De `setData` methode stelt de data van het document in.

Parameters:

* `gegevens` (Type `Lijst<int>`): De gegevens van het document.

### render

> De `render` methode geeft het document een png afbeelding.

Parameters:

* `breedte` (Type `Nummer`): De breedte van de afbeelding.
* `hoogte` (Type `Nummer`): De hoogte van de afbeelding.
* `schaal` (Type `Nummer`): De schaal van de afbeelding.
* `renderBackground` (Type `Boolean`): Indien waar, dan wordt de achtergrond weergegeven.

Retourneert: `String` (Base64 gecodeerde afbeelding)

### renderSVG

> De `renderSVG` methode maakt het document tot een svg afbeelding.

Parameters:

* `breedte` (Type `Nummer`): De breedte van de afbeelding.
* `hoogte` (Type `Nummer`): De hoogte van de afbeelding.
* `renderBackground` (Type `Boolean`): Indien waar, dan wordt de achtergrond weergegeven.

Retourneert: `String` (SVG)
