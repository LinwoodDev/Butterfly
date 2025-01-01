part of 'handler.dart';

class GridHandler extends Handler<GridTool> with PointerManipulationHandler {
  GridHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [GridRenderer(data)];

  @override
  SelectState onSelected(BuildContext context, [bool wasAdded = true]) {
    return SelectState.toggle;
  }

  @override
  Offset getPointerPosition(Offset position, Size viewportSize) {
    final xSize = data.xSize;
    final ySize = data.ySize;
    final xOffset = data.xOffset;
    final yOffset = data.yOffset;
    final x = (position.dx - xOffset) / xSize;
    final y = (position.dy - yOffset) / ySize;
    return Offset(x.round() * xSize + xOffset, y.round() * ySize + yOffset);
  }
}

class GridRenderer extends Renderer<GridTool> {
  GridRenderer(super.element);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    if (element.xSize > 0) {
      double x = -element.xSize + element.xOffset % element.xSize;
      while (x < size.width) {
        final localX = x / transform.size;
        canvas.drawLine(
          Offset(localX + transform.position.dx, transform.position.dy),
          Offset(localX + transform.position.dx,
              size.height / transform.size + transform.position.dy),
          Paint()
            ..strokeWidth = 1 / transform.size
            ..color = element.color.toColor(),
        );
        x += element.xSize;
      }
    }
    if (element.ySize > 0) {
      double y = -element.ySize + element.yOffset % element.ySize;
      while (y < size.height) {
        final localY = y / transform.size;
        canvas.drawLine(
          Offset(transform.position.dx, transform.position.dy + localY),
          Offset(transform.position.dx + size.width / transform.size,
              transform.position.dy + localY),
          Paint()
            ..strokeWidth = 1 / transform.size
            ..color = element.color.toColor(),
        );
        y += element.ySize;
      }
    }
  }
}
