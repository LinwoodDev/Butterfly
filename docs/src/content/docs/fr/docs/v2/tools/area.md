---
title: Zone
---

Les outils de zone permettent de créer, d'éditer et de supprimer des zones.

For an overview of how areas work, see [Areas](../../areas).

## Actions

|         Souris         |          Toucher          |          Action         |
| :--------------------: | :-----------------------: | :---------------------: |
| Clic gauche et glissez | Tapotez et faites glisser | Créer une nouvelle zone |
|      Clic central      |        Deux doigts        |    Déplacer la toile    |
|       Clic droit       |         Appui long        |     Modifier la zone    |

## Configuration

|       Propriété | Par défaut | Libellé                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------: | :--------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Demander le nom |  Désactivé | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                                                                                                |
|     Préréglages |    none    | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                                                                                             |
|         Largeur |     '0'    | La largeur fixe d'une nouvelle zone. Si définie à '0', cette option sera ignorée.                                                                                                                                                                                                                                                                                                                                                                 |
|         Hauteur |     '0'    | La hauteur fixe d'une nouvelle zone. Si définie à '0', cette option sera ignorée.                                                                                                                                                                                                                                                                                                                                                                 |
|  Ratio d'aspect |     '0'    | Le ratio fixe pour la nouvelle zone. Select a preset from the segmented control or enter a custom value in the input field. Un ratio d'aspect est défini comme la largeur divisée par la hauteur. Donc les valeurs de ratio inférieures à '1' seront plus hautes que larges, et les valeurs de ratio supérieures à '1' seront plus large que hautes. Si définie à '0', cette option sera ignorée. |

Il y a trois préréglages de ratio :

- Carré (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
