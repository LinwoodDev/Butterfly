part of 'handler.dart';

class GridHandler extends Handler<GridTool> with PointerManipulationHandler {
  GridHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [GridRenderer(data)];

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    return SelectState.toggle;
  }

  @override
  Offset getPointerPosition(
    Offset position,
    Size viewportSize, [
    CameraTransform transform = const .new(),
  ]) {
    final grid = _gridGeometry(data, transform);
    final point = transform.localToGlobal(position);
    double snap(double value, double origin, double step) =>
        step > 0 ? ((value - origin) / step).round() * step + origin : value;
    return transform.globalToLocal(
      Offset(
        snap(point.dx, grid.origin.dx, grid.spacing.dx),
        snap(point.dy, grid.origin.dy, grid.spacing.dy),
      ),
    );
  }
}

class GridRenderer extends Renderer<GridTool> {
  GridRenderer(super.element);

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final grid = _gridGeometry(element, transform);
    final bounds = transform.localToGlobalRect(Offset.zero & size);
    final paint = Paint()
      ..strokeWidth = element.stroke / transform.size
      ..color = element.color.toColor();
    final dx = grid.spacing.dx;
    if (dx > 0) {
      final first =
          ((bounds.left - grid.origin.dx) / dx).floor() * dx + grid.origin.dx;
      for (var x = first; x <= bounds.right; x += dx) {
        canvas.drawLine(Offset(x, bounds.top), Offset(x, bounds.bottom), paint);
      }
    }
    final dy = grid.spacing.dy;
    if (dy > 0) {
      final first =
          ((bounds.top - grid.origin.dy) / dy).floor() * dy + grid.origin.dy;
      for (var y = first; y <= bounds.bottom; y += dy) {
        canvas.drawLine(Offset(bounds.left, y), Offset(bounds.right, y), paint);
      }
    }
  }
}

({Offset origin, Offset spacing}) _gridGeometry(
  GridTool tool,
  CameraTransform transform,
) => (
  origin:
      Offset(tool.xOffset, tool.yOffset) / transform.size +
      (tool.positionDependent ? Offset.zero : transform.position),
  spacing:
      Offset(tool.xSize, tool.ySize) /
      (tool.zoomDependent ? 1 : transform.size),
);
