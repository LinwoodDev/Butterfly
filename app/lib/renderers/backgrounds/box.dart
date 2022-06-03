part of '../renderer.dart';

class BoxBackgroundRenderer extends Renderer<BoxBackground> {
  BoxBackgroundRenderer(super.element);

  @override
  void build(Canvas canvas, Size size, CameraTransform transform,
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
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    var g =
        xml.getOrCreateElement('svg').createElement('g', id: 'box-background');

    g.createElement('rect', attributes: {
      'x': '${rect.left}',
      'y': '${rect.top}',
      'width': '${rect.width}',
      'height': '${rect.height}',
      'fill': '#${element.boxColor.toRadixString(16).substring(2)}'
    });
    if (element.boxWidth > 0 && element.boxXCount > 0) {
      int xCount = (rect.left /
                  (element.boxWidth * element.boxXCount + element.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (element.boxWidth * element.boxXCount + element.boxXSpace) +
              rect.left;

      int count = 0;
      while (x < rect.width) {
        g.createElement('line', attributes: {
          'x1': '${x + rect.left}px',
          'y1': '${rect.top}px',
          'x2': '${x + rect.left}px',
          'y2': '${rect.top + rect.height}px',
          'stroke': '#${element.boxXColor.toRadixString(16).substring(2)}',
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
      int yCount = (rect.top /
                  (element.boxHeight * element.boxYCount + element.boxYSpace))
              .floor() +
          1;
      double y = -yCount *
              (element.boxHeight * element.boxYCount + element.boxYSpace) +
          rect.top;

      int count = 0;
      while (y < rect.height) {
        g.createElement('line', attributes: {
          'x1': '${rect.left}px',
          'y1': '${y + rect.top}px',
          'x2': '${rect.left + rect.width}px',
          'y2': '${y + rect.top}px',
          'stroke': '#${element.boxYColor.toRadixString(16).substring(2)}',
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
