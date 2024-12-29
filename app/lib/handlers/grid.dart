part of 'handler.dart';

class GridHandler extends Handler<GridTool> {
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
}

class GridRenderer extends Renderer<GridTool> {
  GridRenderer(super.element);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    if (element.xSize > 0) {
      double x = 0;
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
      double y = 0;
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
