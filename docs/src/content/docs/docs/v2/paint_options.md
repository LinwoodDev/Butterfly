---
title: Paint Options
---

For some [surface tools](../add/#surfaces) like the [Pen](../tools/pen/), [Shape](../tools/shape/)
and [Polygon](../tools/polygon) tools, you can configure how the paint of the tool behaves. This
section will cover the different Paint modes for both the **color** and the **fill** properties.

## Solid Color

Normal Strokes

| Property |       Default       | Description                                                     |
|---------:|:-------------------:|:----------------------------------------------------------------|
|    Color | Black / Transparent | The color of the property                                       |
|    Alpha |       255 / 0       | The opacity of the color                                        |
|     Blur |          0          | How much the color transition to the background will be blurred |

## Image, SVG

Draw the imported image with your strokes

| Property | Default | Description                                                             |
|---------:|:-------:|:------------------------------------------------------------------------|
|     Tint |  Black  | The color filter; Black makes the image invisible, White uses no filter |
|    Alpha | 255 / 0 | The opacity of the color                                                |
|     Blur |    0    | How much the color transition to the background will be blurred         |

## Gradient

Make your strokes transition between colors

### Linear Gradient

|    Property |    Default    | Description                                                                                                                        |
|------------:|:-------------:|:-----------------------------------------------------------------------------------------------------------------------------------|
|       Start |     (0,0)     | Starting position of the linear-gradient axis; percentually relative to the top left corner                                        |
|         End |     (1,0)     | End position of the linear-gradient axis; percentually relative to the top left corner                                             |
| Color stops | 2 Color stops | The offset of a Color stop percentually defines where along the gradient axis a color is placed. There are color and alpha options |

### Radial Gradient

|      Property |       Default        | Description                                                                                                                                       |
|--------------:|:--------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------|
|        Center |      (0.5,0.5)       | Geometric middle of the boundary circle at 100% offset; percentually relative to the top left corner                                              |
| Center radius |         0.5          | Radius of the boundary circle; percentually relative to the top left corner                                                                       |
|   Focal Point | off (same as center) | Where the 0% offset position is placed. If it's not same as center then a ellipse instead of a circle will form.                                  |
|  Focal radius |          0           | Radius of the inner circle where the offset is at 0%. Behind it the offset increases.                                                             |
|   Color stops |    2 Color stops     | The offset of a Color stop percentually defines where between focal point and the boundary the color is placed. There are color and alpha options |


