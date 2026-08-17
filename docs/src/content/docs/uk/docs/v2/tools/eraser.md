---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Конфігурація

|         Властивість |     Типово     | Опис                                                                                                                                                                        |
| ------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|       Ширина штриха |        5       | Ширина риски                                                                                                                                                                |
|       Стерти фігури | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Стерти всі елементи |    хибність    | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                        Mode | Опис                                                                                        |
| --------------------------: | :------------------------------------------------------------------------------------------ |
|          Не стирайте фігури | The eraser will not interact with shapes.                                   |
|   Стерти при торканні ребер | The shape will be erased when the eraser touches any edge.                  |
| Стерти при торканні будь-де | The shape will be erased when the eraser is used anywhere inside the shape. |
