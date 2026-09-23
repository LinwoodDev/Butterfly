---
title: Paints
---

Paint controls how a stroke or fill appears. The Pen, Shape, and Polygon tools offer paint settings for their stroke and, where applicable, their fill. Open the tool's properties and choose the paint type above its color controls.

| Paint type  | What it does                                                            | Main settings                                                      |
| ----------- | ----------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Solid color | Uses one color throughout the stroke or fill.           | Color, alpha, blur.                                |
| Gradient    | Blends between color stops.                             | Linear or radial layout, color stops, alpha, blur. |
| ଛବି         | Repeats an imported raster image in the painted region. | Source image, tint, alpha, scale, blur.            |
| SVG         | Uses an imported SVG as the paint source.               | Source SVG, tint, alpha, scale, blur.              |

## Solid color

Choose a color using the [color picker](../colors/). **Alpha** controls opacity from transparent (`0`) to opaque (`255`). **Blur** softens the edge of the painted region. A transparent solid color is the default fill for tools that can enclose an area.

## Gradient

Select **Linear** for a transition along a line, or **Radial** for one that spreads outward from a center. Add and adjust color stops to control where each color appears. Linear gradients have start and end positions. Radial gradients have a center and radius, with optional focal point and focal radius controls. Stop colors can each have their own alpha.

## Image and SVG paint

Choose **Image** or **SVG**, then use **Import** in the paint controls to select the source file. **Tint** colors the source; white with full alpha leaves its colors unchanged. **Scale** changes the source pattern's size, and **Blur** softens it. The source is stored with the document, so a shared Butterfly note can keep using the paint.

These are paint sources for strokes and fills. To place an image or SVG as a separate canvas element, use [Importing](../importing/). To cover a rectangular part of the canvas with a ruled or dotted pattern, use the [Texture tool](../tools/texture/). Page-wide patterns are configured under [Background](../background/).
