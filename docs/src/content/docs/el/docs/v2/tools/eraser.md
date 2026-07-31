---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Διαμόρφωση

|                    Ιδιότητα |   Προεπιλογή   | Περιγραφή                                                                                                                                                                   |
| --------------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                        Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|        Πλάτος περιγράμματος |        5       | Το πλάτος της διαδρομής                                                                                                                                                     |
|           Διαγραφή σχημάτων | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Διαγραφή όλων των στοιχείων |     ψευδές     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                              Mode | Περιγραφή                                                                                   |
| --------------------------------: | :------------------------------------------------------------------------------------------ |
|       Να μην διαγράφονται σχήματα | The eraser will not interact with shapes.                                   |
|       Διαγραφή κατά την αφή ακμών | The shape will be erased when the eraser touches any edge.                  |
| Διαγραφή όταν αγγίζετε οπουδήποτε | The shape will be erased when the eraser is used anywhere inside the shape. |
