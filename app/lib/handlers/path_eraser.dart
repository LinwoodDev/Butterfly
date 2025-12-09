part of 'handler.dart';

class PathEraserHandler extends Handler<PathEraserTool> {
  bool _currentlyErasing = false;
  bool _submittedErase = false;
  Future<void>? _erasingFuture;
  Offset? _currentPos, _lastErased;
  final Set<String> _erased = {};
  PathEraserHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_currentPos != null)
      EraserCursor(
        ToolCursorData(EraserInfo.fromPathEraser(data), _currentPos!),
      ),
  ];

  @override
  Map<String, RendererState> get rendererStates =>
      Map.fromEntries(_erased.map((e) => MapEntry(e, RendererState.hidden)));

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh(allowBake: false);
  }

  @override
  void resetInput(DocumentBloc bloc) {
    _currentPos = null;
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    super.onPointerDown(event, context);
    _erased.clear();
  }

  @override
  Future<void> onPointerMove(
    PointerMoveEvent event,
    EventContext context,
  ) async {
    _currentPos = event.localPosition;
    context.refresh(allowBake: false);
    await _erase(event.localPosition, context);
  }

  Future<void> _erase(Offset position, EventContext context) async {
    final currentIndex = context.getCurrentIndex();
    final transform = currentIndex.transformCubit.state;
    final utilities = currentIndex.utilities;
    final state = context.getState();
    final globalPos = transform.localToGlobal(position);
    final size = data.strokeWidth;
    final sizeSquared = size * size;
    final shouldErase =
        _lastErased == null ||
        (globalPos - _lastErased!).distanceSquared > sizeSquared;
    if (_currentlyErasing || !shouldErase) return;
    _currentlyErasing = true;
    _lastErased = globalPos;

    final future = () async {
      Iterable<Renderer<PadElement>> ray = await context
          .getDocumentBloc()
          .rayCast(
            globalPos,
            size,
            useCollection: utilities.lockCollection,
            useLayer: utilities.lockLayer,
          );
      final page = state?.page;
      if (page == null) return;
      if (!data.eraseElements) ray = ray.where((e) => e.element.isStroke());
      var ids = ray.map((e) => e.element.id).nonNulls;
      if (ids.isNotEmpty) {
        _erased.addAll(ids);
        await context.refresh();
      }
    }();
    _erasingFuture = future;
    await future;
    _erasingFuture = null;
    _currentlyErasing = false;
  }

  DocumentBloc? _bloc;

  @override
  Future<void> onViewportUpdated(
    CameraViewport currentViewport,
    CameraViewport newViewport,
  ) async {
    if (!_submittedErase || _erased.isEmpty) return;
    _erased.clear();
    await _bloc?.refresh(allowBake: true);
    await _bloc?.delayedBake();
    _submittedErase = false;
  }

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    if (_erasingFuture != null) await _erasingFuture;
    if (_erased.isEmpty) return;
    final bloc = _bloc = context.getDocumentBloc();
    bloc.add(ElementsRemoved(_erased.toList()));
    _submittedErase = true;
  }

  @override
  MouseCursor? get cursor => SystemMouseCursors.none;
}
