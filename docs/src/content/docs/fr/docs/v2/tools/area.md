---
title: Zone
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Actions

|         Souris         |          Toucher          |          Action         |
| :--------------------: | :-----------------------: | :---------------------: |
| Clic gauche et glissez | Tapotez et faites glisser | Créer une nouvelle zone |
|      Clic central      |        Deux doigts        |    Déplacer la toile    |
|       Clic droit       |         Appui long        |     Modifier la zone    |

## Configuration

|      Propriété | Par défaut | Libellé                                                                                                                                                                                                                                                                                                                                                                                                                           |
| -------------: | :--------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|        Largeur |     `0`    | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                                       |
|        Hauteur |     `0`    | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                                      |
| Ratio d'aspect |     `0`    | The fixed aspect ratio for new areas. Appuyer sur le bouton <DotsThreeVertical className="inline-icon"/> pour accéder aux paramètres communs. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Il y a trois préréglages de ratio :

- Carré (1:1)
- Page portrait (sqrt(2)) - Ceci est le ratio d'aspect par défaut d'une page A4 en mode portrait.
- Page landscape (1/sqrt(2)) - C'est le ratio d'aspect par défaut d'une page A4 en mode paysage.
