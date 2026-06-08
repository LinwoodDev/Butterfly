---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|       Property |  Default  | Description                                                                                                                                      |
| -------------: | :-------: | :----------------------------------------------------------------------------------------------------------------------------------------------- |
|          Color |   Black   | The stroke color that will be drawn                                                                                                              |
|   Stroke width |     5     | The width of the stroke                                                                                                                          |
|   Stroke style |   Solid   | The style of the stroke. Other styles can use dash and gap lengths.                                                                              |
|    Dash length |     1     | The length of the dash when using a non-solid stroke style                                                                                       |
|     Gap length |     1     | The length of the gap when using a non-solid stroke style                                                                                        |
| Zoom dependent |   false   | This will change the stroke width based on the zoom level.                                                                                       |
|          Shape | Rectangle | The shape that will be drawn                                                                                                                     |
|          Width |     0     | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                            |
|         Height |     0     | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                          |
|   Aspect ratio |     0     | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|         Center |   false   | Draws the shape from the center instead of from the corner.                                                                                      |

### Shape types

#### Rectangle

|      Property |   Default   | Description                                       |
| ------------: | :---------: | :------------------------------------------------ |
|          Fill | Transparent | The color that will be drawn inside the rectangle |
| Corner radius | 0, 0, 0, 0  | The radius of the corners of the rectangle        |

#### Triangle

|   Property |   Default   | Description                                      |
| ---------: | :---------: | :----------------------------------------------- |
|       Fill | Transparent | The color that will be drawn inside the triangle |

#### Circle

|   Property |   Default   | Description                                    |
| ---------: | :---------: | :--------------------------------------------- |
|       Fill | Transparent | The color that will be drawn inside the circle |

#### Line

*No configuration available.*
