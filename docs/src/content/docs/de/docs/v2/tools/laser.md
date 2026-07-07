---
title: Laserwerkzeug
---

Mit diesem Werkzeug können Sie temporär auf Ihrer Arbeitsfläche zeichnen. Nach einer Weile verschwindet die Zeichnung.
Add a new drawing to the paper to cancel the previous laser stroke.

## Konfiguration

|           Objekt |       Standard      | Beschreibung                                                                                                          |
| ---------------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|            Farbe |         Rot         | The color that will be drawn.                                                                         |
|     Strichbreite |          5          | The width of the stroke.                                                                              |
|       Ausdünnung | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|            Dauer |          5          | The duration in seconds that the drawing will stay visible.                                           |
| Dauer ausblenden | 0.5 | How long the laser stroke takes to disappear.                                                         |
|        Animation |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Modus | Beschreibung                                                        |
| ----: | :------------------------------------------------------------------ |
|  Fade | The stroke fades out after the duration has passed. |
|  Pfad | The stroke disappears along the drawn path.         |
