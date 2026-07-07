---
title: Textur
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Konfiguration

|        Egenskap | Standard | Beskrivning                                                                                                                                                                                            |
| --------------: | :------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  Zooma beroende |  falskt  | Detta kommer att ändra slagbredden baserat på zoomnivån.                                                                                                                               |
|          Textur |  Mönster | The pattern that should be added.                                                                                                                                                      |
|           Width |     0    | Den fasta bredden på området. If set to `0`, the width will be calculated automatically.                                                                               |
|            Höjd |     0    | Den fasta höjden på området. If set to `0`, the height will be calculated automatically.                                                                               |
| Bildförhållande |     0    | Det fasta bildförhållandet av området. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
