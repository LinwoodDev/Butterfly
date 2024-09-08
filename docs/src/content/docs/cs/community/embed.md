---
title: Vložit
---

Vložení je jednoduchý způsob, jak zahrnout aplikaci do vašich webových stránek.
Přidejte následující kód na vaše webové stránky:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Možnosti

| Možnost      | Typ                                                                                                | Výchozí | L 343, 22.12.2009, s. 1).                                                           |
| ------------ | -------------------------------------------------------------------------------------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| uložit       | Logická (pravda, nepravda)                                                      | pravda  | Povolit uložení. Pokud je zakázáno, zobrazí se pouze tlačítko ukončení                                                              |
| editovatelná | Logická (pravda, nepravda)                                                      | pravda  | Povolit úpravy. Je-li zakázáno, dokument bude pouze pro čtení                                                                       |
| jazyk        | Řetězec (..., systém, uživatel) | systém  | Jazyk dokumentu. Pokud je systém rozpoznán z prohlížeče. Pokud uživatel, jazyk bude nastaven na předvolby uživatelů |

## Události

Příklady jak je použít:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### uložit

> Uložit" událost je aktivována, když uživatel klikne na tlačítko Uložit.

Parametry:

- `data` (Typ `List<int>`): Data dokumentu.

### ukončit

> Událost "ukončit" je zapnuta, když uživatel klikne na tlačítko "Ukončí".

Parametry:

- `data` (Typ `List<int>`): Data dokumentu.

### změna

> Událost `change` se vypouští, když uživatel změní dokument.

Parametry:

- `data` (Typ `List<int>`): Data dokumentu.

## Metody

Příklad jak jej použít:

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

> Metoda `getData` vrací data dokumentu.

Žádné parametry.
Vrácené hodnoty: `List<int>`

### setData

> Metoda `setData` nastavuje data dokumentu.

Parametry:

- `data` (Typ `List<int>`): Data dokumentu.

### vykreslit

> Metoda `render` vykresluje dokument na png obrázek.

Parametry:

- `width` (Typ `Number`): Šířka obrázku.
- `height` (Typ `Number`): Výška obrázku.
- `měřítko` (typ `číslo`): měřítko obrázku.
- `renderBackground` (Type `Boolean`): Pokud je pravda, pozadí bude vykresleno.

Vrácení: `String` (Base64 enkódovaný obrázek)

### renderSVG

> Metoda `renderSVG` vykresluje dokument na svg obrázek.

Parametry:

- `width` (Typ `Number`): Šířka obrázku.
- `height` (Typ `Number`): Výška obrázku.
- `renderBackground` (Type `Boolean`): Pokud je pravda, pozadí bude vykresleno.

Vrácené hodnoty: `String` (SVG)
