---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|     Property | Default | 설명                                                                                                                                                                                                |
| -----------: | :-----: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|        Color |  Black  | The stroke color that will be drawn                                                                                                                                                               |
|         선 굵기 |    5    | The width of the stroke                                                                                                                                                                           |
| Stroke style |    실선   | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|  Dash length |    1    | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|   Gap length |    1    | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|    확대/축소에 따라 |  false  | This will change the stroke width based on the zoom level.                                                                                                                        |
|           도형 |   사각형   | The shape that will be drawn                                                                                                                                                                      |
|           너비 |    0    | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|           높이 |    0    | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|          종횡비 |    0    | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|          가운데 |  false  | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### 사각형

| Property |   Default   | 설명                                                |
| -------: | :---------: | :------------------------------------------------ |
|      채우기 | Transparent | The color that will be drawn inside the rectangle |
|  모서리 반지름 |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### 삼각형

| Property |   Default   | 설명                                               |
| -------: | :---------: | :----------------------------------------------- |
|      채우기 | Transparent | The color that will be drawn inside the triangle |

#### 원

| Property |   Default   | 설명                                             |
| -------: | :---------: | :--------------------------------------------- |
|      채우기 | Transparent | The color that will be drawn inside the circle |

#### 선

_No configuration available._
