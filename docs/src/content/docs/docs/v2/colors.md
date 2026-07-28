---
title: Color picker
---

Colors can be selected by using two methods: The color toolbar and the color picker overlay.

To update the color palette, read the [pack documentation](/docs/v2/pack).

For some [surface tools](../add/#surfaces) like the [Pen](../tools/pen/), [Shape](../tools/shape/)
and [Polygon](../tools/polygon) tools, you can further customize the coloring of the tool. This
section will cover the different modes for both the **color** and the **fill** properties with
gradients or images. See [Further customization](#further-customization).

## Color toolbar

![Color toolbar](color_toolbar.png)

If this is enabled in the settings, a color toolbar will be shown when a colorable tool is selected.
This toolbar allows you to quickly select a color from a predefined set of colors. Click on the plus
icon to select a custom color.

## Color picker overlay

![Color picker overlay](color_picker_overlay.png)

This overlay can be opened by clicking on a property tile that is colorable, for example inside the
properties panel of the pen tool. Click on a color to select it. Click on the custom button to open
the custom color picker.

If you want to delete a color from the palette, right click on it (or long press on touch devices)
and select delete.

### Custom color picker

![Custom color picker](color_picker.png)

Here you can select any color you want. On the left you can see a color wheel. Under it you can
select the brightness of the color.
Note: if you choose a darker color on the bottom, the wheel selection gets less precise.

Under the brightness slider you can see a preview of the selected color. You can also enter a hex
code to select a color. It is specified as `#RRGGBB`, where `RR` is the red value, `GG` is the green
value, and `BB` is the blue value in hexadecimal notation.

On the right you can see the red, green and blue values that make up the color. These values can be
changed by dragging the sliders or by entering a value between 0 and 255. Pin the color to add it to
the color palette.

You can use the buttons above to toggle between RGB, HSV, and HSL views.

Clicking the Eye dropper button adds the [Eye dropper tool](../tools/eye_dropper) as
a [temporary tool](../tools#temporary-tools).

---

## Further customization

## Solid Color

Normal Strokes

| Property |       Default       | Description                                                     |
|---------:|:-------------------:|:----------------------------------------------------------------|
|    Color | Black / Transparent | The color of the property                                       |
|    Alpha |       255 / 0       | The opacity of the color                                        |
|     Blur |          0          | How much the color transition to the background will be blurred |

## Image, SVG

Draw the imported image with your strokes. For no filter use white and alpha value at 255.  

| Property | Default | Description                                                     |
|---------:|:-------:|:----------------------------------------------------------------|
|     Tint |  Black  | The color filter.                                               |
|    Alpha | 255 / 0 | The opacity of the color. How transparent the image should be   |
|     Blur |    0    | How much the color transition to the background will be blurred |

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
|   Focal Point | off (same as center) | Where the 0% offset position is placed. If it's not same as center then an ellipse instead of a circle will form.                                 |
|  Focal radius |          0           | Radius of the inner circle where the offset is at 0%. Behind it the offset increases.                                                             |
|   Color stops |    2 Color stops     | The offset of a Color stop percentually defines where between focal point and the boundary the color is placed. There are color and alpha options |
