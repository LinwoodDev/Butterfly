part of 'renderer.dart';

class ToolRenderer extends Renderer<ToolState> {
  ToolRenderer(super.element);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    final option = document.tool;
    if (option.showGrid) {
      double x = 0;
      while (x < size.width / transform.size) {
        canvas.drawLine(
          Offset(x - transform.position.dx, -transform.position.dy),
          Offset(x - transform.position.dx,
              size.height / transform.size - transform.position.dy),
          Paint()
            ..strokeWidth = 1 / transform.size
            ..color = Color(option.gridColor),
        );
        x += option.gridXSize * transform.size;
      }
      double y = 0;
      while (y < size.height / transform.size) {
        canvas.drawLine(
          Offset(-transform.position.dx, -transform.position.dy + y),
          Offset(-transform.position.dx + size.width / transform.size,
              -transform.position.dy + y),
          Paint()
            ..strokeWidth = 1 / transform.size
            ..color = Color(option.gridColor),
        );
        y += option.gridYSize * transform.size;
      }
    }
    if (element.rulerEnabled) {
      final rulerSize = 100 / transform.size;
      const rulerColor = Colors.grey;
      final rulerBackgroundColor = Colors.grey.withAlpha(150);
      final rulerPaint = Paint()
        ..color = rulerColor
        ..strokeWidth = 1 / transform.size
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round;
      final rulerBackgroundPaint = Paint()
        ..color = rulerBackgroundColor
        ..style = PaintingStyle.fill;

      var step = 10;
      while (step < 40 / transform.size) {
        step += 10;
      }
      while (step > 80 / transform.size) {
        step -= 10;
      }

      // Paint ruler background
      canvas.drawRect(
          Rect.fromLTWH(
              -transform.position.dx,
              -transform.position.dy +
                  size.height / transform.size / 2 -
                  rulerSize / 2,
              size.width / transform.size,
              rulerSize),
          rulerBackgroundPaint);

      // Paint ruler lines
      int x = 0;
      var placeTextBottom = false;
      while (x < size.width / transform.size) {
        canvas.drawLine(
          Offset(
              x - transform.position.dx + transform.position.dx % step,
              -transform.position.dy +
                  size.height / transform.size / 2 -
                  rulerSize / 2),
          Offset(
              x - transform.position.dx + transform.position.dx % step,
              -transform.position.dy +
                  size.height / transform.size / 2 -
                  (placeTextBottom ? rulerSize / 8 : rulerSize / 4)),
          rulerPaint,
        );
        final textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          textScaleFactor: 1 / transform.size,
          text: TextSpan(
              text: x.toString(), style: const TextStyle(color: rulerColor)),
        );
        textPainter.layout();
        textPainter.paint(
            canvas,
            Offset(
                x -
                    transform.position.dx +
                    transform.position.dx % step -
                    textPainter.width / 2,
                -transform.position.dy +
                    size.height / transform.size / 2 +
                    (placeTextBottom ? -rulerSize / 8 : -rulerSize / 4)));
        placeTextBottom = !placeTextBottom;
        x += step;
      }
    }
  }
}
