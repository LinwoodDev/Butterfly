---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Конфигурация

|             Свойства |  По умолчанию  | Описание                                                                                                                                                                    |
| -------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                 Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|        Ширина штриха |        5       | Толщина линии                                                                                                                                                               |
|       Удалить фигуры | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Удалить все элементы |      ложь      | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                              Mode | Описание                                                                                    |
| --------------------------------: | :------------------------------------------------------------------------------------------ |
|                 Не стереть фигуры | The eraser will not interact with shapes.                                   |
|         Стереть при касании краев | The shape will be erased when the eraser touches any edge.                  |
| Стереть при касании в любом месте | The shape will be erased when the eraser is used anywhere inside the shape. |
