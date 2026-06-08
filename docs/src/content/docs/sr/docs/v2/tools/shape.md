---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|              Property |    Default   | Opis                                                                                                                                                                                              |
| --------------------: | :----------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                 Color |     Black    | The stroke color that will be drawn                                                                                                                                                               |
|       Debljina linije |       5      | The width of the stroke                                                                                                                                                                           |
|          Stroke style |     Puna     | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|           Dash length |       1      | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|            Gap length |       1      | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|       Zavisno od zuma |     false    | This will change the stroke width based on the zoom level.                                                                                                                        |
|                 Oblik | Pravougaonik | The shape that will be drawn                                                                                                                                                                      |
|                Širina |       0      | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|                Visina |       0      | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
| Odnos širine i visine |       0      | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|                Centar |     false    | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### Pravougaonik

|     Property |   Default   | Opis                                              |
| -----------: | :---------: | :------------------------------------------------ |
|       Popuna | Transparent | The color that will be drawn inside the rectangle |
| Radijus ugla |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### Trougao

| Property |   Default   | Opis                                             |
| -------: | :---------: | :----------------------------------------------- |
|   Popuna | Transparent | The color that will be drawn inside the triangle |

#### Krug

| Property |   Default   | Opis                                           |
| -------: | :---------: | :--------------------------------------------- |
|   Popuna | Transparent | The color that will be drawn inside the circle |

#### Linija

_No configuration available._
