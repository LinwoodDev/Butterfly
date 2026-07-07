---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

|          Property |       Default       | Beskrywing                                                                                                            |
| ----------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|             Color |         Red         | The color that will be drawn.                                                                         |
|          Lynwydte |          5          | The width of the stroke.                                                                              |
|        Verdunning | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|          Tydsduur |          5          | The duration in seconds that the drawing will stay visible.                                           |
| Versteek tydsduur | 0.5 | How long the laser stroke takes to disappear.                                                         |
|          Animasie |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | Beskrywing                                                          |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|  Pad | The stroke disappears along the drawn path.         |
