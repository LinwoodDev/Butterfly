---
title: Tekstur
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Configuration

|             Property | Default | Deskripsi                                                                                                                                                                                           |
| -------------------: | :-----: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Bergantung pada zoom |  false  | This will change the stroke width based on the zoom level.                                                                                                                          |
|              Tekstur |   Pola  | The pattern that should be added.                                                                                                                                                   |
|                Lebar |    0    | The fixed width of the area. If set to `0`, the width will be calculated automatically.                                                                             |
|               Tinggi |    0    | The fixed height of the area. If set to `0`, the height will be calculated automatically.                                                                           |
|          Rasio aspek |    0    | The fixed aspect ratio of the area. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
