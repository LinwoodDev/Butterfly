---
title: Intégrer
sidebar_label: Introduction
---

Intégrer est un moyen simple d'inclure l'application dans votre site Web. Ajoute le code suivant à ton site web :

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Options

| Option     | Type de texte         | Par défaut | Libellé                                                                    |
| ---------- | --------------------- | ---------- | -------------------------------------------------------------------------- |
| économiser | Boolean (true, false) | vrai       | Activer la sauvegarde. Si désactivé, seul un bouton de sortie sera affiché |
| modifiable | Boolean (true, false) | vrai       | Activer l'édition. Si désactivé, le document sera en lecture seule         |

## Évènements

Exemples d'utilisation :

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('save', (data) => {
  console.log('Sauvegarde...');
});
```

### économiser

> L'événement `save` est émis lorsque l'utilisateur clique sur le bouton Enregistrer.

Paramètres:

* `données` (Type `String`) : Les données du document.

### Sortir

> L'événement `exit` est émis lorsque l'utilisateur clique sur le bouton de fermeture.

Paramètres:

* `données` (Type `String`) : Les données du document.

### changer

> L'événement `change` est émis lorsque l'utilisateur change le document.

Paramètres:

* `données` (Type `String`) : Les données du document.

## Méthodes

Exemple d'utilisation :

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.dispatchEvent(new CustomEvent('getData', {}));
embedElement.addEventListener('message', (data) => {
  if(data.type === 'getData') {
    console.log(data.message);
  }
});
```

### getData

> La méthode `getData` retourne les données du document.

Aucun paramètre. Renvoie : `Chaîne`

### définir les données

> La méthode `setData` définit les données du document.

Paramètres:

* `données` (Type `String`) : Les données du document.

### rendu

> La méthode `rendu` rend le document à une image png.

Paramètres:

* `width` (Type `Number`): La largeur de l'image.
* `height` (Type `Number`): La hauteur de l'image.
* `échelle` (Type `Number`) : L'échelle de l'image.
* `renderBackground` (Type `Boolean`): Si vrai, l'arrière-plan sera affiché.

Renvoie : `String` (image encodée en Base64)

### Raccourci SVG

> La méthode `renderSVG` rend le document à une image svg.

Paramètres:

* `width` (Type `Number`): La largeur de l'image.
* `height` (Type `Number`): La hauteur de l'image.
* `renderBackground` (Type `Boolean`): Si vrai, l'arrière-plan sera affiché.

Renvoie : `String` (SVG)
