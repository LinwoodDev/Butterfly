---
title: Doku
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## Yapılandırma

|               Özellik | Varsayılan | Tanım                                                                                                                                                                                            |
| --------------------: | :--------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Bağımlı yakınlaştırma |    false   | Bu, yakınlaştırma düzeyine bağlı olarak kontur genişliğini değiştirecektir.                                                                                                      |
|                  Doku |    Desen   | The pattern that should be added.                                                                                                                                                |
|              Genişlik |      0     | Alan genişliğini sabitleme. If set to `0`, the width will be calculated automatically.                                                                           |
|             Yükseklik |      0     | Alan yüksekliğini sabitleme. If set to `0`, the height will be calculated automatically.                                                                         |
|          En boy oranı |      0     | Alanın en boy oranını sabitleme. If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
