---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Configurazione

|                   Proprietà |   Predefinito  | Descrizione                                                                                                                                                                 |
| --------------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                        Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|             Spessore tratto |        5       | La larghezza del tratto                                                                                                                                                     |
|              Cancella forme | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Cancella tutti gli elementi |      falso     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                               Mode | Descrizione                                                                                 |
| ---------------------------------: | :------------------------------------------------------------------------------------------ |
|               Non cancellare forme | The eraser will not interact with shapes.                                   |
| Cancella quando si toccano i bordi | The shape will be erased when the eraser touches any edge.                  |
|   Cancella quando si tocca ovunque | The shape will be erased when the eraser is used anywhere inside the shape. |
