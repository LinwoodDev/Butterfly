---
title: Select tool
---

With this tool you can select elements and access their [Context menu](../../context_menu).

## Конфігурація

| Властивість |     Типово     | Опис                                                             |
| ----------: | :------------: | :--------------------------------------------------------------- |
|        Mode |   Прямокутник  | Mode of selection. Valid are Rectangle and Lasso |
|    Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                     |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                        Mode | Опис                                                                                        |
| --------------------------: | :------------------------------------------------------------------------------------------ |
|              Full Selection | The selected area needs to fully enclose the element.                       |
| Вибрати при дотику до ребер | The shape will be selected when the selected area intersects any edge.      |
|    Вибрати торкання будь-де | The shape will be selected when any part of it is inside the selected area. |
