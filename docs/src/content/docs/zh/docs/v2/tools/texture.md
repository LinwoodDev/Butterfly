---
title: 纹理
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## 配置

|   属性 |  默认设置 | 描述                                                                                                                                                        |
| ---: | :---: | :-------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 依靠缩放 | false | 这将改变基于缩放级别的笔画宽度。                                                                                                                                          |
|   纹理 |   图案  | The pattern that should be added.                                                                                                         |
|   宽度 |   0   | 区域的固定宽度。 If set to `0`, the width will be calculated automatically.                                                                       |
|   高度 |   0   | 区域的固定高度 If set to `0`, the height will be calculated automatically.                                                                       |
|  纵横比 |   0   | 区域的固定宽高比。 If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
