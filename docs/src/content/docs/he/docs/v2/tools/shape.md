---
title: Shape tool
---

Use this tool to draw shapes on the paper.
You can draw rectangles, circles, and other shapes.

Use `ctrl` to have the same height and width and `shift` to draw from the center.

## Configuration

|      Property |  Default  | תיאור                                                                                                                                                                                            |
| ------------: | :-------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|         Color |   Black   | The color that will be drawn                                                                                                                                                                     |
|       עובי קו |     5     | The width of the stroke                                                                                                                                                                          |
|      תלוי זום |   false   | This will change the stroke width based on the zoom level.                                                                                                                       |
|          צורה | rectangle | The shape that will be drawn                                                                                                                                                                     |
|          רוחב |     0     | The fixed width of the area. If set to 0, the width will be calculated automatically.                                                                            |
|          גובה |     0     | The fixed height of the area. If set to 0, the height will be calculated automatically.                                                                          |
| יחס גובה-רוחב |     0     | The fixed aspect ratio of the area. If set to 0, the aspect ratio will be calculated automatically. A aspect ratio is defined as width / height. |

### Shape types

#### מלבן

|   Property |   Default   | תיאור                                             |
| ---------: | :---------: | :------------------------------------------------ |
|      מילוי | Transparent | The color that will be drawn inside the rectangle |
| רדיוס פינה |  0, 0, 0, 0 | The radius of the corners of the rectangle        |

#### עיגול

| Property |   Default   | תיאור                                             |
| -------: | :---------: | :------------------------------------------------ |
|    מילוי | Transparent | The color that will be drawn inside the rectangle |

#### קו

_No configuration available._
