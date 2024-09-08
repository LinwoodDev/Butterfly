---
title: Încorporează
---

Integrarea este o modalitate simplă de a include aplicația în site-ul dvs.
Adaugă următorul cod la site-ul tău:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opţiuni

| Opţiune  | Tip                                                                                              | Implicit | Descriere                                                                                                                                        |
| -------- | ------------------------------------------------------------------------------------------------ | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| salvează | Boolean (adevărat, fals)                                                      | adevărat | Activează salvarea. Dacă este dezactivat, numai un buton de ieșire va fi afișat                                                  |
| editabil | Boolean (adevărat, fals)                                                      | adevărat | Activează editarea. Dacă este dezactivat, documentul va fi numai în citire                                                       |
| limba    | Șir (..., sistem, utilizator) | sistem   | Limba documentului Dacă sistemul va fi detectat limba din browser. Dacă utilizator, limba va seta la preferințele utilizatorilor |

## Evenimente

Exemple de utilizare a acestuia:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### salvează

> Evenimentul `salvează` este emis atunci când utilizatorul apasă butonul de salvare.

Parametrii:

- `data` (Type `List<int>`): Datele documentului.

### ieșire

> Evenimentul "ieşire" este emis atunci când utilizatorul face clic pe butonul de ieşire.

Parametrii:

- `data` (Type `List<int>`): Datele documentului.

### schimbă

> Evenimentul `change` este emis atunci când utilizatorul schimbă documentul.

Parametrii:

- `data` (Type `List<int>`): Datele documentului.

## Metode

Exemplu de utilizare a acestuia:

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

> Metoda `getData` returnează datele documentului.

Niciun parametru.
Returnări: `List<int>`

### setare date

> Metoda `setData` stabileşte datele documentului.

Parametrii:

- `data` (Type `List<int>`): Datele documentului.

### randare

> Metoda `render` face documentul la o imagine png.

Parametrii:

- `width` (Type `Number`): Lăţimea imaginii.
- `height` (Type `Number`): Înălțimea imaginii.
- `scale` (Type `Number`): Scara imaginii.
- `renderBackground` (Tip `Boolean`): Dacă este adevărat, fundalul va fi randat.

Returnări: `String` (imagine codificată Base64 )

### renderSVG

> Metoda `renderSVG` face documentul la o imagine svg.

Parametrii:

- `width` (Type `Number`): Lăţimea imaginii.
- `height` (Type `Number`): Înălțimea imaginii.
- `renderBackground` (Tip `Boolean`): Dacă este adevărat, fundalul va fi randat.

Returnări: `String` (SVG)
