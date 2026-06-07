---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|          Property | Default | विवरण                                                                                                                                                                                             |
| ----------------: | :-----: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|             Color |  Black  | The stroke color that will be drawn                                                                                                                                                               |
| स्ट्रोक की चौड़ाई |    5    | The width of the stroke                                                                                                                                                                           |
|      Stroke style |   ठोस   | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|       Dash length |    1    | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|        Gap length |    1    | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|    ज़ूम पर निर्भर |  false  | This will change the stroke width based on the zoom level.                                                                                                                        |
|             आकृति |   आयत   | The shape that will be drawn                                                                                                                                                                      |
|            चौड़ाई |    0    | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|             ऊंचाई |    0    | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|       पहलू अनुपात |    0    | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|            केंद्र |  false  | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### आयत

|         Property |   Default   | विवरण                                             |
| ---------------: | :---------: | :------------------------------------------------ |
|             भरें | Transparent | The color that will be drawn inside the rectangle |
| कोने की त्रिज्या |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### त्रिकोण

| Property |   Default   | विवरण                                            |
| -------: | :---------: | :----------------------------------------------- |
|     भरें | Transparent | The color that will be drawn inside the triangle |

#### वृत्त

| Property |   Default   | विवरण                                          |
| -------: | :---------: | :--------------------------------------------- |
|     भरें | Transparent | The color that will be drawn inside the circle |

#### रेखा

_No configuration available._
