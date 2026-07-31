---
title: Bereichswerkzeug
---

Mit dem Bereichswerkzeug können Sie Bereiche erstellen, bearbeiten und entfernen.

Eine Übersicht über die Funktionsweise von Bereichen finden Sie unter [Bereiche](../../areas).

## Aktionen

|          Maus         |      Berühren     |             Aktion            |
| :-------------------: | :---------------: | :---------------------------: |
| Linksklick und ziehen | Tippen und ziehen | Einen neuen Bereich erstellen |
|    Mittlerer Klick    |    Zwei Finger    |      Leinwand verschieben     |
|      Rechtsklick      |    Lange Tippen   |       Bereich bearbeiten      |

## Konfiguration

|            Objekt | Standard | Beschreibung                                                                                                                                                                                                                                                                                                                                                                                                                             |
| ----------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Nach Namen fragen |  falsch  | Whether a name prompt will appear before creation.                                                                                                                                                                                                                                                                                                                                                                       |
|          Vorlagen |   none   | Various presets for width and height.                                                                                                                                                                                                                                                                                                                                                                                    |
|            Breite |    `0`   | Die feste Breite für neue Bereiche. Wenn der Wert auf `0` gesetzt ist, wird diese Einstellung ignoriert.                                                                                                                                                                                                                                                                                                 |
|              Höhe |    `0`   | Die feste Höhe für neue Bereiche. Wenn der Wert auf `0` gesetzt ist, wird diese Einstellung ignoriert.                                                                                                                                                                                                                                                                                                   |
|  Seitenverhältnis |    `0`   | Das feste Seitenverhältnis für neue Bereiche. Select a preset from the segmented control or enter a custom value in the input field. Ein Seitenverhältnis ist als Breite / Höhe definiert. Werte kleiner als `1` sind daher höher als breit, Werte größer als `1` breiter als hoch. Wenn der Wert auf `0` gesetzt ist, wird diese Einstellung ignoriert. |

Es gibt drei Aspekte Verhältnis Voreinstellungen:

- Quadrat (1:1)
- Page portrait (1/sqrt(2)) - This is the default aspect ratio of an A4 page in portrait mode.
- Page landscape (sqrt(2)) - This is the default aspect ratio of an A4 page in landscape mode.
