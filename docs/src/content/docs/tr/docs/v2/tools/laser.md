---
title: Laser tool
---

With this tool you can draw on this paper temporarily. Bir süre sonra çizim kaybolur.
Add a new drawing to the paper to cancel the previous laser stroke.

## Yapılandırma

|          Özellik |      Varsayılan     | Tanım                                                                                                                 |
| ---------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|             Renk |       Kırmızı       | The color that will be drawn.                                                                         |
| Kontur genişliği |          5          | The width of the stroke.                                                                              |
|         Kalinlik | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|             Süre |          5          | The duration in seconds that the drawing will stay visible.                                           |
|   Gizleme süresi | 0.5 | How long the laser stroke takes to disappear.                                                         |
|        Animasyon |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | Tanım                                                               |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|  Yol | The stroke disappears along the drawn path.         |
