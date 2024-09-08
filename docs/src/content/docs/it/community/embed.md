---
title: Incorpora in pagina web
---

L'incorporazione è un modo semplice per includere l'applicazione nel tuo sito web.
Aggiungi il seguente codice al tuo sito web:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opzioni

| Opzione      | Tipo                                                                                              | Predefinito | Descrizione                                                                                                                                                           |
| ------------ | ------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| salva        | Booleano (vero, falso)                                                         | vero        | Abilita il salvataggio. Se disabilitato, verrà mostrato solo un pulsante di uscita                                                                    |
| modificabile | Booleano (vero, falso)                                                         | vero        | Abilita le modifiche. Se disabilitato, il documento sarà in sola lettura                                                                              |
| lingua       | Stringa (..., sistema, utente) | sistema     | Lingua del documento. Se il sistema, la lingua verrà rilevata dal browser. Se l'utente, la lingua imposterà la preferenza dell'utente |

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

### salva

> L'evento `save` viene emesso quando l'utente fa clic sul pulsante di salvataggio.

Parametri:

- `data` (Type `List<int>`): I dati del documento.

### esci

> L'evento `exit` viene emesso quando l'utente fa clic sul pulsante di uscita.

Parametri:

- `data` (Type `List<int>`): I dati del documento.

### modifica

> L'evento `change` viene emesso quando l'utente cambia il documento.

Parametri:

- `data` (Type `List<int>`): I dati del documento.

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

Nessun parametro.
Restituisce: `List<int>`

### setData

> Il metodo `setData` imposta i dati del documento.

Parametri:

- `data` (Type `List<int>`): I dati del documento.

### renderizza

> Il metodo `render` rende il documento in un'immagine png.

Parametri:

- `width` (tipo `Number`): La larghezza dell'immagine.
- `height` (tipo `Number`): L'altezza dell'immagine.
- `scale` (Type `Number`): La scala dell'immagine.
- `renderBackground` (Type `Boolean`): Se VERO, lo sfondo sarà renderizzato.

Restituisce: `String` (Immagine codificata Base64)

### renderSVG

> Il metodo `renderSVG` rende il documento a un'immagine svg.

Parametri:

- `width` (tipo `Number`): La larghezza dell'immagine.
- `height` (tipo `Number`): L'altezza dell'immagine.
- `renderBackground` (Type `Boolean`): Se VERO, lo sfondo sarà renderizzato.

Restituisce: `String` (SVG)
