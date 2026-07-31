---
title: Auswahlwerkzeug
---

With this tool you can select elements and access their [Context menu](../../context_menu).

## Konfiguration

|   Objekt |    Standard    | Beschreibung                                                  |
| -------: | :------------: | :------------------------------------------------------------ |
|    Modus |    Rechteck    | Auswahlmodus. Erlaubt sind Rechteck und Lasso |
| Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                  |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                              Modus | Beschreibung                                                                                |
| ---------------------------------: | :------------------------------------------------------------------------------------------ |
|                     Full Selection | The selected area needs to fully enclose the element.                       |
| Beim Berühren von Kanten auswählen | The shape will be selected when the selected area intersects any edge.      |
|   Beim Berühren irgendwo auswählen | The shape will be selected when any part of it is inside the selected area. |
