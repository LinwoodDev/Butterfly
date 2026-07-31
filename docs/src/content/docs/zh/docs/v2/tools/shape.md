---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## 配置

|   属性 |                     默认设置                     | 描述                                                                                                                                       |
| ---: | :------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------- |
|   居中 |                     false                    | Draws the shape from the center instead of from the corner.                                                              |
|   宽度 |                       0                      | 区域的固定宽度。 如果设置为 0，宽度将自动计算。                                                                                                                |
|   高度 |                       0                      | 区域的固定高度 区域的固定高度 如果设置为 0，高度将自动计算。                                                                                                         |
|  纵横比 |                       0                      | 区域的固定宽高比。 如果设置为 0，宽高比将自动计算。 An aspect ratio is defined as width / height.                                                |
| 笔画宽度 |                       5                      | 笔画的宽度                                                                                                                                    |
| 笔画样式 |                      实线                      | The style of the stroke. Other styles can use dash and gap lengths.                                      |
| 虚线长度 |                       1                      | The length of the dash when using a non-solid stroke style                                                                               |
| 间距长度 |                       1                      | The length of the gap when using a non-solid stroke style                                                                                |
|   颜色 |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                          |
|   形状 |                      矩形                      | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                  |
| 圆角半径 |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                        |
|   填充 | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes |
| 依靠缩放 |                     false                    | 这将改变基于缩放级别的笔画宽度。                                                                                                                         |