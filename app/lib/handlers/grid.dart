part of 'handler.dart';

class GridHandler extends Handler<GridTool> with PointerManipulationHandler {
  GridHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
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
    CameraTransform transform = const CameraTransform(),
  ]) {
    var xSize = data.xSize;
    var ySize = data.ySize;
    var xOffset = data.xOffset;
    var yOffset = data.yOffset;
    if (data.zoomDependent) {
      xSize *= transform.size;
      ySize *= transform.size;
    }
    if (data.positionDependent) {
      xOffset -= transform.position.dx * transform.size;
      yOffset -= transform.position.dy * transform.size;
    }
    var x = (position.dx - xOffset) / xSize;
    if (!x.isFinite) {
      x = position.dx;
    } else {
      x = x.round() * xSize + xOffset;
    }
    var y = (position.dy - yOffset) / ySize;
    if (!y.isFinite) {
      y = position.dy;
    } else {
      y = y.round() * ySize + yOffset;
    }
    return Offset(x, y);
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
    if (element.xSize > 0) {
      double x = -element.xSize + element.xOffset % element.xSize;
      var cap = size.width;
      if (element.zoomDependent) {
        cap = size.width / transform.size;
      }
      cap += element.xSize;
      while (x <= cap) {
        var localX = x;
        if (!element.zoomDependent) {
          localX /= transform.size;
        }
        if (element.positionDependent) {
          var size = element.xSize;
          if (!element.zoomDependent) {
            size /= transform.size;
          }
          localX -= transform.position.dx % size;
        }
        canvas.drawLine(
          Offset(localX + transform.position.dx, transform.position.dy),
          Offset(
            localX + transform.position.dx,
            size.height / transform.size + transform.position.dy,
          ),
          Paint()
            ..strokeWidth = element.stroke / transform.size
            ..color = element.color.toColor(),
        );
        x += element.xSize;
      }
    }
    if (element.ySize > 0) {
      double y = -element.ySize + element.yOffset % element.ySize;
      var cap = size.height;
      if (element.zoomDependent) {
        cap = size.height / transform.size;
      }
      cap += element.ySize;
      while (y <= cap) {
        var localY = y;
        if (!element.zoomDependent) {
          localY /= transform.size;
        }
        if (element.positionDependent) {
          var size = element.ySize;
          if (!element.zoomDependent) {
            size /= transform.size;
          }
          localY -= transform.position.dy % size;
        }
        canvas.drawLine(
          Offset(transform.position.dx, transform.position.dy + localY),
          Offset(
            transform.position.dx + size.width / transform.size,
            transform.position.dy + localY,
          ),
          Paint()
            ..strokeWidth = element.stroke / transform.size
            ..color = element.color.toColor(),
        );
        y += element.ySize;
      }
    }
  }
}
