---
title: เลเยอร์
---

Layers allow you to separate elements from each other and choose which layers are rendered on top of
others.

Layers are drawn from bottom to top, so the top layer will be shown above all other layers.

:::note\[Note]

Be aware that [Collections](../tools/collection) are not the same as layers. Collections are a
lightweight way to group elements, but do not affect the order in which they are rendered.

:::

## The Layers dialog

Open the layer dialog by clicking on the Butterfly button and selecting Layers, or by selecting the
Layers icon in the Navigation Rail if it is enabled.

Here you can see all the layers in the project. To create a new layer, use the Create button. To
show or hide a layer, use the eye button. To reorder the layers, click and drag the handle on the
right. You can also delete, rename, or duplicate a layer by right-clicking the layer or selecting
the three dots.

## Arrange {#arrange}

Within a layer you can set the rendering order by arranging the elements using
the [context menu](../context_menu).

|         Option | คำอธิบาย                                                                          |
| -------------: | --------------------------------------------------------------------------------- |
| นำขึ้นข้างหน้า | Renders the selection on top of the first element in front of it. |
|     ส่งถอยหลัง | Renders the selection under the first element behind it.          |
|   นำไปข้างหน้า | Renders the selection in front of everything else.                |
|  ส่งไปข้างหลัง | Renders the selection behind everything else.                     |

By default, elements within the same layer that were placed later are put in front of elements that
were placed before them.
This order stays consistent except when changed via the context menu.

For moved elements to be placed on top, enable `Bring moved elements to front` in the behaviors
settings.
