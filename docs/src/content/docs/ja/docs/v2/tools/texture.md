---
title: テクスチャ
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of the whole page, use the [background settings](../../background) instead.

## Usage

1. Select the texture tool.
2. Choose the texture and its constraints in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like other elements.

## 設定

|       属性 | デフォルト | 説明                                                                                                                                                           |
| -------: | :---: | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ズームに依存する | false | これにより、ズームレベルに基づいてストローク幅が変更されます。                                                                                                                              |
|    テクスチャ |  パターン | The pattern that should be added.                                                                                                            |
|    Width |   0   | 領域の固定幅。 If set to `0`, the width will be calculated automatically.                                                                           |
|       高さ |   0   | 領域の固定高さ。 If set to `0`, the height will be calculated automatically.                                                                         |
|   アスペクト比 |   0   | 領域の固定アスペクト比。 If set to `0`, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |

Valid types for texture are:

- [Pattern](../../background#pattern)
