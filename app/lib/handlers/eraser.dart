part of 'handler.dart';

class EraserHandler extends Handler<EraserTool> {
  bool _currentlyErasing = false;
  bool _submittedPathErase = false;
  Future<void>? _erasingFuture;
  Offset? _queuedPosition;
  Offset? _currentPos, _lastErased;
  final Map<String, List<PadElement>> _pendingChanges = {};
  final Set<String> _erased = {};
  DocumentBloc? _bloc;

  EraserHandler(super.data);

  @override
  Future<void> onPointerDown(
    PointerDownEvent event,
    EventContext context,
  ) async {
    super.onPointerDown(event, context);
    _pendingChanges.clear();
    _erased.clear();
    _lastErased = null;
    _currentPos = event.localPosition;
    context.refreshForegrounds();
    await _erase(event.localPosition, context);
  }

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_currentPos != null)
      EraserCursor(ToolCursorData(EraserInfo.fromEraser(data), _currentPos!)),
    if (data.mode == EraserMode.stroke)
      ..._pendingChanges.values.expand(
        (elements) => elements.map((e) => Renderer.fromInstance(e)),
      ),
  ];

  @override
  Map<String, RendererState> get rendererStates => switch (data.mode) {
    EraserMode.stroke => Map.fromEntries(
      _pendingChanges.keys.map((e) => MapEntry(e, RendererState.hidden)),
    ),
    EraserMode.path => Map.fromEntries(
      _erased.map((e) => MapEntry(e, RendererState.hidden)),
    ),
  };

  @override
  Future<void> onPointerMove(
    PointerMoveEvent event,
    EventContext context,
  ) async {
    _currentPos = event.localPosition;
    context.refreshForegrounds();
    await _erase(event.localPosition, context);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refreshForegrounds();
  }

  @override
  void resetInput(DocumentBloc bloc) {
    _currentPos = null;
    _lastErased = null;
    _submittedPathErase = false;
    _pendingChanges.clear();
    _erased.clear();
  }

  Future<void> _erase(Offset position, EventContext context) async {
    if (_currentlyErasing) {
      _queuedPosition = position;
      await _erasingFuture;
      return;
    }
    _currentlyErasing = true;
    var nextPosition = position;
    do {
      _queuedPosition = null;
      await _eraseAt(nextPosition, context);
      nextPosition = _queuedPosition ?? nextPosition;
    } while (_queuedPosition != null);
    _erasingFuture = null;
    _currentlyErasing = false;
  }

  Future<void> _eraseAt(Offset position, EventContext context) async {
    final cubit = context.getCurrentIndexCubit();
    final transform = cubit.transformCubit.state;
    final utilities = cubit.state.utilities;
    final globalPos = transform.localToGlobal(position);
    final size = data.strokeWidth;
    final sizeSquared = size * size;
    final shouldErase =
        _lastErased == null ||
        (globalPos - _lastErased!).distanceSquared > sizeSquared;
    final page = context.getPage();
    if (page == null || !shouldErase) return;
    _lastErased = globalPos;

    final future = () async {
      final ray = await context.getDocumentBloc().rayCast(
        globalPos,
        size,
        useCollection: utilities.lockCollection,
        useLayer: utilities.lockLayer,
        hitElementMode: data.hitElementMode,
      );
      var elements = ray.map((e) => e.element);
      if (!data.eraseElements) elements = elements.where((e) => e.isStroke());

      switch (data.mode) {
        case EraserMode.stroke:
          _changeStrokeElements(elements, globalPos, sizeSquared, context);
        case EraserMode.path:
          await _erasePathElements(elements, context);
      }
    }();
    _erasingFuture = future;
    await future;
  }

  void _changeStrokeElements(
    Iterable<PadElement> elements,
    Offset globalPos,
    double limitSquared,
    EventContext context,
  ) {
    var anyChanged = false;

    for (final element in elements) {
      final id = element.id;
      if (id == null) continue;
      if (element is! PenElement) {
        if (!_pendingChanges.containsKey(id)) {
          _pendingChanges[id] = [];
          anyChanged = true;
        }
        continue;
      }

      if (_pendingChanges.containsKey(id)) {
        final currentFragments = _pendingChanges[id]!;
        final newFragments = <PadElement>[];
        bool fragmentsChanged = false;

        for (final fragment in currentFragments) {
          if (fragment is! PenElement) {
            newFragments.add(fragment);
            continue;
          }
          final result = _cutPenElement(fragment, globalPos, limitSquared);
          if (result != null) {
            newFragments.addAll(result);
            fragmentsChanged = true;
          } else {
            newFragments.add(fragment);
          }
        }

        if (fragmentsChanged) {
          _pendingChanges[id] = newFragments;
          anyChanged = true;
        }
      } else {
        final result = _cutPenElement(element, globalPos, limitSquared);
        if (result != null) {
          _pendingChanges[id] = result;
          anyChanged = true;
        }
      }
    }

    if (anyChanged) context.refreshForegrounds();
  }

  Future<void> _erasePathElements(
    Iterable<PadElement> elements,
    EventContext context,
  ) async {
    final ids = elements.map((e) => e.id).nonNulls;
    if (ids.isEmpty) return;
    _erased.addAll(ids);
    await context.refresh();
  }

  List<PadElement>? _cutPenElement(
    PenElement element,
    Offset globalPos,
    double limitSquared,
  ) {
    List<List<PathPoint>> paths = [[]];
    bool changed = false;

    for (final point in element.points) {
      final dx = point.x - globalPos.dx;
      final dy = point.y - globalPos.dy;
      if (dx * dx + dy * dy >= limitSquared) {
        paths.last.add(point);
        continue;
      } else {
        changed = true;
        if (paths.last.isNotEmpty) {
          paths.add([]);
        }
      }
    }

    if (!changed) return null;

    return paths
        .where((element) => element.isNotEmpty)
        .map((e) => element.copyWith(points: e, id: createUniqueId()))
        .toList();
  }

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    if (_erasingFuture != null) await _erasingFuture;
    switch (data.mode) {
      case EraserMode.stroke:
        await _erase(event.localPosition, context);
        if (_pendingChanges.isNotEmpty) {
          context.getDocumentBloc().add(
            ElementsChanged(Map.from(_pendingChanges)),
          );
          _pendingChanges.clear();
        }
      case EraserMode.path:
        if (_erased.isEmpty) return;
        final bloc = _bloc = context.getDocumentBloc();
        bloc.add(ElementsRemoved(_erased.toList()));
        _submittedPathErase = true;
    }
  }

  @override
  Future<void> onViewportUpdated(
    CameraViewport currentViewport,
    CameraViewport newViewport,
  ) async {
    if (!_submittedPathErase || _erased.isEmpty) return;
    _erased.clear();
    await _bloc?.refresh(allowBake: true);
    await _bloc?.delayedBake();
    _submittedPathErase = false;
  }

  @override
  void dispose(DocumentBloc bloc) {
    _currentPos = null;
    _lastErased = null;
    _submittedPathErase = false;
    _currentlyErasing = false;
    _erasingFuture = null;
    _queuedPosition = null;
    _pendingChanges.clear();
    _erased.clear();
    _bloc = null;
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.none;
}
