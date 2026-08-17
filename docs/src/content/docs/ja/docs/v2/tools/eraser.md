---
title: Eraser tool
---

With this tool you can erase the elements on the paper.

## 設定

|        属性 |      デフォルト     | 説明                                                                                                                                                                          |
| --------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|      Mode |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|   ストロークの幅 |        5       | ストロークの幅                                                                                                                                                                     |
|     図形を消去 | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| すべての要素を消去 |      false     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|           Mode | 説明                                                                                          |
| -------------: | :------------------------------------------------------------------------------------------ |
|     シェイプを消去しない | The eraser will not interact with shapes.                                   |
| エッジに触れたときに消去する | The shape will be erased when the eraser touches any edge.                  |
|    どこに触れても消去する | The shape will be erased when the eraser is used anywhere inside the shape. |
