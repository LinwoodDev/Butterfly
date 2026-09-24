---
title: Textur
---

The texture tool allows you to add a background texture to a small area of the canvas.
Use it when only a part of the canvas should have a background pattern. To change the background of
the whole page, use the [background settings](../../background) instead.

## Verwendung

1. Select the texture tool.
2. Choose the texture in the tool configuration.
3. Drag on the canvas to create the textured area.

The created texture behaves like a surface element. You can move, resize, arrange, or delete it like
other elements.

## Konfiguration

| Objekt                     | Standard          | Beschreibung                                                                      |
| -------------------------- | ----------------- | --------------------------------------------------------------------------------- |
| Texture preset             | Blank pattern     | Choose a built-in light or dark pattern, then customize it.       |
| Background color and alpha | White, 255        | Color and opacity behind the pattern lines.                       |
| Vertical lines             | Width 0, count 1  | Adjust line color, alpha, spacing, group count, and stroke width. |
| Horizontal lines           | Height 0, count 1 | Adjust line color, alpha, spacing, group count, and stroke width. |

These are the same pattern controls used for a [page background](../../background/#pattern-layers). The Texture tool creates a separate canvas element; [paint](../../paints/) controls strokes and fills on drawing tools.
