part of 'handler.dart';

class ImportHandler extends Handler<ImportTool> {
  final List<Renderer<PadElement>> _renderers;
  Offset? _localPosition;

  ImportHandler(super.data)
    : _renderers = data.elements
          .map(Renderer.fromInstance)
          .whereType<Renderer<PadElement>>()
          .toList();

  Future<void> prepare(DocumentLoadSuccess state, TransformCubit camera) =>
      prepareImportedRenderers(_renderers, state, camera);

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.buttons != kPrimaryButton;

  @override
  void dispose(DocumentBloc bloc) {
    for (final renderer in _renderers) {
      renderer.dispose();
    }
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final assetService = state.assetService;
    final sources = data.elements.expand((element) => element.sources).toSet();
    sources.removeAll(state.page.sources);
    for (final source in sources) {
      assetService.invalidate(source);
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
    _localPosition = localPosition;
    context.refreshForegrounds();
  }

  CameraTransform _placement(CameraTransform camera, Offset? position) =>
      CameraTransform(
        1,
        position == null ? Offset.zero : camera.localToGlobal(position),
        1,
        camera.rotation,
      );

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    final placement = _placement(
      context.getCameraTransform(),
      event.localPosition,
    );
    context.addDocumentEvent(
      AreasCreated(
        data.areas
            .map(
              (e) => AreaPreset(
                page: state.pageName,
                area: placeImportedArea(e, placement),
              ),
            )
            .toList(),
      ),
    );
    context.addDocumentEvent(
      ElementsCreated(
        _renderers
            .map(
              (renderer) => placeImportedElement(
                renderer,
                placement,
              ).copyWith(id: createUniqueId()),
            )
            .toList(),
        assets: data.assets,
        pageName: state.pageName,
        layer: state.currentLayer,
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
  ]) {
    final placement = _placement(
      editorController.transformCubit.state,
      _localPosition,
    );
    return _renderers
        .map((renderer) => placeImportedRenderer(renderer, placement))
        .toList();
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.grabbing;
}
