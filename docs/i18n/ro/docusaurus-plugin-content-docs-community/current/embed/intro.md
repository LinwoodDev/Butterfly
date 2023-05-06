---
title: Încorporează
sidebar_label: Introducere
---

Integrarea este o modalitate simplă de a include aplicația în site-ul dvs. Adaugă următorul cod la site-ul tău:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opţiuni

| Opţiune  | Tip                           | Implicit | Descriere                                                                                                                        |
| -------- | ----------------------------- | -------- | -------------------------------------------------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)         | true     | Activează salvarea. Dacă este dezactivat, numai un buton de ieșire va fi afișat                                                  |
| editable | Boolean (true, false)         | true     | Activează editarea. Dacă este dezactivat, documentul va fi numai în citire                                                       |
| language | Șir (..., sistem, utilizator) | system   | Limba documentului Dacă sistemul va fi detectat limba din browser. Dacă utilizator, limba va seta la preferințele utilizatorilor |

## Evenimente

Exemple de utilizare a acestuia:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type == 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### save

> Evenimentul `salvează` este emis atunci când utilizatorul apasă butonul de salvare.

Parametrii:

* `data` (Type `List<int>`): The data of the document.

### exit

> Evenimentul `Ieșire` este emis atunci când utilizatorul face clic pe butonul de ieșire.

Parametrii:

* `data` (Type `List<int>`): The data of the document.

### change

> Evenimentul `schimbă` este emis atunci când utilizatorul schimbă documentul.

Parametrii:

* `data` (Type `List<int>`): The data of the document.

## Metode

Exemplu de utilizare a acestuia:

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

> Metoda `getData` returnează datele documentului.

Niciun parametru. Returns: `List<int>`

### setData

> Metoda `setează Data` stabilește datele documentului.

Parametrii:

* `data` (Type `List<int>`): The data of the document.

### render

> Metoda de randare `` redă documentul unei imagini png.

Parametrii:

* `Lățimea` (Tip `Număr`): Lățimea imaginii.
* `Înălțime` (Tip `Număr`): Înălțimea imaginii.
* `scala` (Tip `Număr`): Scara imaginii.
* `renderBackground` (Tip `Boolean`): Dacă este adevărat, fundalul va fi randat.

Returnări: `String` (Imagine codată Base64 )

### renderSVG

> Metoda `renderSVG` face documentul la o imagine svg.

Parametrii:

* `Lățimea` (Tip `Număr`): Lățimea imaginii.
* `Înălțime` (Tip `Număr`): Înălțimea imaginii.
* `renderBackground` (Tip `Boolean`): Dacă este adevărat, fundalul va fi randat.

Returnări: `String` (SVG)
