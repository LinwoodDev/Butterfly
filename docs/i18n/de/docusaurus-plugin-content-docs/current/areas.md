---
title: "Flächen"
sidebar_position: 2
---

import {Monitor} from "@phosphor-icons/react";


## Einführung

![Fläche](area.png)

Flächen sind eine Möglichkeit, die Größe der Leinwand zu beschränken. Sie können Flächen mit dem [Flächenwerkzeug](tools/area.md) erstellen. Wenn Sie auf den Hintergrund klicken, können Sie den Bereichslisten-Dialog über das Kontextmenü öffnen.

## Bereiche erstellen und löschen

While you can directly edit the content on the canvas, it is common that you would like to restrict the region in which you can modify the content, or that you would like ot be able to be able to quickly access a part of the document. For that, you have the <Monitor/> Area tool. As explained in the [introduction section](README.md), you might need to add the <Monitor/> area button to your toolbar. Using the [area tool](tools/area.md), you can draw rectangle anywhere on the canvas to then define the area.

## More control

You can further define area tool by clicking again on the <Monitor/> area button. There, you can define the areas's fixed width, height, or aspect ratio.

## The area context menu

 After drawing an area, you can click or long tap on touch display the area to open a context menu with the following options:

* `Name` - Give the area a name that is convinient for you to use. This is useful, for example when...
* `Enter the area` - Allowing you to edit content only borded by this area.
* `Delete` - Delete the area. This *does not* delete the content within this area.
* `Export` - Export the content of the selected area.
* `Add to pack` - Add the area to a [pack](pack)

## Another option

Another option for you to use the area navigator is on the left menu, or on the butterfly menu if you are using a mobile platform. 

