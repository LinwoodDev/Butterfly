---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

|            Property |       Default       | คำอธิบาย                                                                                                              |
| ------------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|                  สี |        สีแดง        | The color that will be drawn.                                                                         |
| ความกว้างของเส้นขีด |          5          | The width of the stroke.                                                                              |
|        การลดความหนา | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|            ระยะเวลา |          5          | The duration in seconds that the drawing will stay visible.                                           |
|        ซ่อนระยะเวลา | 0.5 | How long the laser stroke takes to disappear.                                                         |
|           แอนิเมชัน |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

|    Mode | คำอธิบาย                                                            |
| ------: | :------------------------------------------------------------------ |
|    Fade | The stroke fades out after the duration has passed. |
| เส้นทาง | The stroke disappears along the drawn path.         |
