---
title: Select tool
---


Use the Select tool to choose one or more canvas elements, then move, resize, or open their [Context menu](../../context_menu). Choose **Rectangle** mode to drag a rectangular selection region or **Lasso** mode to draw around irregular content.

After selecting an element, open its properties to edit values such as position and rotation. The context menu offers clipboard, arranging, layer, collection, and export actions. If you long press an empty part of the canvas, you can paste clipboard content at that position.

## Configuration

| Property |    Default     | Description                                      |
|---------:|:--------------:|:-------------------------------------------------|
|     Mode |   Rectangle    | Mode of selection. Valid are Rectangle and Lasso |
| Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                     |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                          Mode | Description                                                                 |
|------------------------------:|:----------------------------------------------------------------------------|
|                Full Selection | The selected area needs to fully enclose the element.                       |
|    Select when touching edges | The shape will be selected when the selected area intersects any edge.      |
| Select when touching anywhere | The shape will be selected when any part of it is inside the selected area. |
