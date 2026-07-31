---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## الإعدادات

|        الممتلكات |    الافتراضي   | الوصف                                                                                                                                                                       |
| ---------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|         عرض الخط |        5       | عرض جرة القدم                                                                                                                                                               |
|      مسح الأشكال | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| مسح جميع العناصر |      خاطئ      | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                Mode | الوصف                                                                                       |
| ------------------: | :------------------------------------------------------------------------------------------ |
|      لا تمح الأشكال | The eraser will not interact with shapes.                                   |
|  محو عند لمس الحواف | The shape will be erased when the eraser touches any edge.                  |
| محو عند لمس أي مكان | The shape will be erased when the eraser is used anywhere inside the shape. |
