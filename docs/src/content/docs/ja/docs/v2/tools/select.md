---
title: Select tool
---

With this tool you can select elements and access their [Context menu](../../context_menu).

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
