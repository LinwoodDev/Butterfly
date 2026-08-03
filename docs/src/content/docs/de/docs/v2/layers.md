---
title: Ebenen
---

Layers allow you to separate elements from each other and choose which layers are rendered on top of
others.

Die Ebenen werden von unten nach oben gezeichnet, so dass die obere Ebene vor allen anderen Ebenen angezeigt wird.

:::note\[Note]

[Collections](../tools/collection) ist nicht dasselbe wie Ebenen. Collections are a
lightweight way to group elements, but do not affect the order in which they are rendered.

:::

## Der Ebenendialog

Open the layer dialog by clicking on the Butterfly button and selecting Layers, or by selecting the
Layers icon in the Navigation Rail if it is enabled.

Hier sehen Sie alle Ebenen im Projekt. Um eine neue Ebene zu erstellen, benutzen Sie die Schaltfläche Erstellen. To
show or hide a layer, use the eye button. To reorder the layers, click and drag the handle on the
right. You can also delete, rename, or duplicate a layer by right-clicking the layer or selecting
the three dots.

## Arrange {#arrange}

Within a layer you can set the rendering order by arranging the elements using
the [context menu](../context_menu).

|             Option | Beschreibung                                                                      |
| -----------------: | --------------------------------------------------------------------------------- |
|   Vorwärts bringen | Renders the selection on top of the first element in front of it. |
|   Rückwärts senden | Renders the selection under the first element behind it.          |
| Nach vorne bringen | Renders the selection in front of everything else.                |
|   An zurück senden | Renders the selection behind everything else.                     |

By default, elements within the same layer that were placed later are put in front of elements that
were placed before them.
This order stays consistent except when changed via the context menu.

For moved elements to be placed on top, enable `Bring moved elements to front` in the behaviors
settings.
