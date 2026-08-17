---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|            Property |                    Default                   | คำอธิบาย                                                                                                                                                                                          |
| ------------------: | :------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|            กึ่งกลาง |                    ไม่จริง                   | Draws the shape from the center instead of from the corner.                                                                                                                       |
|           ความกว้าง |                       0                      | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|             ความสูง |                       0                      | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|           อัตราส่วน |                       0                      | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
| ความกว้างของเส้นขีด |                       5                      | The width of the stroke                                                                                                                                                                           |
|        Stroke style |                      ทึบ                     | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|         Dash length |                       1                      | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|          Gap length |                       1                      | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|                  สี |    Solid Color (Black)    | [Customization](../../colors/#further-customization) for the color of the shape                                                                                                                   |
|             รูปร่าง |                  สี่เหลี่ยม                  | The shape that will be drawn. Available shapes are Rectangle, Triangle, Circle and Line                                                                                           |
|            รัศมีมุม |                  0, 0, 0, 0                  | The radius of the corners when shape is Rectangle                                                                                                                                                 |
|                เติม | Solid Color (Transparent) | [Customization](../../colors/#further-customization) for the color drawn inside the shape. Not available for Line shapes                                                          |
|   ขึ้นอยู่กับการซูม |                    ไม่จริง                   | This will change the stroke width based on the zoom level.                                                                                                                        |