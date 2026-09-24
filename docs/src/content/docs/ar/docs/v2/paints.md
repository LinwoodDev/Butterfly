---
title: Paints
---

Paint controls how a stroke or fill appears. The [Pen](../tools/pen/), [Shape](../tools/shape/), and [Polygon](../tools/polygon/) tools offer paint settings for their stroke and, where applicable, their fill. Open the tool's properties and choose Solid color, Gradient, Image, or SVG in the paint control.

## Solid color {#solid-color}

Use one color throughout the stroke or fill. Select it with the [color picker](../colors/). A transparent solid color is the initial fill for tools that can enclose an area.

| الممتلكات | الافتراضي                                | الوصف                                                                                                   |
| --------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| اللون     | Black for strokes; transparent for fills | Color of the painted region.                                                            |
| الشفافية  | 255 for strokes; 0 for fills             | Opacity from transparent (`0`) to opaque (`255`). |
| تمويه     | 0                                        | Softens the edge of the painted region.                                                 |

## متدرج

Blend between color stops using a linear or radial layout. When you switch an existing paint to a gradient, its first stop uses the current color and alpha. The overall **Alpha** slider changes the alpha of every stop; you can also edit stops individually.

| الممتلكات    | الافتراضي                                                             | الوصف                                                                                                                           |
| ------------ | --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| نقاط الألوان | Black at `0`; white at `1`                                            | Each stop has an offset, color, and alpha value. The offset determines where the color appears. |
| الشفافية     | 255 for a new opaque stroke; 0 when converted from a transparent fill | Changes the opacity of all stops, from `0` to `255`.                                                            |
| تمويه        | `0`                                                                   | Softens the painted edge.                                                                                       |

### Linear gradient

The start and end positions define the gradient axis. Coordinates are relative to the painted element: `(0, 0)` is its top left and `(1, 1)` its bottom right.

| الممتلكات | الافتراضي | الوصف                                       |
| --------- | --------- | ------------------------------------------- |
| ابدأ      | `(0, 0)`  | Start of the gradient axis. |
| نهاية     | `(1, 0)`  | End of the gradient axis.   |

### Radial gradient

A radial gradient spreads from an inner point toward an outer circle. Positions are relative to the painted element; radii are relative to half the diagonal of its bounds.

| الممتلكات        | الافتراضي            | الوصف                                                                         |
| ---------------- | -------------------- | ----------------------------------------------------------------------------- |
| الوسط            | `(0.5, 0.5)`         | Center of the outer circle, relative to the element bounds.   |
| نصف القطر        | `0.5`                | Radius of the outer circle.                                   |
| نقطة التركيز     | Off; uses the center | Enable to move the inner starting point away from the center. |
| نصف القطر البؤري | `0`                  | Radius of the inner circle when the focal point is enabled.   |

## Image and SVG paint

Use an imported raster image or SVG as the paint source. Select **Image** or **SVG**, then use **Import** in the paint controls to choose a file. The source is stored with the document.

| الممتلكات | الافتراضي | الوصف                                                                                          |
| --------- | --------- | ---------------------------------------------------------------------------------------------- |
| المصدر    | لا شَيْء  | Image or SVG to use in the painted region.                                     |
| تلوين     | White     | Color filter. White at full alpha preserves the source colors. |
| الشفافية  | 255       | Opacity of the tinted source, from `0` to `255`.                               |
| مقاس      | `0.25`    | Size of the source pattern in the painted region.                              |
| تمويه     | `0`       | Softens the painted edge.                                                      |

To place an image or SVG as a separate canvas element, see [Importing](../importing/). To cover a rectangular area with a ruled or dotted pattern, use the [Texture tool](../tools/texture/). Page-wide patterns are configured under [Background](../background/).
