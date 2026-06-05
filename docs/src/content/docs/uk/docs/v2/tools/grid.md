---
title: Grid tool
---

:::note[🔘 Toggleable tool]

This is a special tool.
You can't select it and it gets toggled if you click on it.

:::

With this tool you can show a grid over the canvas.
Inputs get snapped to the grid.

## Конфігурація

|            Властивість |            Типово           | Опис                                                                                                   |
| ---------------------: | :-------------------------: | :----------------------------------------------------------------------------------------------------- |
|                 Розмір | (20, 20) | The size of the grid cells on the x and y axis.                                        |
|                 Offset |  (0, 0)  | The offset of the grid on the x and y axis.                                            |
|                  Колір |         Чорний колір        | The color of the grid.                                                                 |
|                 Stroke |              1              | The width of the grid lines.                                                           |
|    Залежність масштабу |           хибність          | Changes the grid stroke width based on the zoom level.                                 |
| Залежність від позиції |           хибність          | Makes the grid depend on the canvas position instead of staying fixed on the viewport. |
