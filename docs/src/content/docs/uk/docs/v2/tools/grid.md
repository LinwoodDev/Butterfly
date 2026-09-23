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

## Конфігурація

|            Властивість |            Типово           | Опис                                                                                                   |
| ---------------------: | :-------------------------: | :----------------------------------------------------------------------------------------------------- |
|                 Розмір | (20, 20) | The size of the grid cells on the x and y axis.                                        |
|                 Offset |  (0, 0)  | The offset of the grid on the x and y axis.                                            |
|                  Колір |         Чорний колір        | The color of the grid.                                                                 |
|                  Альфа |             255             | The opacity of the grid lines.                                                         |
|          Ширина штриха |              1              | The width of the grid lines.                                                           |
|    Залежність масштабу |           хибність          | Changes the grid cell spacing and snapping behavior relative to the zoom level.        |
| Залежність від позиції |           хибність          | Makes the grid depend on the canvas position instead of staying fixed on the viewport. |
