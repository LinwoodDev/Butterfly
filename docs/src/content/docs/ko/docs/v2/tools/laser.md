---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

| Property |       Default       | 설명                                                                                                                    |
| -------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|    Color |         Red         | The color that will be drawn.                                                                         |
|     선 굵기 |          5          | The width of the stroke.                                                                              |
|    필압 감지 | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|    지속 시간 |          5          | The duration in seconds that the drawing will stay visible.                                           |
| 숨김 지속 시간 | 0.5 | How long the laser stroke takes to disappear.                                                         |
|    애니메이션 |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | 설명                                                                  |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|   경로 | The stroke disappears along the drawn path.         |
