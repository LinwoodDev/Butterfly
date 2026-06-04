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

|           Objekt | Standard | Beschreibung                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ---------------: | :------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|           Breite |    `0`   | Die feste Breite für neue Bereiche. Wenn der Wert auf `0` gesetzt ist, wird diese Einstellung ignoriert.                                                                                                                                                                                                                                                                                                                                    |
|             Höhe |    `0`   | Die feste Höhe für neue Bereiche. Wenn der Wert auf `0` gesetzt ist, wird diese Einstellung ignoriert.                                                                                                                                                                                                                                                                                                                                      |
| Seitenverhältnis |    `0`   | Das feste Seitenverhältnis für neue Bereiche. Drücke die Schaltfläche <DotsThreeVertical className="inline-icon"/>, um auf einige gängige Voreinstellungen zuzugreifen. Ein Seitenverhältnis ist als Breite / Höhe definiert. Werte kleiner als `1` sind daher höher als breit, Werte größer als `1` breiter als hoch. Wenn der Wert auf `0` gesetzt ist, wird diese Einstellung ignoriert. |

Es gibt drei Aspekte Verhältnis Voreinstellungen:

- Quadrat (1:1)
- Seitenportrait (sqrt(2)) - Dies ist das Standard-Seitenverhältnis einer A4-Seite im Hochformat.
- Seitenlandschaft (1/sqrt(2)) - Dies ist das Standard-Seitenverhältnis einer A4-Seite im Querformat.
