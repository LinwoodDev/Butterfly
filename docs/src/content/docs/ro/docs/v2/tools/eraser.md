---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Configurare

|             Proprietate |    Implicit    | Descriere                                                                                                                                                                   |
| ----------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                    Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|      Lățimea conturului |        5       | Lățimea conturului                                                                                                                                                          |
|            Șterge forme | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Şterge toate elementele |      fals      | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                             Mode | Descriere                                                                                   |
| -------------------------------: | :------------------------------------------------------------------------------------------ |
|                Nu șterge formele | The eraser will not interact with shapes.                                   |
| Ștergeți când atingeți marginile | The shape will be erased when the eraser touches any edge.                  |
|   Ștergeți când atingeți oriunde | The shape will be erased when the eraser is used anywhere inside the shape. |
