---
sidebar_label: "Fläche"
---

# Flächenmaler

Der Flächenmaler ermöglicht das Erstellen, Bearbeiten und Entfernen von Bereichen.

## Aktionen

|         Maus          |     Berühren      |            Aktion             |
|:---------------------:|:-----------------:|:-----------------------------:|
| Linksklick und ziehen | Tippen und ziehen | Einen neuen Bereich erstellen |
|    Mittlerer Klick    |    Zwei Finger    |     Leinwand verschieben      |
|      Rechtsklick      |   Lange Tippen    |      Bereich bearbeiten       |

## Konfiguration

|           Objekt | Standard | Beschreibung                                                                                                                                                         |
| ----------------:|:--------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|           Breite |    0     | Die feste Breite des Bereichs. Wenn auf 0 gesetzt, wird die Breite automatisch berechnet.                                                                            |
|             Höhe |    0     | Die feste Höhe der Fläche. Wenn auf 0 gesetzt, wird die Höhe automatisch berechnet.                                                                                  |
| Seitenverhältnis |    0     | Das fixe Seitenverhältnis des Bereichs. Wenn 0 gesetzt wird, wird das Seitenverhältnis automatisch berechnet. Ein Seitenverhältnis wird als Breite / Höhe definiert. |

Es gibt drei Aspekte Verhältnis Voreinstellungen:

* Quadrat (1:1)
* Seitenportrait (sqrt(2)) - Dies ist das Standard-Seitenverhältnis einer A4-Seite im Hochformat.
* Seitenlandschaft (1/sqrt(2)) - Dies ist das Standard-Seitenverhältnis einer A4-Seite im Querformat.
