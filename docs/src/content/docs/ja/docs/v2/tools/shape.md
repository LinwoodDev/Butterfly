---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## 設定

|            属性 |                     デフォルト                    | 説明                                                                                                                                       |
| ------------: | :------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------- |
|          中央揃え |                     false                    | Draws the shape from the center instead of from the corner.                                                              |
|         Width |                       0                      | 領域の固定幅。 0に設定すると、幅が自動的に計算されます。                                                                                                            |
|            高さ |                       0                      | 領域の固定高さ。 0に設定すると、高さが自動的に計算されます。                                                                                                          |
|        アスペクト比 |                       0                      | 領域の固定アスペクト比。 0 に設定すると、アスペクト比は自動的に計算されます。 An aspect ratio is defined as width / height.                                   |
|       ストロークの幅 |                       5                      | ストロークの幅                                                                                                                                  |
|    ストロークのスタイル |                     Solid                    | The style of the stroke. Other styles can use dash and gap lengths.                                      |
|       ダッシュの長さ |                       1                      | The length of the dash when using a non-solid stroke style                                                                               |
|       ギャップの長さ |                       1                      | The length of the gap when using a non-solid stroke style                                                                                |
|             色 |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                          |
|            形状 |                      矩形                      | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                  |
| Corner radius |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                        |
|         塗りつぶし | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes |
|      ズームに依存する |                     false                    | これにより、ズームレベルに基づいてストローク幅が変更されます。                                                                                                          |