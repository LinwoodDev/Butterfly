---
title: Select tool
---


With this tool you can select elements.

## Configuration

| Property |    Default     | Description                                      |
|---------:|:--------------:|:-------------------------------------------------|
|     Mode |   Rectangle    | Mode of selection. Valid are Rectangle and Lasso |
| Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                     |

### Hit mode

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                          Mode | Description                                                                 |
|------------------------------:|:----------------------------------------------------------------------------|
|                Full Selection | The selected area needs to fully enclose the element.                       |
|    Select when touching edges | The shape will be selected when the selected area intersects any edge.      |
| Select when touching anywhere | The shape will be selected when any part of it is inside the selected area. |
