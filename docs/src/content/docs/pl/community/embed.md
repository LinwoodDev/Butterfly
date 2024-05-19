---
title: Osadzony
---

Osadzanie jest prostym sposobem na włączenie aplikacji do Twojej strony internetowej.
Dodaj następujący kod do swojej strony internetowej:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opcje

| Opcja    | Typ                                                                                                      | Domyślny | Opis                                                                                                                                                                         |
| -------- | -------------------------------------------------------------------------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| zapisz   | Boolean (true, false)                                                                 | true     | Włącz zapisywanie. Jeśli wyłączone, wyświetlany będzie tylko przycisk wyjścia                                                                                |
| editable | Boolean (true, false)                                                                 | true     | Włącz edycję. Jeśli wyłączone, dokument będzie tylko do odczytu                                                                                              |
| language | Ciąg znaków (..., system, użytkownik) | system   | Język dokumentu. Jeśli system, język zostanie wykryty z przeglądarki. Jeśli użytkownik, język zostanie ustawiony na preferencje użytkowników |

## Wydarzenia

Przykłady jak go używać:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### zapisz

> The `save` event is emitted when the user clicks the save button.

Parametry:

- `data` (Type `List<int>`): The data of the document.

### wyjście

> The `exit` event is emitted when the user clicks the exit button.

Parametry:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parametry:

- `data` (Type `List<int>`): The data of the document.

## Metody

Przykład jak go użyć:

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

Brak parametrów.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parametry:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parametry:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parametry:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
