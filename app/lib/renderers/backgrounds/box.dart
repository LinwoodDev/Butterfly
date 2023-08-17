part of '../renderer.dart';

class MotifBackgroundRenderer extends Renderer<MotifBackground> {
  MotifBackgroundRenderer(super.element);

  Motif get motif => element.motif;

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    canvas.drawColor(Color(motif.boxColor), BlendMode.srcOver);
    if (motif.boxWidth > 0 && motif.boxXCount > 0) {
      var relativeWidth = motif.boxWidth * transform.size;
      var relativeSpace = motif.boxXSpace * transform.size;
      int xCount = (transform.position.dx /
                  (motif.boxWidth * motif.boxXCount + motif.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (motif.boxWidth * motif.boxXCount + motif.boxXSpace) +
              transform.position.dx;
      x *= transform.size;

      int count = 0;
      while (x < size.width) {
        canvas.drawLine(
            Offset(x, 0),
            Offset(x, size.height),
            Paint()
              ..strokeWidth = motif.boxXStroke * transform.size
              ..color = Color(motif.boxXColor));
        count++;
        if (count >= motif.boxXCount) {
          count = 0;
          x += relativeSpace;
        }
        x += relativeWidth;
      }
    }
    if (motif.boxHeight > 0 && motif.boxYCount > 0) {
      var relativeHeight = motif.boxHeight * transform.size;
      var relativeSpace = motif.boxYSpace * transform.size;
      int yCount = (transform.position.dy /
                  (motif.boxHeight * motif.boxYCount + motif.boxYSpace))
              .floor() +
          1;
      double y =
          -yCount * (motif.boxHeight * motif.boxYCount + motif.boxYSpace) +
              transform.position.dy;
      y *= transform.size;

      int count = 0;
      while (y < size.height) {
        canvas.drawLine(
            Offset(0, y),
            Offset(size.width, y),
            Paint()
              ..strokeWidth = motif.boxYStroke * transform.size
              ..color = Color(motif.boxYColor));
        count++;
        if (count >= motif.boxYCount) {
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
      'fill': motif.boxColor.toHexColor(),
    });
    if (motif.boxWidth > 0 && motif.boxXCount > 0) {
      int xCount = (viewportRect.left /
                  (motif.boxWidth * motif.boxXCount + motif.boxXSpace))
              .floor() +
          1;
      double x =
          -xCount * (motif.boxWidth * motif.boxXCount + motif.boxXSpace) +
              viewportRect.left;

      int count = 0;
      while (x < viewportRect.width) {
        g.createElement('line', attributes: {
          'x1': '${x + viewportRect.left}px',
          'y1': '${viewportRect.top}px',
          'x2': '${x + viewportRect.left}px',
          'y2': '${viewportRect.top + viewportRect.height}px',
          'stroke': motif.boxXColor.toHexColor(),
          'stroke-width': '${motif.boxXStroke}'
        });
        count++;
        if (count >= motif.boxXCount) {
          count = 0;
          x += motif.boxXSpace;
        }
        x += motif.boxWidth;
      }
    }
    if (motif.boxHeight > 0 && motif.boxYCount > 0) {
      int yCount = (viewportRect.top /
                  (motif.boxHeight * motif.boxYCount + motif.boxYSpace))
              .floor() +
          1;
      double y =
          -yCount * (motif.boxHeight * motif.boxYCount + motif.boxYSpace) +
              viewportRect.top;

      int count = 0;
      while (y < viewportRect.height) {
        g.createElement('line', attributes: {
          'x1': '${viewportRect.left}px',
          'y1': '${y + viewportRect.top}px',
          'x2': '${viewportRect.left + viewportRect.width}px',
          'y2': '${y + viewportRect.top}px',
          'stroke': motif.boxYColor.toHexColor(),
          'stroke-width': '${motif.boxYStroke}'
        });
        count++;
        if (count >= motif.boxYCount) {
          count = 0;
          y += motif.boxYSpace;
        }
        y += motif.boxHeight;
      }
    }
  }
}
