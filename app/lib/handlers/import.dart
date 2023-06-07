part of 'handler.dart';

class ImportHandler extends Handler<ImportPainter> {
  Offset _position = Offset.zero;

  ImportHandler(super.data);

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    context.refresh();
  }

  @override
  Future<void> onPointerHover(
      PointerHoverEvent event, EventContext context) async {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
    context.refresh();
  }

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
    context.refresh();
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) => false;

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    context.addDocumentEvent(ElementsCreated.renderers(
        _load().map((e) => e.transform(position: _position) ?? e).toList()));
    context.addDocumentEvent(AreasCreated(data.areas
        .map((e) => e.copyWith(
              position: e.position + _position.toPoint(),
            ))
        .toList()));
    context
        .getCurrentIndexCubit()
        .resetTemporaryHandler(context.getDocumentBloc());
    context.refresh();
    context.bake();
  }

  List<Renderer<PadElement>> _load([bool force = false]) {
    return data.elements
        .map((e) => Renderer.fromInstance(e))
        .whereType<Renderer<PadElement>>()
        .toList();
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      _load(true).map((e) => e.transform(position: _position) ?? e).toList();
}
