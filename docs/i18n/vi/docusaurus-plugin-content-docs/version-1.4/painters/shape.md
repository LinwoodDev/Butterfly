---
title: "Shape painter"
sidebar_label: "Shape"
sidebar_position: 3
---


Use this painter to draw shapes on the paper. You can draw rectangles, circles, and other shapes.

## Configuration

|       Property |  Default  | Mô tả                                                                                                                                            |
| --------------:|:---------:|:------------------------------------------------------------------------------------------------------------------------------------------------ |
|        Màu sắc |   Black   | The color that will be drawn                                                                                                                     |
|     Độ dày nét |     5     | The width of the stroke                                                                                                                          |
| Zoom dependent |   false   | This will change the stroke width based on the zoom level.                                                                                       |
|          Shape | rectangle | The shape that will be drawn                                                                                                                     |
|     Chiều rộng |     0     | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                            |
|      Chiều cao |     0     | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                          |
|   Aspect ratio |     0     | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. A aspect ratio is defined as width / height. |

### Shape types

#### Rectangle

|      Property |   Default   | Mô tả                                             |
| -------------:|:-----------:|:------------------------------------------------- |
|          Fill | Transparent | The color that will be drawn inside the rectangle |
| Corner radius | 0, 0, 0, 0  | The radius of the corners of the rectangle        |

#### Circle

| Property |   Default   | Mô tả                                             |
| --------:|:-----------:|:------------------------------------------------- |
|     Fill | Transparent | The color that will be drawn inside the rectangle |

#### Line

*No configuration available.*
