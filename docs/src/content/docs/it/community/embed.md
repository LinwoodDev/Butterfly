---
title: Incorpora in pagina web
---

L'incorporazione è un modo semplice per includere l'applicazione nel tuo sito web.
Aggiungi il seguente codice al tuo sito web:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opzioni

| Opzione  | Tipo                                                                                              | Predefinito | Descrizione                                                                                                                                                           |
| -------- | ------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)                                                          | true        | Abilita il salvataggio. Se disabilitato, verrà mostrato solo un pulsante di uscita                                                                    |
| editable | Boolean (true, false)                                                          | true        | Abilita le modifiche. Se disabilitato, il documento sarà in sola lettura                                                                              |
| language | Stringa (..., sistema, utente) | system      | Lingua del documento. Se il sistema, la lingua verrà rilevata dal browser. Se l'utente, la lingua imposterà la preferenza dell'utente |

## Eventi

Esempi su come usarlo:

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

Parametri:

- `data` (Type `List<int>`): The data of the document.

### exit

> The `exit` event is emitted when the user clicks the exit button.

Parametri:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parametri:

- `data` (Type `List<int>`): The data of the document.

## Metodi

Esempi su come usarlo:

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

Nessun parametro.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parametri:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parametri:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parametri:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
