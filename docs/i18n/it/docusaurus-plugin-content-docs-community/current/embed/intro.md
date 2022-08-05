---
title: Incorpora in pagina web
sidebar_label: Introduzione
---

L'incorporazione è un modo semplice per includere l'applicazione nel tuo sito web. Aggiungi il seguente codice al tuo sito web:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opzioni

| Opzione  | Tipo                           | Predefinito | Descrizione                                                                                                                           |
| -------- | ------------------------------ | ----------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)          | true        | Abilita il salvataggio. Se disabilitato, verrà mostrato solo un pulsante di uscita                                                    |
| editable | Boolean (true, false)          | true        | Abilita le modifiche. Se disabilitato, il documento sarà in sola lettura                                                              |
| lingua   | Stringa (..., sistema, utente) | sistema     | Lingua del documento. Se il sistema, la lingua verrà rilevata dal browser. Se l'utente, la lingua imposterà la preferenza dell'utente |

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

> L'evento `save` si verifica quando l'utente fa clic sul pulsante Salva.

Parametri:

* `data` (Type `String`): I dati del documento.

### exit

> L'evento `exit` si verifica quando l'utente fa clic sul pulsante di uscita.

Parametri:

* `data` (Type `String`): I dati del documento.

### change

> L'evento `change` si verifica quando l'utente cambia il documento.

Parametri:

* `data` (Type `String`): I dati del documento.

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

> Il metodo `getData` restituisce i dati del documento.

Nessun parametro. Restituisce: `String`

### setData

> Il metodo `setData` imposta i dati del documento.

Parametri:

* `data` (Type `String`): I dati del documento.

### render

> Il metodo `render` renderizza il documento in un'immagine png.

Parametri:

* `width` (Type `Number`): La larghezza dell'immagine.
* `height` (Type `Number`): L'altezza dell'immagine.
* `scale` (Type `Number`): La scala dell'immagine.
* `renderBackground` (Type `Boolean`): Se vero, lo sfondo sarà renderizzato.

Restituisce: `String` (Immagine codificata Base64)

### renderSVG

> Il metodo `renderSVG` renderizza il documento in un'immagine svg.

Parametri:

* `width` (Type `Number`): La larghezza dell'immagine.
* `height` (Type `Number`): L'altezza dell'immagine.
* `renderBackground` (Type `Boolean`): Se vero, lo sfondo sarà renderizzato.

Restituisce: `String` (SVG)
