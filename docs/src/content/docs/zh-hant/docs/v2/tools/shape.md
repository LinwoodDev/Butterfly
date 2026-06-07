---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|     Property | Default | 說明                                                                                                                                                                                                |
| -----------: | :-----: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|           顏色 |  Black  | The stroke color that will be drawn                                                                                                                                                               |
|         筆劃寬度 |    5    | The width of the stroke                                                                                                                                                                           |
| Stroke style |    實線   | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|  Dash length |    1    | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|   Gap length |    1    | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|         隨應縮放 |  false  | This will change the stroke width based on the zoom level.                                                                                                                        |
|           形狀 |    矩形   | The shape that will be drawn                                                                                                                                                                      |
|           寬度 |    0    | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|           高度 |    0    | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|          長寬比 |    0    | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|            中 |  false  | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### 矩形

| Property |   Default   | 說明                                                |
| -------: | :---------: | :------------------------------------------------ |
|       填滿 | Transparent | The color that will be drawn inside the rectangle |
|     圓角大小 |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### 三角形

| Property |   Default   | 說明                                               |
| -------: | :---------: | :----------------------------------------------- |
|       填滿 | Transparent | The color that will be drawn inside the triangle |

#### 圓形

| Property |   Default   | 說明                                             |
| -------: | :---------: | :--------------------------------------------- |
|       填滿 | Transparent | The color that will be drawn inside the circle |

#### 直線

_No configuration available._
