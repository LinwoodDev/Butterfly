---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Yapılandırma

|          Özellik |   Varsayılan   | Tanım                                                                                                                                                                       |
| ---------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|             Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
| Kontur genişliği |        5       | Kontur genişliği                                                                                                                                                            |
|    Şekilleri sil | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
|  Tüm öğeleri sil |      false     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                            Mode | Tanım                                                                                       |
| ------------------------------: | :------------------------------------------------------------------------------------------ |
|                 Şekilleri silme | The eraser will not interact with shapes.                                   |
|           Kenarlara değince sil | The shape will be erased when the eraser touches any edge.                  |
| Herhangi bir yere dokununca sil | The shape will be erased when the eraser is used anywhere inside the shape. |
