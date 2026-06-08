---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|               Property |    Default    | Mô tả                                                                                                                                                                                             |
| ---------------------: | :-----------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                Màu sắc |     Black     | The stroke color that will be drawn                                                                                                                                                               |
|             Độ dày nét |       5       | The width of the stroke                                                                                                                                                                           |
|              Kiểu gạch |      Khối     | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|  Độ dài dấu gạch ngang |       1       | The length of the dash when using a non-solid stroke style                                                                                                                                        |
| Chiều dài khoảng trống |       1       | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|    Phụ thuộc thu phóng |     false     | This will change the stroke width based on the zoom level.                                                                                                                        |
|              Hình dạng | Hình chữ nhật | The shape that will be drawn                                                                                                                                                                      |
|             Chiều rộng |       0       | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|              Chiều cao |       0       | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|       Tỷ lệ khung hình |       0       | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|                   Giữa |     false     | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### Hình chữ nhật

|     Property |   Default   | Mô tả                                             |
| -----------: | :---------: | :------------------------------------------------ |
|           Tô | Transparent | The color that will be drawn inside the rectangle |
| Bán kính góc |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### Hình tam giác

| Property |   Default   | Mô tả                                            |
| -------: | :---------: | :----------------------------------------------- |
|       Tô | Transparent | The color that will be drawn inside the triangle |

#### Hình tròn

| Property |   Default   | Mô tả                                          |
| -------: | :---------: | :--------------------------------------------- |
|       Tô | Transparent | The color that will be drawn inside the circle |

#### Đường thẳng

_No configuration available._
