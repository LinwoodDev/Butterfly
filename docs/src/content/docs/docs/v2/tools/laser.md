---
title: Laser tool
---

With this tool you can draw on this paper temporarily. After a while, the drawing fades away.
Add a new drawing to the paper to cancel the previous laser stroke.

## Configuration

| Property | Default | Description |
| -------: | :-----: | :---------- |
| Color | Red | The color that will be drawn. |
| Stroke width | 5 | The width of the stroke. |
| Thinning | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
| Duration | 5 | The duration in seconds that the drawing will stay visible. |
| Hide duration | 0.5 | How long the laser stroke takes to disappear. |
| Animation | Fade | The animation used when the laser stroke disappears. |

## Animation modes

| Mode | Description |
| ---: | :---------- |
| Fade | The stroke fades out after the duration has passed. |
| Path | The stroke disappears along the drawn path. |
