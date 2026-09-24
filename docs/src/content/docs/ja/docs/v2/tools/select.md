---
title: Select tool
---

Use the Select tool to choose one or more canvas elements, then move, resize, or open their [Context menu](../../context_menu). Choose **Rectangle** mode to drag a rectangular selection region or **Lasso** mode to draw around irregular content.

After selecting an element, open its properties to edit values such as position and rotation. The context menu offers clipboard, arranging, layer, collection, and export actions. If you long press an empty part of the canvas, you can paste clipboard content at that position.

## 設定

|       属性 |      デフォルト     | 説明                                                               |
| -------: | :------------: | :--------------------------------------------------------------- |
|     Mode |       矩形       | Mode of selection. Valid are Rectangle and Lasso |
| Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                     |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|              Mode | 説明                                                                                          |
| ----------------: | :------------------------------------------------------------------------------------------ |
|    Full Selection | The selected area needs to fully enclose the element.                       |
|    エッジに触れたときに選択する | The shape will be selected when the selected area intersects any edge.      |
| 任意の場所に触れたときに選択します | The shape will be selected when any part of it is inside the selected area. |
