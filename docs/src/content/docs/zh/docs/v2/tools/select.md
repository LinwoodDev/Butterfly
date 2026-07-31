---
title: Select tool
---

With this tool you can select elements and access their [Context menu](../../context_menu).

## 配置

|       属性 |      默认设置      | 描述                                                               |
| -------: | :------------: | :--------------------------------------------------------------- |
|     Mode |       矩形       | Mode of selection. Valid are Rectangle and Lasso |
| Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                     |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|           Mode | 描述                                                                                          |
| -------------: | :------------------------------------------------------------------------------------------ |
| Full Selection | The selected area needs to fully enclose the element.                       |
|        触摸边缘时选择 | The shape will be selected when the selected area intersects any edge.      |
|      触摸任何地方时选择 | The shape will be selected when any part of it is inside the selected area. |
