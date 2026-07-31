---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Konfiguration

|            Egenskab |    Standard    | Varebeskrivelse                                                                                                                                                             |
| ------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|          Slaglængde |        5       | Bredden af stregen                                                                                                                                                          |
|        Slet figurer | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Slet alle elementer |      falsk     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                        Mode | Varebeskrivelse                                                                             |
| --------------------------: | :------------------------------------------------------------------------------------------ |
|         Ikke slette figurer | The eraser will not interact with shapes.                                   |
| Slet ved berøring af kanter | The shape will be erased when the eraser touches any edge.                  |
|   Slet ved berøring overalt | The shape will be erased when the eraser is used anywhere inside the shape. |
