---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

|          Property |       Default       | विवरण                                                                                                                 |
| ----------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|             Color |         Red         | The color that will be drawn.                                                                         |
| स्ट्रोक की चौड़ाई |          5          | The width of the stroke.                                                                              |
|            पतलापन | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|              अवधि |          5          | The duration in seconds that the drawing will stay visible.                                           |
|       अवधि छिपाएं | 0.5 | How long the laser stroke takes to disappear.                                                         |
|           एनिमेशन |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | विवरण                                                               |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|   पथ | The stroke disappears along the drawn path.         |
