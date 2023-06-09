---
title: "Shape painter"
sidebar_label: "形狀"
sidebar_position: 3
---


Use this painter to draw shapes on the paper. You can draw rectangles, circles, and other shapes.

## Configuration

| Property |  Default  | 說明                                                                                                                                               |
| --------:|:---------:|:------------------------------------------------------------------------------------------------------------------------------------------------ |
|       顏色 |   Black   | The color that will be drawn                                                                                                                     |
|     筆劃寬度 |     5     | The width of the stroke                                                                                                                          |
|     隨應縮放 |   false   | This will change the stroke width based on the zoom level.                                                                                       |
|       形狀 | rectangle | The shape that will be drawn                                                                                                                     |
|       寬度 |     0     | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                            |
|       高度 |     0     | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                          |
|      長寬比 |     0     | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. A aspect ratio is defined as width / height. |

### Shape types

#### 矩形

| Property |   Default   | 說明                                                |
| --------:|:-----------:|:------------------------------------------------- |
|       填滿 | Transparent | The color that will be drawn inside the rectangle |
|     圓角大小 | 0, 0, 0, 0  | The radius of the corners of the rectangle        |

#### 圓形

| Property |   Default   | 說明                                                |
| --------:|:-----------:|:------------------------------------------------- |
|       填滿 | Transparent | The color that will be drawn inside the rectangle |

#### 直線

*No configuration available.*
