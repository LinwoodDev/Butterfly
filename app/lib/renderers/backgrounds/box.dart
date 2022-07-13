part of '../renderer.dart';

class BoxBackgroundRenderer extends Renderer<BoxBackground> {
  BoxBackgroundRenderer(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    canvas.drawColor(Color(element.boxColor), BlendMode.srcOver);
    if (element.boxWidth > 0 && element.boxXCount > 0) {
      var relativeWidth = element.boxWidth * transform.size;
      var relativeSpace = element.boxXSpace * transform.size;
      int xCount = (transform.position.dx /
                  (element.boxWidth * element.boxXCount + element.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (element.boxWidth * element.boxXCount + element.boxXSpace) +
              transform.position.dx;
      x *= transform.size;

      int count = 0;
      while (x < size.width) {
        canvas.drawLine(
            Offset(x, 0),
            Offset(x, size.height),
            Paint()
              ..strokeWidth = element.boxXStroke * transform.size
              ..color = Color(element.boxXColor));
        count++;
        if (count >= element.boxXCount) {
          count = 0;
          x += relativeSpace;
        }
        x += relativeWidth;
      }
    }
    if (element.boxHeight > 0 && element.boxYCount > 0) {
      var relativeHeight = element.boxHeight * transform.size;
      var relativeSpace = element.boxYSpace * transform.size;
      int yCount = (transform.position.dy /
                  (element.boxHeight * element.boxYCount + element.boxYSpace))
              .floor() +
          1;
      double y = -yCount *
              (element.boxHeight * element.boxYCount + element.boxYSpace) +
          transform.position.dy;
      y *= transform.size;

      int count = 0;
      while (y < size.height) {
        canvas.drawLine(
            Offset(0, y),
            Offset(size.width, y),
            Paint()
              ..strokeWidth = element.boxYStroke * transform.size
              ..color = Color(element.boxYColor));
        count++;
        if (count >= element.boxYCount) {
          count = 0;
          y += relativeSpace;
        }
        y += relativeHeight;
      }
    }
  }

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect viewportRect) {
    var g =
        xml.getOrCreateElement('svg').createElement('g', id: 'box-background');

    g.createElement('rect', attributes: {
      'x': '${viewportRect.left}px',
      'y': '${viewportRect.top}px',
      'width': '${viewportRect.width}px',
      'height': '${viewportRect.height}px',
      'fill': element.boxColor.toHexColor(),
    });
    if (element.boxWidth > 0 && element.boxXCount > 0) {
      int xCount = (viewportRect.left /
                  (element.boxWidth * element.boxXCount + element.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (element.boxWidth * element.boxXCount + element.boxXSpace) +
              viewportRect.left;

      int count = 0;
      while (x < viewportRect.width) {
        g.createElement('line', attributes: {
          'x1': '${x + viewportRect.left}px',
          'y1': '${viewportRect.top}px',
          'x2': '${x + viewportRect.left}px',
          'y2': '${viewportRect.top + viewportRect.height}px',
          'stroke': element.boxXColor.toHexColor(),
          'stroke-width': '${element.boxXStroke}'
        });
        count++;
        if (count >= element.boxXCount) {
          count = 0;
          x += element.boxXSpace;
        }
        x += element.boxWidth;
      }
    }
    if (element.boxHeight > 0 && element.boxYCount > 0) {
      int yCount = (viewportRect.top /
                  (element.boxHeight * element.boxYCount + element.boxYSpace))
              .floor() +
          1;
      double y = -yCount *
              (element.boxHeight * element.boxYCount + element.boxYSpace) +
          viewportRect.top;

      int count = 0;
      while (y < viewportRect.height) {
        g.createElement('line', attributes: {
          'x1': '${viewportRect.left}px',
          'y1': '${y + viewportRect.top}px',
          'x2': '${viewportRect.left + viewportRect.width}px',
          'y2': '${y + viewportRect.top}px',
          'stroke': element.boxYColor.toHexColor(),
          'stroke-width': '${element.boxYStroke}'
        });
        count++;
        if (count >= element.boxYCount) {
          count = 0;
          y += element.boxYSpace;
        }
        y += element.boxHeight;
      }
    }
  }
}
