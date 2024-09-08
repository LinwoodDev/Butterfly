---
title: Osadzony
---

Osadzanie jest prostym sposobem na włączenie aplikacji do Twojej strony internetowej.
Dodaj następujący kod do swojej strony internetowej:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opcje

| Opcja      | Typ                                                                                                      | Domyślny | Opis                                                                                                                                                                         |
| ---------- | -------------------------------------------------------------------------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| zapisz     | Wartość logiczna (prawda, fałsz)                                                      | prawda   | Włącz zapisywanie. Jeśli wyłączone, wyświetlany będzie tylko przycisk wyjścia                                                                                |
| edytowalne | Wartość logiczna (prawda, fałsz)                                                      | prawda   | Włącz edycję. Jeśli wyłączone, dokument będzie tylko do odczytu                                                                                              |
| język      | Ciąg znaków (..., system, użytkownik) | system   | Język dokumentu. Jeśli system, język zostanie wykryty z przeglądarki. Jeśli użytkownik, język zostanie ustawiony na preferencje użytkowników |

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

> Zdarzenie `save` jest emitowane po kliknięciu przez użytkownika przycisku zapisu.

Parametry:

- `data` (Wpisz `List<int>`): Dane dokumentu.

### wyjście

> Zdarzenie `exit` jest emitowane po kliknięciu przez użytkownika przycisku wyjścia.

Parametry:

- `data` (Wpisz `List<int>`): Dane dokumentu.

### zmień

> Zdarzenie `change` jest emitowane, gdy użytkownik zmienia dokument.

Parametry:

- `data` (Wpisz `List<int>`): Dane dokumentu.

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

> Metoda `getData` zwraca dane dokumentu.

Brak parametrów.
Zwroty: `Lista<int>`

### setData

> Metoda `setData` ustawia dane dokumentu.

Parametry:

- `data` (Wpisz `List<int>`): Dane dokumentu.

### renderowanie

> Metoda `render` render\` renderuje dokument na obrazek png.

Parametry:

- `width` (Wpisz `Number`): Szerokość obrazu.
- `height` (Wpisz `Number`): wysokość obrazu.
- `scale` (Wpisz `Number`): Skala obrazu.
- `renderBackground` (Wpisz `Boolean`): Jeśli prawda, tło będzie renderowane.

Zwraca: `String` (obraz zakodowany w systemie Base64)

### renderSVG

> Metoda `renderSVG` renderuje dokument na obrazek svg.

Parametry:

- `width` (Wpisz `Number`): Szerokość obrazu.
- `height` (Wpisz `Number`): wysokość obrazu.
- `renderBackground` (Wpisz `Boolean`): Jeśli prawda, tło będzie renderowane.

Zwraca: `String` (SVG)
