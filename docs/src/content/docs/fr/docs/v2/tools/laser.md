---
title: Outil pointeur laser
---

Avec cet outil vous pouvez dessiner sur le document temporairement. Après un certain temps, le dessin s'estompe.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

|        Propriété | Par défaut | Libellé                                                                                                               |
| ---------------: | :--------: | :-------------------------------------------------------------------------------------------------------------------- |
|          Couleur |    Rouge   | The color that will be drawn.                                                                         |
| Largeur du trait |      5     | The width of the stroke.                                                                              |
|    Amincissement |     0,4    | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|            Durée |      5     | The duration in seconds that the drawing will stay visible.                                           |
|  Cacher la durée |     0,5    | How long the laser stroke takes to disappear.                                                         |
|        Animation |    Fade    | The animation used when the laser stroke disappears.                                                  |

## Animation modes

|           Mode | Libellé                                                             |
| -------------: | :------------------------------------------------------------------ |
|           Fade | The stroke fades out after the duration has passed. |
| Chemin d'accès | The stroke disappears along the drawn path.         |
