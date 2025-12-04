---
title: Pen tool
---

With this tool you can draw strokes on the infinite canvas!

Strokes are the lines that you draw using the pen.

This tool has many properties, as you can make a highlighter using the pen tool!

## How to ~~Pen~~ Highlighter

The pen tool can be used as a highlighter if you want!

### Follow these steps or the video below

First, add a new pen tool into the toolbar

1. Press the + button in the toolbar!
2. Add a pen
3. Hold the new pen icon to move it
   - Note: when moving any tool, make sure to modify the settings in the behaviors tab to make sure the correct tool is activated for each input

Then, modify the new pen

1. Open the properties panel of the new pen by pressing it again
2. Rename the pen by double tapping the tool's name.
3. After renaming the pen to highlighter, change the icon to match the highlighter look by pressing the icon

Finally, after modifying the tool's appearance. It's time to modify the properties!

1. Change the stroke width to a big number, for example, 50.
   Highlighters have big strokes after all
2. Set thinning to 0.  
   Highlighters don't have variable stroke width.
3. Also set the smoothing to 0.  
   Smoothing is something that highlighters never make.
4. Set the streamline to MAX (1)  
   to make the highlighter's strokes look more like lines :]
5. Change the alpha to 50 or similar,  
   this makes sure the strokes under the highlighting are visible.

### This video demonstrates how to apply the guide above

<video controls width="600">
  <source src="/vid/How2Highlighter.mp4" type="video/mp4" />
  
  Your browser does not support the video tag.
</video>

**Congratulations, you now have a highlighter!**

## Konfiguracja

|                Własność |                                Domyślny                                | Opis                                                                                                                                    |
| ----------------------: | :--------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------- |
|                   Kolor |                                 Czarny                                 | Kolor który zostanie narysowany                                                                                                         |
|         Szerokość skoku |                                    5                                   | Szerokość obrysu                                                                                                                        |
| Zależny od powiększenia |                                fałszywy                                | To zmieni szerokość uderzenia w zależności od poziomu powiększenia.                                                     |
|     Wykrywanie kształtu | false (Delay: 0.5s) | This will try to detect shapes while drawing. If a shape is detected, it will be replaced by the shape. |
|              Miażdżenie |                           0.4                          | This effect of pressure on the stroke size                                                                                              |
|             Wygładzanie |                           0.5                          | This will smooth the edges of the stroke.                                                                               |
|              Streamline |                           0.5                          | How much the pen will follow the movement of the mouse.                                                                 |
|                   Kolor |                                 Czarny                                 | Kolor który zostanie narysowany                                                                                                         |
|                Wypełnij |                              Przezroczysty                             | The color that will be drawn inside the shape                                                                                           |
