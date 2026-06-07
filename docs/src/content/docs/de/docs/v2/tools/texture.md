---
title: Textur
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Verwendung

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Konfiguration

|           Objekt | Standard | Beschreibung                                                                                                                                                                                            |
| ---------------: | :------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|     Zoomabhängig |  falsch  | Dies ändert die Pinselbreite basierend auf der Zoomstufe.                                                                                                                               |
|           Textur |  Muster  | The pattern that should be added.                                                                                                                                                       |
|           Breite |     0    | Die feste Breite des Bereichs. If set to `0`, the width will be calculated automatically.                                                                               |
|             Höhe |     0    | Die feste Höhe der Fläche. If set to `0`, the height will be calculated automatically.                                                                                  |
| Seitenverhältnis |     0    | Das fixe Seitenverhältnis des Bereichs. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Gültige Typen für Texturen sind:

- [Muster](../../background#pattern)
