---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Konfiguration

|            Egenskap |    Standard    | Beskrivning                                                                                                                                                                 |
| ------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|        Stroke bredd |        5       | Bredden på slaget                                                                                                                                                           |
|       Radera former | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Radera alla element |     falskt     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                               Mode | Beskrivning                                                                                 |
| ---------------------------------: | :------------------------------------------------------------------------------------------ |
|                 Radera inte former | The eraser will not interact with shapes.                                   |
|         Radera när kanterna vidrör | The shape will be erased when the eraser touches any edge.                  |
| Radera när du vidrör var som helst | The shape will be erased when the eraser is used anywhere inside the shape. |
