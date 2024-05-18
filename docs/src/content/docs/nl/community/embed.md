---
title: Insluiten
---

Insluiten is een eenvoudige manier om de app toe te voegen aan uw website.
Voeg de volgende code toe aan je website:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Instellingen

| Optie    | Type                                                                                                | Standaard | Beschrijving                                                                                                                                                                           |
| -------- | --------------------------------------------------------------------------------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)                                                            | true      | Schakel opslaan in. Indien uitgeschakeld wordt alleen een afsluitknop weergegeven                                                                                      |
| editable | Boolean (true, false)                                                            | true      | Bewerken inschakelen. Indien uitgeschakeld zal het document alleen-lezen zijn                                                                                          |
| language | String (..., systeem, gebruiker) | system    | Taal van het document. Indien systeem wordt de taal van de browser gedetecteerd. Als gebruiker wordt de taal ingesteld op de voorkeur van de gebruiker |

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

### save

> The `save` event is emitted when the user clicks the save button.

Parameters:

- `data` (Type `List<int>`): The data of the document.

### exit

> The `exit` event is emitted when the user clicks the exit button.

Parameters:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parameters:

- `data` (Type `List<int>`): The data of the document.

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

> The `getData` method returns the data of the document.

Geen parameters.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parameters:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parameters:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parameters:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
