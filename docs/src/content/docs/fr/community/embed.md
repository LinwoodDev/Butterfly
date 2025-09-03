---
title: Intégrer
---

Intégrer est un moyen simple d'inclure l'application dans votre site Web.
Ajoute le code suivant à ton site web :

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Options

| Option      | Type de texte                                                                                                       | Par défaut | Libellé                                                                                                                                                                                      |
| ----------- | ------------------------------------------------------------------------------------------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| enregistrer | Booléen (true, false)                                                                            | true       | Activer la sauvegarde. Si désactivé, seul un bouton de sortie sera affiché                                                                                                   |
| editable    | Booléen (true, false)                                                                            | true       | Activer l'édition. Si désactivé, le document sera en lecture seule                                                                                                           |
| langue      | Chaîne de caractères (..., système, utilisateur) | system     | Langue du document. Si le système, la langue sera détectée à partir du navigateur. Si l'utilisateur, la langue sera définie à la préférence des utilisateurs |

## Évènements

Exemples d'utilisation :

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### enregistrer

> The `save` event is emitted when the user clicks the save button.

Paramètres:

- `data` (Type `List<int>`): The data of the document.

### quitter

> The `exit` event is emitted when the user clicks the exit button.

Paramètres:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Paramètres:

- `data` (Type `List<int>`): The data of the document.

## Méthodes

Exemple d'utilisation :

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

Aucun paramètre.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Paramètres:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Paramètres:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Paramètres:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
