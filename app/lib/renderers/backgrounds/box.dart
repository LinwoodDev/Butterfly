part of '../renderer.dart';

class TextureBackgroundRenderer extends Renderer<TextureBackground> {
  TextureBackgroundRenderer(super.element);

  SurfaceTexture get texture => element.texture;

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    canvas.drawColor(Color(texture.boxColor), BlendMode.srcOver);
    if (texture.boxWidth > 0 && texture.boxXCount > 0) {
      var relativeWidth = texture.boxWidth * transform.size;
      var relativeSpace = texture.boxXSpace * transform.size;
      int xCount = (transform.position.dx /
                  (texture.boxWidth * texture.boxXCount + texture.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (texture.boxWidth * texture.boxXCount + texture.boxXSpace) +
              transform.position.dx;
      x *= transform.size;

      int count = 0;
      while (x < size.width) {
        canvas.drawLine(
            Offset(x, 0),
            Offset(x, size.height),
            Paint()
              ..strokeWidth = texture.boxXStroke * transform.size
              ..color = Color(texture.boxXColor));
        count++;
        if (count >= texture.boxXCount) {
          count = 0;
          x += relativeSpace;
        }
        x += relativeWidth;
      }
    }
    if (texture.boxHeight > 0 && texture.boxYCount > 0) {
      var relativeHeight = texture.boxHeight * transform.size;
      var relativeSpace = texture.boxYSpace * transform.size;
      int yCount = (transform.position.dy /
                  (texture.boxHeight * texture.boxYCount + texture.boxYSpace))
              .floor() +
          1;
      double y = -yCount *
              (texture.boxHeight * texture.boxYCount + texture.boxYSpace) +
          transform.position.dy;
      y *= transform.size;

      int count = 0;
      while (y < size.height) {
        canvas.drawLine(
            Offset(0, y),
            Offset(size.width, y),
            Paint()
              ..strokeWidth = texture.boxYStroke * transform.size
              ..color = Color(texture.boxYColor));
        count++;
        if (count >= texture.boxYCount) {
          count = 0;
          y += relativeSpace;
        }
        y += relativeHeight;
      }
    }
  }

  @override
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) {
    var g =
        xml.getOrCreateElement('svg').createElement('g', id: 'box-background');

    g.createElement('rect', attributes: {
      'x': '${viewportRect.left}px',
      'y': '${viewportRect.top}px',
      'width': '${viewportRect.width}px',
      'height': '${viewportRect.height}px',
      'fill': texture.boxColor.toHexColor(),
    });
    if (texture.boxWidth > 0 && texture.boxXCount > 0) {
      int xCount = (viewportRect.left /
                  (texture.boxWidth * texture.boxXCount + texture.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (texture.boxWidth * texture.boxXCount + texture.boxXSpace) +
              viewportRect.left;

      int count = 0;
      while (x < viewportRect.width) {
        g.createElement('line', attributes: {
          'x1': '${x + viewportRect.left}px',
          'y1': '${viewportRect.top}px',
          'x2': '${x + viewportRect.left}px',
          'y2': '${viewportRect.top + viewportRect.height}px',
          'stroke': texture.boxXColor.toHexColor(),
          'stroke-width': '${texture.boxXStroke}'
        });
        count++;
        if (count >= texture.boxXCount) {
          count = 0;
          x += texture.boxXSpace;
        }
        x += texture.boxWidth;
      }
    }
    if (texture.boxHeight > 0 && texture.boxYCount > 0) {
      int yCount = (viewportRect.top /
                  (texture.boxHeight * texture.boxYCount + texture.boxYSpace))
              .floor() +
          1;
      double y = -yCount *
              (texture.boxHeight * texture.boxYCount + texture.boxYSpace) +
          viewportRect.top;

      int count = 0;
      while (y < viewportRect.height) {
        g.createElement('line', attributes: {
          'x1': '${viewportRect.left}px',
          'y1': '${y + viewportRect.top}px',
          'x2': '${viewportRect.left + viewportRect.width}px',
          'y2': '${y + viewportRect.top}px',
          'stroke': texture.boxYColor.toHexColor(),
          'stroke-width': '${texture.boxYStroke}'
        });
        count++;
        if (count >= texture.boxYCount) {
          count = 0;
          y += texture.boxYSpace;
        }
        y += texture.boxHeight;
      }
    }
  }
}
