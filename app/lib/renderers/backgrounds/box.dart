part of '../renderer.dart';

class BoxBackgroundRenderer extends Renderer<BoxBackground> {
  BoxBackgroundRenderer(BoxBackground element) : super(element);

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
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
    var g = xml.createElement('g', id: 'box-background');

    g.createElement('rect', attributes: {
      'x': '${rect.left}',
      'y': '${rect.top}',
      'width': '${rect.width}',
      'height': '${rect.height}',
      'fill': '${element.boxColor}'
    });
    if (element.boxWidth > 0 && element.boxXCount > 0) {
      var relativeWidth = element.boxWidth * rect.width;
      var relativeSpace = element.boxXSpace * rect.width;
      int xCount = (rect.left /
                  (element.boxWidth * element.boxXCount + element.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (element.boxWidth * element.boxXCount + element.boxXSpace) +
              rect.left;
      x *= rect.width;

      int count = 0;
      while (x < rect.width) {
        g.createElement('line', attributes: {
          'x1': '$x',
          'y1': '${rect.top}',
          'x2': '$x',
          'y2': '${rect.height}',
          'stroke': '${element.boxXColor}',
          'stroke-width': '${element.boxXStroke * rect.width}'
        });
        count++;
        if (count >= element.boxXCount) {
          count = 0;
          x += relativeSpace;
        }
        x += relativeWidth;
      }
    }
    if (element.boxHeight > 0 && element.boxYCount > 0) {
      var relativeHeight = element.boxHeight * rect.height;
      var relativeSpace = element.boxYSpace * rect.height;
      int yCount = (rect.top /
                  (element.boxHeight * element.boxYCount + element.boxYSpace))
              .floor() +
          1;
      double y = -yCount *
              (element.boxHeight * element.boxYCount + element.boxYSpace) +
          rect.top;
      y *= rect.height;

      int count = 0;
      while (y < rect.height) {
        g.createElement('line', attributes: {
          'x1': '${rect.left}',
          'y1': '$y',
          'x2': '${rect.width}',
          'y2': '$y',
          'stroke': '${element.boxYColor}',
          'stroke-width': '${element.boxYStroke * rect.height}'
        });
        count++;
        if (count >= element.boxYCount) {
          count = 0;
          y += relativeSpace;
        }
        y += relativeHeight;
      }
    }
  }
}
