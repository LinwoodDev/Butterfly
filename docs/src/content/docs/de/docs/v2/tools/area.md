---
title: Flächen-Tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Aktionen

|          Maus         |      Berühren     |             Aktion            |
| :-------------------: | :---------------: | :---------------------------: |
| Linksklick und ziehen | Tippen und ziehen | Einen neuen Bereich erstellen |
|    Mittlerer Klick    |    Zwei Finger    |      Leinwand verschieben     |
|      Rechtsklick      |    Lange Tippen   |       Bereich bearbeiten      |

## Konfiguration

|           Objekt | Standard | Beschreibung                                                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------: | :------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|           Breite |    `0`   | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|             Höhe |    `0`   | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| Seitenverhältnis |    `0`   | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Es gibt drei Aspekte Verhältnis Voreinstellungen:

- Quadrat (1:1)
- Seitenportrait (sqrt(2)) - Dies ist das Standard-Seitenverhältnis einer A4-Seite im Hochformat.
- Seitenlandschaft (1/sqrt(2)) - Dies ist das Standard-Seitenverhältnis einer A4-Seite im Querformat.
