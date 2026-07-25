---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## Configuration

|           Property |    Default     | Description                                                                                              |
|-------------------:|:--------------:|:---------------------------------------------------------------------------------------------------------|
|               Mode |      Path      | Eraser mode. Valid are Stroke and Path                                                                   |
|       Stroke width |       5        | The width of the stroke                                                                                  |
|       Erase shapes | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                  |
| Erase all elements |     false      | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                         Mode | Description                                                                 |
|-----------------------------:|:----------------------------------------------------------------------------|
|           Don't erase shapes | The eraser will not interact with shapes.                                   |
|    Erase when touching edges | The shape will be erased when the eraser touches any edge.                  |
| Erase when touching anywhere | The shape will be erased when the eraser in used anywhere inside the shape. |