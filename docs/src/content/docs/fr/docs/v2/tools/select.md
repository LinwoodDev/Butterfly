---
title: Outil sélection
---

With this tool you can select elements and access their [Context menu](../../context_menu).

## Configuration

| Propriété |   Par défaut   | Libellé                                                                                                |
| --------: | :------------: | :----------------------------------------------------------------------------------------------------- |
|      Mode |    Rectangle   | Mode de sélection. Les éléments valides sont le rectangle et le lasso. |
|  Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                                                           |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                                           Mode | Libellé                                                                                     |
| ---------------------------------------------: | :------------------------------------------------------------------------------------------ |
|                                 Full Selection | The selected area needs to fully enclose the element.                       |
|    Sélectionner lorsque vous touchez les bords | The shape will be selected when the selected area intersects any edge.      |
| Sélectionner lorsque vous touchez n'importe où | The shape will be selected when any part of it is inside the selected area. |
