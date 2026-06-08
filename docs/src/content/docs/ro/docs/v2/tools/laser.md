---
title: Laser tool
---

With this tool you can draw on this paper temporarily. După o vreme, desenul dispare.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configurare

|        Proprietate |       Implicit      | Descriere                                                                                                             |
| -----------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|            Culoare |         Roșu        | The color that will be drawn.                                                                         |
| Lățimea conturului |          5          | The width of the stroke.                                                                              |
|           Thinning | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|             Durată |          5          | The duration in seconds that the drawing will stay visible.                                           |
|     Ascunde durata | 0.5 | How long the laser stroke takes to disappear.                                                         |
|           Animaţie |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | Descriere                                                           |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
| Cale | The stroke disappears along the drawn path.         |
