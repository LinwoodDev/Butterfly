---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Configuratie

|            Eigenschap |    Standaard   | Beschrijving                                                                                                                                                                |
| --------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                  Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|        Stroke breedte |        5       | De breedte van de beroerte                                                                                                                                                  |
|            Wis vormen | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Alle elementen wissen |     Onjuist    | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                       Mode | Beschrijving                                                                                |
| -------------------------: | :------------------------------------------------------------------------------------------ |
|         Vormen niet wissen | The eraser will not interact with shapes.                                   |
| Wissen bij aanraken randen | The shape will be erased when the eraser touches any edge.                  |
| Wissen bij aanraken overal | The shape will be erased when the eraser is used anywhere inside the shape. |
