---
title: Eraser tool
---

Com esta ferramenta, você pode apagar elementos do papel.

## Configuração

|               Propriedade |     Padrão     | Descrição                                                                                                                                                                   |
| ------------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                      Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|        Espessura do traço |        5       | A largura do traço                                                                                                                                                          |
|             Apagar formas | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Apagar todos os elementos |      Falso     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                                  Mode | Descrição                                                                                   |
| ------------------------------------: | :------------------------------------------------------------------------------------------ |
|                     Não apagar formas | The eraser will not interact with shapes.                                   |
|             Apagar ao tocar as bordas | The shape will be erased when the eraser touches any edge.                  |
| Apagar quando tocar em qualquer lugar | The shape will be erased when the eraser is used anywhere inside the shape. |
