part of '../renderer.dart';

class PolygonRenderer extends Renderer<PolygonElement> {
  @override
  Rect rect;

  PolygonRenderer(super.element, [super.layer, this.rect = Rect.zero]);

  @override
  FutureOr<void> setup(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    if (element.points.isNotEmpty) {
      final points = element.points;
      var topLeftCorner = points.first.toPoint().toOffset();
      var bottomRightCorner = points.first.toPoint().toOffset();
      for (final point in points.skip(1)) {
        topLeftCorner = Offset(
          point.x < topLeftCorner.dx ? point.x : topLeftCorner.dx,
          point.y < topLeftCorner.dy ? point.y : topLeftCorner.dy,
        );
        bottomRightCorner = Offset(
          point.x > bottomRightCorner.dx ? point.x : bottomRightCorner.dx,
          point.y > bottomRightCorner.dy ? point.y : bottomRightCorner.dy,
        );
      }
      rect = Rect.fromLTRB(
        topLeftCorner.dx,
        topLeftCorner.dy,
        bottomRightCorner.dx,
        bottomRightCorner.dy,
      );
    }

    super.setup(document, assetService, page);
  }

  @override
  void build(
    ui.Canvas canvas,
    ui.Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final points = element.points;
    if (points.isEmpty) return;
    final path = ui.Path();
    final first = points.first;
    path.moveTo(first.x, first.y);
    for (var i = 1; i < points.length; i++) {
      final point = points[i];
      final prev = points[i - 1];

      if (prev.handleOut != null || point.handleIn != null) {
        path.cubicTo(
          prev.handleOut?.x ?? prev.x,
          prev.handleOut?.y ?? prev.y,
          point.handleIn?.x ?? point.x,
          point.handleIn?.y ?? point.y,
          point.x,
          point.y,
        );
      } else {
        path.lineTo(point.x, point.y);
      }
    }
    final property = element.property;

    if (property.color.a > 0) {
      final paint = Paint()
        ..color = property.color.toColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = property.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;
      canvas.drawPath(path, paint);
    }
    if (property.fill.a > 0) {
      final fillPaint = Paint()
        ..color = property.fill.toColor()
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);
    }
  }

  @override
  ContextMenuItem? getContextMenuItem(DocumentBloc bloc, BuildContext context) {
    return ContextMenuItem(
      onPressed: () async {
        final polygon =
            await bloc.state.currentIndexCubit?.changeTemporaryHandler(
                  context,
                  PolygonTool(property: element.property),
                  bloc: bloc,
                )
                as PolygonHandler;
        polygon.editElement(element);
        Navigator.of(context).pop();
      },
      icon: const PhosphorIcon(PhosphorIconsLight.polygon),
      label: AppLocalizations.of(context).edit,
    );
  }

  List<PolygonPoint> movePoints(Offset position, double scaleX, double scaleY) {
    final topLeft = rect.topLeft;
    final points = element.points.map((element) {
      final old = element.toPoint() - topLeft.toPoint();
      final x = old.x * scaleX + position.dx;
      final y = old.y * scaleY + position.dy;
      SimplePoint? handleIn, handleOut;
      final elementHandleIn = element.handleIn;
      final elementHandleOut = element.handleOut;
      if (elementHandleIn != null) {
        final oldHandleIn = elementHandleIn.toPoint() - topLeft.toPoint();
        handleIn = SimplePoint(
          oldHandleIn.x * scaleX + position.dx,
          oldHandleIn.y * scaleY + position.dy,
        );
      }
      if (elementHandleOut != null) {
        final oldHandleOut = elementHandleOut.toPoint() - topLeft.toPoint();
        handleOut = SimplePoint(
          oldHandleOut.x * scaleX + position.dx,
          oldHandleOut.y * scaleY + position.dy,
        );
      }
      return element.copyWith(
        x: x,
        y: y,
        handleIn: handleIn,
        handleOut: handleOut,
      );
    }).toList();
    return points;
  }

  Rect moveRect(Offset position, double scaleX, double scaleY) {
    final size = Size(rect.width * scaleX, rect.height * scaleY);
    return position & size;
  }

  @override
  PolygonRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) => PolygonRenderer(
    element.copyWith(
      rotation: rotation,
      points: movePoints(position, scaleX, scaleY),
    ),
    layer,
    moveRect(position, scaleX, scaleY),
  );
}
