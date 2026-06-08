---
title: Texture
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Configurazione

|             Proprietà | Predefinito | Descrizione                                                                                                                                                                                             |
| --------------------: | :---------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Dipendente dallo zoom |    falso    | Questo cambierà la larghezza del tratto in base al livello di zoom.                                                                                                                     |
|               Texture |   Sequenza  | The pattern that should be added.                                                                                                                                                       |
|             Larghezza |      0      | La larghezza fissa dell'area. If set to `0`, the width will be calculated automatically.                                                                                |
|               Altezza |      0      | L'altezza fissa dell'area. If set to `0`, the height will be calculated automatically.                                                                                  |
|   Rapporto dimensioni |      0      | Il rapporto di aspetto fisso dell'area. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
