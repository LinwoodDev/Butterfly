---
title: Laser tool
---

With this tool you can draw on this paper temporarily. 一段时间后，抽取消失了。
Add a new drawing to the paper to cancel the previous laser stroke.

## 配置

|     属性 |         默认设置        | 描述                                                                                                                    |
| -----: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|     颜色 |         红色的         | The color that will be drawn.                                                                         |
|   笔画宽度 |          5          | The width of the stroke.                                                                              |
|     细化 | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|     期限 |          5          | The duration in seconds that the drawing will stay visible.                                           |
| 隐藏持续时间 | 0.5 | How long the laser stroke takes to disappear.                                                         |
|     动画 |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | 描述                                                                  |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|   路径 | The stroke disappears along the drawn path.         |
