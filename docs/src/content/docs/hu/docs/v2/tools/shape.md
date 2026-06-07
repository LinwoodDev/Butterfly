---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|            Property |  Default | Leírás                                                                                                                                                                                            |
| ------------------: | :------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                Szín |   Black  | The stroke color that will be drawn                                                                                                                                                               |
|           Vastagság |     5    | The width of the stroke                                                                                                                                                                           |
|        Stroke style |  Szilárd | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|         Dash length |     1    | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|          Gap length |     1    | The length of the gap when using a non-solid stroke style                                                                                                                                         |
| Függőleges nagyítás |   false  | This will change the stroke width based on the zoom level.                                                                                                                        |
|               Forma | Téglalap | The shape that will be drawn                                                                                                                                                                      |
|           Szélesség |     0    | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|            Magasság |     0    | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|          Oldalarány |     0    | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|               Közép |   false  | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### Téglalap

|     Property |   Default   | Leírás                                            |
| -----------: | :---------: | :------------------------------------------------ |
|     Kitöltés | Transparent | The color that will be drawn inside the rectangle |
| Sarok sugara |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### Háromszög

| Property |   Default   | Leírás                                           |
| -------: | :---------: | :----------------------------------------------- |
| Kitöltés | Transparent | The color that will be drawn inside the triangle |

#### Kör

| Property |   Default   | Leírás                                         |
| -------: | :---------: | :--------------------------------------------- |
| Kitöltés | Transparent | The color that will be drawn inside the circle |

#### Vonal

_No configuration available._
