---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Asetukset

|              Ominaisuus |     Oletus     | Kuvaus                                                                                                                                                                      |
| ----------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                    Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|          Aivojen leveys |        5       | Aivohalvauksen leveys                                                                                                                                                       |
|            Pyyhi muodot | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Poista kaikki elementit |     epätosi    | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                             Mode | Kuvaus                                                                                      |
| -------------------------------: | :------------------------------------------------------------------------------------------ |
|               Älä poista muotoja | The eraser will not interact with shapes.                                   |
|      Pyyhi kun koskettaa reunoja | The shape will be erased when the eraser touches any edge.                  |
| Pyyhi koskettaessa minne tahansa | The shape will be erased when the eraser is used anywhere inside the shape. |
