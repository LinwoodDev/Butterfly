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
      while (x < size.width) {
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
      while (y < size.height) {
        canvas.drawLine(
          Offset(-transform.position.dx, -transform.position.dy + y),
          Offset(
              -transform.position.dx + size.width, -transform.position.dy + y),
          Paint()
            ..strokeWidth = 1 / transform.size
            ..color = Color(option.gridColor),
        );
        y += option.gridYSize * transform.size;
      }
    }
  }
}
