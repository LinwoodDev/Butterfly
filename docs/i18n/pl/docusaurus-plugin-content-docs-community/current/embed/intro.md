---
title: Osadzony
sidebar_label: Wprowadzenie
---

Osadzanie jest prostym sposobem na włączenie aplikacji do Twojej strony internetowej. Dodaj następujący kod do swojej strony internetowej:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opcje

| Opcja    | Typ                                   | Domyślny | Opis                                                                                                                                         |
| -------- | ------------------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)                 | true     | Włącz zapisywanie. Jeśli wyłączone, wyświetlany będzie tylko przycisk wyjścia                                                                |
| editable | Boolean (true, false)                 | true     | Włącz edycję. Jeśli wyłączone, dokument będzie tylko do odczytu                                                                              |
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

### save

> Wydarzenie `save` jest emitowane po kliknięciu przycisku zapisu.

Parametry:

* `data` (Type `List<int>`): The data of the document.

### exit

> Wydarzenie `Wyjdź` jest emitowane po kliknięciu przez użytkownika przycisku wyjście.

Parametry:

* `data` (Type `List<int>`): The data of the document.

### change

> Wydarzenie `change` jest emitowane po zmianie dokumentu przez użytkownika.

Parametry:

* `data` (Type `List<int>`): The data of the document.

## Metody

Przykład jak go użyć:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type == 'getData') {
    console.log(data.detail.message);
  }
});
```

### getData

> Metoda `getData` zwraca dane dokumentu.

Brak parametrów. Returns: `List<int>`

### setData

> Metoda `setData` ustawia dane dokumentu.

Parametry:

* `data` (Type `List<int>`): The data of the document.

### render

> Metoda renderowania `` renderuje dokument na obrazek png.

Parametry:

* `width` (Type `Number`): Szerokość obrazu.
* `height` (Type `Number`): Wysokość obrazu.
* `skala` (Wpisz `Number`): skala obrazu.
* `renderBackground` (Wpisz `Boolean`): Jeśli prawda, tło zostanie wyrenderowane.

Zwraca: `String` (obraz zakodowany w systemie Base64)

### renderSVG

> Metoda `renderSVG` renderuje dokument na obrazek svg.

Parametry:

* `width` (Type `Number`): Szerokość obrazu.
* `height` (Type `Number`): Wysokość obrazu.
* `renderBackground` (Wpisz `Boolean`): Jeśli prawda, tło zostanie wyrenderowane.

Zwroty: `String` (SVG)
