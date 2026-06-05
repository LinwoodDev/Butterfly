---
title: Laser tool
---

With this tool you can draw on this paper temporarily. しばらくすると、絵は薄れていきます。
Add a new drawing to the paper to cancel the previous laser stroke.

## 設定

|      属性 |        デフォルト        | 説明                                                                                                                    |
| ------: | :-----------------: | :-------------------------------------------------------------------------------------------------------------------- |
|       色 |          赤          | The color that will be drawn.                                                                         |
| ストロークの幅 |          5          | The width of the stroke.                                                                              |
|     薄肉化 | 0.4 | The effect of pressure on the stroke size. Set it to `0` for a constant stroke width. |
|      期間 |          5          | The duration in seconds that the drawing will stay visible.                                           |
|   期間を隠す | 0.5 | How long the laser stroke takes to disappear.                                                         |
| アニメーション |         Fade        | The animation used when the laser stroke disappears.                                                  |

## Animation modes

| Mode | 説明                                                                  |
| ---: | :------------------------------------------------------------------ |
| Fade | The stroke fades out after the duration has passed. |
|   パス | The stroke disappears along the drawn path.         |
