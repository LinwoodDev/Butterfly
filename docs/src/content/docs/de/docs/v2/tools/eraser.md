---
title: Radiergummi
---

Mit diesem Werkzeug können Sie Elemente auf Ihrer Arbeitsfläche radieren.

## Konfiguration

|                Objekt |    Standard    | Beschreibung                                                                                                                                                                |
| --------------------: | :------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                 Modus |     Stroke     | `Stroke` cuts touched portions out of strokes and keeps the remaining fragments. `Path` removes the complete touched path or element.       |
|          Strichbreite |        5       | Die Breite des Strichs                                                                                                                                                      |
|        Formen löschen | Touch anywhere | [Erase shapes mode](#erase-shapes-mode)                                                                                                                                     |
| Alle Elemente löschen |     falsch     | Enables erasure for all elements (e.g. images and barcodes), except for those discussed in Erase shapes. |

### Erase shapes mode {#erase-shapes-mode}

Defines which part of a [shape](../shape) or [polygon](../polygon) needs to be touched for it to be
erased.

|                            Modus | Beschreibung                                                                                |
| -------------------------------: | :------------------------------------------------------------------------------------------ |
|             Formen nicht löschen | The eraser will not interact with shapes.                                   |
| Beim Berühren von Kanten löschen | The shape will be erased when the eraser touches any edge.                  |
|   Beim Berühren irgendwo löschen | The shape will be erased when the eraser is used anywhere inside the shape. |
