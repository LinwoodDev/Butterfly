---
title: Formwerkzeug
---

Benutzen Sie dieses Werkzeug um Formen auf Ihrem Dokument zu zeichnen.
You can draw rectangles, triangles, circles, lines, and other shapes.

Benutzen Sie `Strg` um die Breite und Höhe gleichzusetzen und `Shift` um von der Mitte aus zu zeichnen.

## Konfiguration

|           Objekt |                   Standard                   | Beschreibung                                                                                                                                                                                                |
| ---------------: | :------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|        Zentriert |                    falsch                    | Draws the shape from the center instead of from the corner.                                                                                                                                 |
|           Breite |                       0                      | Die feste Breite des Bereichs. Wenn auf 0 gesetzt, wird die Breite automatisch berechnet.                                                                                   |
|             Höhe |                       0                      | Die feste Höhe der Fläche. Wenn auf 0 gesetzt, wird die Höhe automatisch berechnet.                                                                                         |
| Seitenverhältnis |                       0                      | Das fixe Seitenverhältnis des Bereichs. Wenn 0 gesetzt wird, wird das Seitenverhältnis automatisch berechnet. An aspect ratio is defined as width / height. |
|     Strichbreite |                       5                      | Die Breite des Strichs                                                                                                                                                                                      |
|       Strichstil |                  Durchgehend                 | The style of the stroke. Other styles can use dash and gap lengths.                                                                                                         |
|      Strichlänge |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                                  |
|      Lückenlänge |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                                   |
|            Farbe |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                             |
|             Form |                   Rechteck                   | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                                     |
|      Eckenradius |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                           |
|           Füllen | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                                    |
|     Zoomabhängig |                    falsch                    | Dies ändert die Pinselbreite basierend auf der Zoomstufe.                                                                                                                                   |