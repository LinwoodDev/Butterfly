---
title: Select tool
---

With this tool you can select elements and access their [Context menu](../../context_menu).

## Asetukset

| Ominaisuus |     Oletus     | Kuvaus                                                           |
| ---------: | :------------: | :--------------------------------------------------------------- |
|       Mode |   Suorakulmio  | Mode of selection. Valid are Rectangle and Lasso |
|   Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                     |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                                 Mode | Kuvaus                                                                                      |
| -----------------------------------: | :------------------------------------------------------------------------------------------ |
|                       Full Selection | The selected area needs to fully enclose the element.                       |
|        Valitse kun koskettaa reunoja | The shape will be selected when the selected area intersects any edge.      |
| Valitse koskettaessasi mihin tahansa | The shape will be selected when any part of it is inside the selected area. |
