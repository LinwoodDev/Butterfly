---
title: Intégrer
sidebar_label: Introduction
---

Intégrer est un moyen simple d'inclure l'application dans votre site Web. Ajoute le code suivant à ton site web :

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Options

| Option   | Type de texte                                    | Par défaut | Libellé                                                                                                                                                      |
| -------- | ------------------------------------------------ | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| save     | Boolean (true, false)                            | true       | Activer la sauvegarde. Si désactivé, seul un bouton de sortie sera affiché                                                                                   |
| editable | Boolean (true, false)                            | true       | Activer l'édition. Si désactivé, le document sera en lecture seule                                                                                           |
| language | Chaîne de caractères (..., système, utilisateur) | système    | Langue du document. Si le système, la langue sera détectée à partir du navigateur. Si l'utilisateur, la langue sera définie à la préférence des utilisateurs |

## Évènements

Exemples d'utilisation :

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Sauvegarde...', data.detail.message);
  }
});
```

### save

> L'événement `save` est émis lorsque l'utilisateur clique sur le bouton Enregistrer.

Paramètres:

* `données` (Type `String`) : Les données du document.

### exit

> L'événement `exit` est émis lorsque l'utilisateur clique sur le bouton de fermeture.

Paramètres:

* `données` (Type `String`) : Les données du document.

### change

> L'événement `change` est émis lorsque l'utilisateur change le document.

Paramètres:

* `données` (Type `String`) : Les données du document.

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

> La méthode `getData` retourne les données du document.

Aucun paramètre. Renvoie : `Chaîne`

### setData

> La méthode `setData` définit les données du document.

Paramètres:

* `données` (Type `String`) : Les données du document.

### render

> La méthode `render` rend le document à une image png.

Paramètres:

* `width` (Type `Number`): La largeur de l'image.
* `height` (Type `Number`): La hauteur de l'image.
* `échelle` (Type `Number`) : L'échelle de l'image.
* `renderBackground` (Type `Boolean`): Si vrai, l'arrière-plan sera affiché.

Renvoie : `String` (image encodée en Base64)

### renderSVG

> La méthode `renderSVG` rend le document à une image svg.

Paramètres:

* `width` (Type `Number`): La largeur de l'image.
* `height` (Type `Number`): La hauteur de l'image.
* `renderBackground` (Type `Boolean`): Si vrai, l'arrière-plan sera affiché.

Renvoie : `String` (SVG)
