---
title: Textilie
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Konfigurace

|            Majetek |  Výchozí | L 343, 22.12.2009, s. 1).                                                                                                 |
| -----------------: | :------: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Přiblížení závislé | nepravda | To změní šířku tahu v závislosti na úrovni přiblížení.                                                                                                                    |
|           Textilie |   Vzor   | The pattern that should be added.                                                                                                                                         |
|              Šířka |     0    | Pevná šířka plochy. If set to `0`, the width will be calculated automatically.                                                                            |
|              Výška |     0    | Pevná výška plochy. If set to `0`, the height will be calculated automatically.                                                                           |
|        Poměr stran |     0    | Pevný poměr stran plochy. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
