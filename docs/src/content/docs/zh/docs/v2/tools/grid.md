---
title: Grid tool
---

:::note[🔘 Toggleable tool]

This is a special tool.
It can't be selected and will run the action immediately when you click on it.

:::

With this tool you can show a grid over the canvas.
Inputs get snapped to the grid.

The grid is a canvas aid. To draw straight lines at a chosen angle, use the [Ruler tool](../ruler/). To make a grid part of the page itself, configure a [pattern background](../../background/#pattern-layers).

## 配置

|     属性 |             默认设置            | 描述                                                                                                     |
| -----: | :-------------------------: | :----------------------------------------------------------------------------------------------------- |
|     大小 | (20, 20) | The size of the grid cells on the x and y axis.                                        |
| Offset |  (0, 0)  | The offset of the grid on the x and y axis.                                            |
|     颜色 |              黑色             | The color of the grid.                                                                 |
|   不透明度 |             255             | The opacity of the grid lines.                                                         |
|   笔画宽度 |              1              | The width of the grid lines.                                                           |
|   依靠缩放 |            false            | Changes the grid cell spacing and snapping behavior relative to the zoom level.        |
| 位置依赖关系 |            false            | Makes the grid depend on the canvas position instead of staying fixed on the viewport. |
