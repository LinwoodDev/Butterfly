---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

| Property |       Default       | 說明                                                                                                                    |
| -------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|       顏色 |         Red         | The color that will be drawn.                                                                         |
|     筆劃寬度 |          5          | The width of the stroke.                                                                              |
|      稀薄化 | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|     存續時間 |          5          | The duration in seconds that the drawing will stay visible.                                           |
|   隱藏持續時間 | 0.5 | How long the laser stroke takes to disappear.                                                         |
|       動畫 |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | 說明                                                                  |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|   路徑 | The stroke disappears along the drawn path.         |
