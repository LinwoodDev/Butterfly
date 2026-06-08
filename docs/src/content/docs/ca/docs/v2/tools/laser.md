---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

|           Property |       Default       | Descripció                                                                                                            |
| -----------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|              Color |         Red         | The color that will be drawn.                                                                         |
|   Amplada del traç |          5          | The width of the stroke.                                                                              |
|          Afinament | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|             Durada |          5          | The duration in seconds that the drawing will stay visible.                                           |
| Durada d'ocultació | 0.5 | How long the laser stroke takes to disappear.                                                         |
|           Animació |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | Descripció                                                          |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
| Ruta | The stroke disappears along the drawn path.         |
