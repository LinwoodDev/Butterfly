---
title: Grid tool
---

:::note[🔘 Toggleable tool]

This is a special tool.
It can't be selected and will run the action immediately when you click on it.

:::

With this tool you can show a grid over the canvas.
Inputs get snapped to the grid.

## Configuration

|  Property |           Default           | 설명                                                                                                     |
| --------: | :-------------------------: | :----------------------------------------------------------------------------------------------------- |
|        크기 | (20, 20) | The size of the grid cells on the x and y axis.                                        |
|    Offset |  (0, 0)  | The offset of the grid on the x and y axis.                                            |
|     Color |            Black            | The color of the grid.                                                                 |
|        알파 |             255             | The opacity of the grid lines.                                                         |
|    Stroke |              1              | The width of the grid lines.                                                           |
| 확대/축소에 따라 |            false            | Changes the grid cell spacing and snapping behavior relative to the zoom level.        |
|    위치에 따라 |            false            | Makes the grid depend on the canvas position instead of staying fixed on the viewport. |
