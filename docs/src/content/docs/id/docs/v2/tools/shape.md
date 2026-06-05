---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|             Property |     Default     | Deskripsi                                                                                                                                                                                         |
| -------------------: | :-------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                Color |      Black      | The stroke color that will be drawn                                                                                                                                                               |
|        Lebar goresan |        5        | The width of the stroke                                                                                                                                                                           |
|         Gaya goresan |      Padat      | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|  Panjang garis putus |        1        | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|        Panjang celah |        1        | The length of the gap when using a non-solid stroke style                                                                                                                                         |
| Bergantung pada zoom |      false      | This will change the stroke width based on the zoom level.                                                                                                                        |
|               Bentuk | Persegi panjang | The shape that will be drawn                                                                                                                                                                      |
|                Lebar |        0        | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|               Tinggi |        0        | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|          Rasio aspek |        0        | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|               Tengah |      false      | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### Persegi panjang

|     Property |   Default   | Deskripsi                                         |
| -----------: | :---------: | :------------------------------------------------ |
|          Isi | Transparent | The color that will be drawn inside the rectangle |
| Radius sudut |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### Segitiga

| Property |   Default   | Deskripsi                                        |
| -------: | :---------: | :----------------------------------------------- |
|      Isi | Transparent | The color that will be drawn inside the triangle |

#### Lingkaran

| Property |   Default   | Deskripsi                                      |
| -------: | :---------: | :--------------------------------------------- |
|      Isi | Transparent | The color that will be drawn inside the circle |

#### Garis

_No configuration available._
