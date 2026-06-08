---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## 設定

|         属性 | デフォルト | 説明                                                                                                     |
| ---------: | :---: | :----------------------------------------------------------------------------------------------------- |
|          色 |  ブラック | The stroke color that will be drawn                                                                    |
|    ストロークの幅 |   5   | ストロークの幅                                                                                                |
| ストロークのスタイル | Solid | The style of the stroke. Other styles can use dash and gap lengths.    |
|    ダッシュの長さ |   1   | The length of the dash when using a non-solid stroke style                                             |
|    ギャップの長さ |   1   | The length of the gap when using a non-solid stroke style                                              |
|   ズームに依存する | false | これにより、ズームレベルに基づいてストローク幅が変更されます。                                                                        |
|         形状 |   矩形  | 描画される形状                                                                                                |
|      Width |   0   | 領域の固定幅。 0に設定すると、幅が自動的に計算されます。                                                                          |
|         高さ |   0   | 領域の固定高さ。 0に設定すると、高さが自動的に計算されます。                                                                        |
|     アスペクト比 |   0   | 領域の固定アスペクト比。 0 に設定すると、アスペクト比は自動的に計算されます。 An aspect ratio is defined as width / height. |
|       中央揃え | false | Draws the shape from the center instead of from the corner.                            |

### シェイプの種類

#### 矩形

|            属性 |    デフォルト   | 説明           |
| ------------: | :--------: | :----------- |
|         塗りつぶし |     透明度    | 四角形の中に描画される色 |
| Corner radius | 0, 0, 0, 0 | 長方形の角の半径     |

#### Triangle

|    属性 | デフォルト | 説明                                               |
| ----: | :---: | :----------------------------------------------- |
| 塗りつぶし |  透明度  | The color that will be drawn inside the triangle |

#### 円

|    属性 | デフォルト | 説明                                             |
| ----: | :---: | :--------------------------------------------- |
| 塗りつぶし |  透明度  | The color that will be drawn inside the circle |

#### 線

_No configuration available._
