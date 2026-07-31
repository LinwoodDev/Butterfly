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

|            Property |           Default           | Mô tả                                                                                                  |
| ------------------: | :-------------------------: | :----------------------------------------------------------------------------------------------------- |
|          Kích thước | (20, 20) | The size of the grid cells on the x and y axis.                                        |
|              Offset |  (0, 0)  | The offset of the grid on the x and y axis.                                            |
|             Màu sắc |            Black            | The color of the grid.                                                                 |
|       Độ trong suốt |             255             | The opacity of the grid lines.                                                         |
|              Stroke |              1              | The width of the grid lines.                                                           |
| Phụ thuộc thu phóng |            false            | Changes the grid cell spacing and snapping behavior relative to the zoom level.        |
|    Phụ thuộc vị trí |            false            | Makes the grid depend on the canvas position instead of staying fixed on the viewport. |
