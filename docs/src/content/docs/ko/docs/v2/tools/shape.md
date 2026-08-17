---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|     Property |                    Default                   | 설명                                                                                                                                                                                                |
| -----------: | :------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|          가운데 |                     false                    | Draws the shape from the center instead of from the corner.                                                                                                                       |
|           너비 |                       0                      | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|           높이 |                       0                      | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|          종횡비 |                       0                      | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|         선 굵기 |                       5                      | The width of the stroke                                                                                                                                                                           |
| Stroke style |                      실선                      | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|  Dash length |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|   Gap length |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|        Color |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                   |
|           도형 |                      사각형                     | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                           |
|      모서리 반지름 |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                 |
|          채우기 | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                          |
|    확대/축소에 따라 |                     false                    | This will change the stroke width based on the zoom level.                                                                                                                        |