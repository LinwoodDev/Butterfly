---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Konfigurace

|               Majetek |     Výchozí    | Popis                                                                                                                                                                       |
| --------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                  Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|                 Šířka |        5       | Šířka zdvihu                                                                                                                                                                |
|         Vymazat tvary | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Vymazat všechny prvky |    nepravda    | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                        Mode | Popis                                                                                       |
| --------------------------: | :------------------------------------------------------------------------------------------ |
|              Nesmazat tvary | The eraser will not interact with shapes.                                   |
| Vymazat při dotyku na hrany | The shape will be erased when the eraser touches any edge.                  |
| Vymazat při dotyku kdekoliv | The shape will be erased when the eraser is used anywhere inside the shape. |
