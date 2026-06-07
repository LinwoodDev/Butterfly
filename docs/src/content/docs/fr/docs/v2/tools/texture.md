---
title: Texture
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Utilisation

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Configuration

|         Propriété | Par défaut | Libellé                                                                                                                                                                                              |
| ----------------: | :--------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Dépendant du zoom |    Faux    | Cela changera la largeur du trait en fonction du niveau de zoom.                                                                                                                     |
|           Texture |   Schéma   | The pattern that should be added.                                                                                                                                                    |
|           Largeur |      0     | La largeur fixe de la zone. If set to `0`, the width will be calculated automatically.                                                                               |
|           Hauteur |      0     | La hauteur fixe de la zone. If set to `0`, the height will be calculated automatically.                                                                              |
|    Ratio d'aspect |      0     | Le rapport d'aspect fixe de la zone. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Motif](../../background#pattern)
