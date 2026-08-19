part of 'handler.dart';

class ImportHandler extends Handler<ImportTool> {
  final List<Renderer<PadElement>> _renderers;
  Offset _offset = Offset.zero;

  ImportHandler(super.data)
    : _renderers = data.elements
          .map(Renderer.fromInstance)
          .whereType<Renderer<PadElement>>()
          .toList();

  @override
  void dispose(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final assetService = state.assetService;
    for (final element in data.elements.whereType<SourcedElement>()) {
      assetService.invalidate(element.source);
    }
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _updatePosition(event.localPosition, context);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) =>
      _updatePosition(event.localPosition, context);

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) =>
      _updatePosition(event.localPosition, context);

  void _updatePosition(Offset localPosition, EventContext context) {
    final transform = context.getCameraTransform();
    _offset = transform.localToGlobal(localPosition);
    context.refreshForegrounds();
  }

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    context.addDocumentEvent(
      AreasCreated(
        data.areas
            .map(
              (e) => AreaPreset(
                area: e.copyWith(position: e.position + _offset.toPoint()),
              ),
            )
            .toList(),
      ),
    );
    context.addDocumentEvent(
      ElementsCreated(
        _renderers
            .map(
              (e) => e
                  .transform(position: _offset, relative: true)
                  ?.element
                  .copyWith(id: createUniqueId()),
            )
            .nonNulls
            .toList(),
        assets: data.assets,
      ),
    );
    await context.refresh();
    await context.delayedBake();
  }

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => _renderers
      .map((e) => e.transform(position: _offset, relative: true) ?? e)
      .toList();

  @override
  MouseCursor get cursor => SystemMouseCursors.grabbing;
}
