---
title: Herramienta de borrador
---

Con esta herramienta puedes borrar los elementos en el papel.

## Configuración

|                  Propiedad |   Por defecto  | Descripción                                                                                                                                                                 |
| -------------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                       Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|            Ancho del trazo |        5       | El ancho del trazo                                                                                                                                                          |
|              Borrar formas | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Borrar todos los elementos |      falso     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                               Mode | Descripción                                                                                 |
| ---------------------------------: | :------------------------------------------------------------------------------------------ |
|                   No borrar formas | The eraser will not interact with shapes.                                   |
|             Borrar al tocar bordes | The shape will be erased when the eraser touches any edge.                  |
| Borrar al tocar en cualquier lugar | The shape will be erased when the eraser is used anywhere inside the shape. |
