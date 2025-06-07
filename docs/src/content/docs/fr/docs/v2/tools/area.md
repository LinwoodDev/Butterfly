---
title: Zone
---

Les outils de zone permettent de créer, d'éditer et de supprimer des zones.

Pour un aperçu dont les zones fonctionnent, voir [Zones](../areas).

## Actions

|         Souris         |          Toucher          |          Action         |
| :--------------------: | :-----------------------: | :---------------------: |
| Clic gauche et glissez | Tapotez et faites glisser | Créer une nouvelle zone |
|      Clic central      |        Deux doigts        |    Déplacer la toile    |
|       Clic droit       |         Appui long        |     Modifier la zone    |

## Configuration

|      Propriété | Par défaut | Libellé                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| -------------: | :--------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|        Largeur |     '0'    | La largeur fixe d'une nouvelle zone. Si définie à '0', cette option sera ignorée.                                                                                                                                                                                                                                                                                                                                                                                  |
|        Hauteur |     '0'    | La hauteur fixe d'une nouvelle zone. Si définie à '0', cette option sera ignorée.                                                                                                                                                                                                                                                                                                                                                                                  |
| Ratio d'aspect |     '0'    | Le ratio fixe pour la nouvelle zone. Appuyer sur le bouton <DotsThreeVertical className="inline-icon"/> pour accéder aux paramètres communs. Un ratio d'aspect est défini comme la largeur divisée par la hauteur. Donc les valeurs de ratio inférieures à '1' seront plus hautes que larges, et les valeurs de ratio supérieures à '1' seront plus large que hautes. Si définie à '0', cette option sera ignorée. |

Il y a trois préréglages de ratio :

- Carré (1:1)
- Page portrait (sqrt(2)) - Ceci est le ratio d'aspect par défaut d'une page A4 en mode portrait.
- Page landscape (1/sqrt(2)) - C'est le ratio d'aspect par défaut d'une page A4 en mode paysage.
