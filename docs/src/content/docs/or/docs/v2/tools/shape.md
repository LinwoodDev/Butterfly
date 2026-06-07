---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, triangles, circles, lines, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|     Property | Default | ବିବରଣୀ                                                                                                                                                                                            |
| -----------: | :-----: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
|         ରଙ୍ଗ |  Black  | The stroke color that will be drawn                                                                                                                                                               |
| ଲାଇନ୍ ପ୍ରସ୍ଥ |    5    | The width of the stroke                                                                                                                                                                           |
| Stroke style |   ଦୃଢ   | The style of the stroke. Other styles can use dash and gap lengths.                                                                                               |
|  Dash length |    1    | The length of the dash when using a non-solid stroke style                                                                                                                                        |
|   Gap length |    1    | The length of the gap when using a non-solid stroke style                                                                                                                                         |
|  ଜୁମ୍ ନିର୍ଭର |  false  | This will change the stroke width based on the zoom level.                                                                                                                        |
|        ଆକୃତି |   ଆୟତ   | The shape that will be drawn                                                                                                                                                                      |
|       ପ୍ରସ୍ଥ |    0    | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                             |
|       ଉଚ୍ଚତା |    0    | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                           |
|   ପ୍ରମାଣୁପାତ |    0    | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. An aspect ratio is defined as width / height. |
|         ମଧ୍ୟ |  false  | Draws the shape from the center instead of from the corner.                                                                                                                       |

### Shape types

#### ଆୟତ

|     Property |   Default   | ବିବରଣୀ                                            |
| -----------: | :---------: | :------------------------------------------------ |
|         ପୂରଣ | Transparent | The color that will be drawn inside the rectangle |
| କୋନ୍ ରୌଦ୍ରତା |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### ତିଭୁଜ

| Property |   Default   | ବିବରଣୀ                                           |
| -------: | :---------: | :----------------------------------------------- |
|     ପୂରଣ | Transparent | The color that will be drawn inside the triangle |

#### ବୃତ୍ତ

| Property |   Default   | ବିବରଣୀ                                         |
| -------: | :---------: | :--------------------------------------------- |
|     ପୂରଣ | Transparent | The color that will be drawn inside the circle |

#### ରେଖା

_No configuration available._
