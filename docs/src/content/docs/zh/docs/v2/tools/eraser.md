---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## 配置

|     属性 |      默认设置      | 描述                                                                                                                                                                          |
| -----: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|   笔画宽度 |        5       | 笔画的宽度                                                                                                                                                                       |
|   擦除形状 | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| 删除所有元素 |      false     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|      Mode | 描述                                                                                          |
| --------: | :------------------------------------------------------------------------------------------ |
|     不擦除形状 | The eraser will not interact with shapes.                                   |
|   触摸边缘时擦除 | The shape will be erased when the eraser touches any edge.                  |
| 触摸任何地方时擦除 | The shape will be erased when the eraser is used anywhere inside the shape. |
