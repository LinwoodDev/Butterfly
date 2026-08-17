---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Konfiguracja

|                   Własność |    Domyślny    | Opis                                                                                                                                                                        |
| -------------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                       Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|            Szerokość skoku |        5       | Szerokość obrysu                                                                                                                                                            |
|           Wyczyść kształty | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Wyczyść wszystkie elementy |    fałszywy    | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                                   Mode | Opis                                                                                        |
| -------------------------------------: | :------------------------------------------------------------------------------------------ |
|                   Nie usuwaj kształtów | The eraser will not interact with shapes.                                   |
|     Wyczyść podczas dotykania krawędzi | The shape will be erased when the eraser touches any edge.                  |
| Wyczyść podczas dotykania gdziekolwiek | The shape will be erased when the eraser is used anywhere inside the shape. |
