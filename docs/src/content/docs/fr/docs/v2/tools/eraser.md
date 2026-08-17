---
title: Outil gomme
---

Avec cet outil vous pouvez effacer des éléments du document.

## Configuration

|                 Propriété |   Par défaut   | Libellé                                                                                                                                                                     |
| ------------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                      Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|          Largeur du trait |        5       | La largeur du trait                                                                                                                                                         |
|        Effacer les formes | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Effacer tous les éléments |    Désactivé   | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                                      Mode | Libellé                                                                                     |
| ----------------------------------------: | :------------------------------------------------------------------------------------------ |
|                 Ne pas effacer les formes | The eraser will not interact with shapes.                                   |
|    Effacer lorsque vous touchez les bords | The shape will be erased when the eraser touches any edge.                  |
| Effacer lorsque vous touchez n'importe où | The shape will be erased when the eraser is used anywhere inside the shape. |
