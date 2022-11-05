---
title: "Shape painter"
sidebar_label: "รูปร่าง"
sidebar_position: 3
---


Use this painter to draw shapes on the paper. You can draw rectangles, circles, and other shapes.

## Configuration

|            Property |  Default  | คำอธิบาย                                                                                                                                         |
| -------------------:|:---------:|:------------------------------------------------------------------------------------------------------------------------------------------------ |
|                  สี |   Black   | The color that will be drawn                                                                                                                     |
| ความกว้างของเส้นขีด |     5     | The width of the stroke                                                                                                                          |
|      Zoom dependent |  ไม่จริง  | This will change the stroke width based on the zoom level.                                                                                       |
|             รูปร่าง | rectangle | The shape that will be drawn                                                                                                                     |
|           ความกว้าง |     0     | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                            |
|             ความสูง |     0     | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                          |
|        Aspect ratio |     0     | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. A aspect ratio is defined as width / height. |

### Shape types

#### สี่เหลี่ยม

|      Property |   Default   | คำอธิบาย                                          |
| -------------:|:-----------:|:------------------------------------------------- |
|          เติม | Transparent | The color that will be drawn inside the rectangle |
| Corner radius | 0, 0, 0, 0  | The radius of the corners of the rectangle        |

#### วงกลม

| Property |   Default   | คำอธิบาย                                          |
| --------:|:-----------:|:------------------------------------------------- |
|     เติม | Transparent | The color that will be drawn inside the rectangle |

#### เส้น

*No configuration available.*
