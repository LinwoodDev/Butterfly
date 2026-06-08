---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|            Property |   Default  | คำอธิบาย                                                                                                                                                                                          |
| ------------------: | :--------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|                  สี |    Black   | The stroke color that will be drawn                                                                                                                                                               |
| ความกว้างของเส้นขีด |      5     | The width of the stroke                                                                                                                                                                           |
|        Stroke style |     ทึบ    | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|         Dash length |      1     | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|          Gap length |      1     | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|   ขึ้นอยู่กับการซูม |   ไม่จริง  | This will change the stroke width based on the zoom level.                                                                                                                        |
|             รูปร่าง | สี่เหลี่ยม | The shape that will be drawn                                                                                                                                                                      |
|           ความกว้าง |      0     | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|             ความสูง |      0     | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|           อัตราส่วน |      0     | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|            กึ่งกลาง |   ไม่จริง  | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### สี่เหลี่ยมผืนผ้า

| Property |   Default   | คำอธิบาย                                          |
| -------: | :---------: | :------------------------------------------------ |
|     เติม | Transparent | The color that will be drawn inside the rectangle |
| รัศมีมุม |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### สามเหลี่ยม

| Property |   Default   | คำอธิบาย                                         |
| -------: | :---------: | :----------------------------------------------- |
|     เติม | Transparent | The color that will be drawn inside the triangle |

#### วงกลม

| Property |   Default   | คำอธิบาย                                       |
| -------: | :---------: | :--------------------------------------------- |
|     เติม | Transparent | The color that will be drawn inside the circle |

#### เส้น

_No configuration available._
