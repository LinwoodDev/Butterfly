---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

|     Property |       Default       | תיאור                                                                                                                 |
| -----------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|        Color |         Red         | The color that will be drawn.                                                                         |
|      עובי קו |          5          | The width of the stroke.                                                                              |
|      הידקקות | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|          משך |          5          | The duration in seconds that the drawing will stay visible.                                           |
| הסתר משך זמן | 0.5 | How long the laser stroke takes to disappear.                                                         |
|      אנימציה |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | תיאור                                                               |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
| נתיב | The stroke disappears along the drawn path.         |
