part of 'handler.dart';

class ImportHandler extends Handler<ImportPainter> {
  Offset _position = Offset.zero;
  final List<Renderer<PadElement>> _renderers;

  ImportHandler(super.data)
      : _renderers =
            data.elements.map((e) => Renderer.fromInstance(e)).toList();

  @override
  bool onSelected(
      DocumentBloc bloc, CurrentIndexCubit currentIndexCubit, bool justAdded) {
    if (justAdded) return false;
    return false;
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    context.refresh();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    context.refresh();
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    context.refresh();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    context.addDocumentEvent(ElementsCreated.renderers(
        _renderers.map((e) => e.transform(position: _position) ?? e).toList()));
    context.addDocumentEvent(AreasCreated(data.areas
        .map((e) => e.copyWith(
              position: e.position + _position,
            ))
        .toList()));
    context.getCurrentIndexCubit().resetTemporaryHandler();
    context.refresh();
    context.bake();
  }

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      _renderers.map((e) => e.transform(position: _position) ?? e).toList();
}
