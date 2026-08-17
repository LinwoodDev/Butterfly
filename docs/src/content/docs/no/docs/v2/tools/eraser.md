---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Konfigurasjon

|             Egenskap |    Standard    | Beskrivelse                                                                                                                                                                 |
| -------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                 Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
| Bredde på slagbredde |        5       | Bredden på slaglengden                                                                                                                                                      |
|        Slett figurer | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Slett alle elementer |      usann     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                                Mode | Beskrivelse                                                                                 |
| ----------------------------------: | :------------------------------------------------------------------------------------------ |
|                  Ikke slett figurer | The eraser will not interact with shapes.                                   |
|           Slett når kantene berører | The shape will be erased when the eraser touches any edge.                  |
| Slett under berøring hvor som helst | The shape will be erased when the eraser is used anywhere inside the shape. |
