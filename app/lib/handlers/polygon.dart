part of 'handler.dart';

class PolygonHandler extends Handler<PolygonTool> with ColoredHandler {
  PolygonElement? _element;

  PolygonHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [if (_element != null) PolygonRenderer(_element!)];

  @override
  SRGBColor getColor() => data.property.color;

  @override
  PolygonTool setColor(SRGBColor color) =>
      data.copyWith(property: data.property.copyWith(color: color));

  void addPoint(EventContext context, Offset localPos) {
    final globalPos = context.getCameraTransform().localToGlobal(localPos);
    var element =
        _element ?? PolygonElement(points: [], property: data.property);
    element = element.copyWith(
      points: [...element.points, PolygonPoint(globalPos.dx, globalPos.dy)],
    );
    _element = element;
    context.refresh();
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    final localPos = details.localPosition;
    addPoint(context, localPos);
  }
}
