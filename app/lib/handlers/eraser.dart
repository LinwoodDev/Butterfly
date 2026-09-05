part of 'handler.dart';

/// Returns the surviving stroke fragments, or null when nothing was erased.
/// Only circle intersections add points; untouched segments retain their input
/// points and pressure instead of being densely resampled on every pointer move.
@visibleForTesting
List<List<PathPoint>>? cutPenPointsForEraser(
  List<PathPoint> points,
  Offset center,
  double radius,
) {
  if (points.isEmpty ||
      radius <= 0 ||
      !radius.isFinite ||
      !center.dx.isFinite ||
      !center.dy.isFinite) {
    return null;
  }
  final radiusSquared = radius * radius;
  bool outside(PathPoint point) {
    final dx = point.x - center.dx;
    final dy = point.y - center.dy;
    return dx * dx + dy * dy >= radiusSquared;
  }

  PathPoint interpolate(PathPoint start, PathPoint end, double t) {
    if (t <= 0) return start;
    if (t >= 1) return end;
    return PathPoint(
      start.x + (end.x - start.x) * t,
      start.y + (end.y - start.y) * t,
      start.pressure + (end.pressure - start.pressure) * t,
    );
  }

  final paths = <List<PathPoint>>[];
  var path = <PathPoint>[];
  var changed = !outside(points.first);
  if (!changed) path.add(points.first);
  for (var i = 1; i < points.length; i++) {
    final start = points[i - 1];
    final end = points[i];
    final dx = end.x - start.x;
    final dy = end.y - start.y;
    final length = sqrt(dx * dx + dy * dy);
    if (length == 0) {
      if (outside(end)) path.add(end);
      continue;
    }

    // Project onto the segment's unit direction to avoid subtracting the two
    // large, nearly equal terms of the quadratic discriminant on long strokes.
    final ux = dx / length;
    final uy = dy / length;
    final cx = center.dx - start.x;
    final cy = center.dy - start.y;
    final along = cx * ux + cy * uy;
    final perpendicular = cx * uy - cy * ux;
    final halfChordSquared = radiusSquared - perpendicular * perpendicular;
    if (halfChordSquared <= 0) {
      path.add(end);
      continue;
    }
    final halfChord = sqrt(halfChordSquared);
    final enter = max(0.0, (along - halfChord) / length);
    final exit = min(1.0, (along + halfChord) / length);
    if (enter >= exit) {
      path.add(end);
      continue;
    }

    changed = true;
    if (enter > 0) path.add(interpolate(start, end, enter));
    if (path.isNotEmpty) paths.add(path);
    path = <PathPoint>[];
    if (exit < 1) path.add(interpolate(start, end, exit));
    if (outside(end)) path.add(end);
  }
  if (!changed) return null;
  if (path.isNotEmpty) paths.add(path);
  return paths;
}

// Each gesture owns its queue so cancelled work cannot clear a new gesture's
// pending moves when it finishes.
class _EraserGesture {
  bool cancelled = false;
  Future<void>? running;
  ({Offset position, EventContext context, bool force})? queued;
  Offset? lastErased;

  void cancel() {
    cancelled = true;
    queued = null;
  }
}

class EraserHandler extends Handler<EraserTool> {
  bool _submittedPathErase = false;
  _EraserGesture _gesture = _EraserGesture();
  bool _disposed = false;
  Offset? _currentPos;
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
    if (_disposed) return;
    resetInput(context.getDocumentBloc());
    _currentPos = event.localPosition;
    context.refreshForegrounds();
    await _erase(event.localPosition, context);
  }

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
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
    if (_disposed) return;
    _currentPos = event.localPosition;
    context.refreshForegrounds();
    await _erase(event.localPosition, context);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    if (_disposed) return;
    _currentPos = event.localPosition;
    context.refreshForegrounds();
  }

  @override
  void resetInput(DocumentBloc bloc) {
    _gesture.cancel();
    _gesture = _EraserGesture();
    _currentPos = null;
    _submittedPathErase = false;
    _bloc = null;
    _pendingChanges.clear();
    _erased.clear();
  }

  Future<void> _erase(
    Offset position,
    EventContext context, {
    bool force = false,
  }) {
    if (_disposed) return Future.value();
    final gesture = _gesture;
    gesture.queued = (position: position, context: context, force: force);
    // All callers wait for the entire drain, including the latest queued move.
    // Schedule after assigning the future so even synchronous work is tracked.
    return gesture.running ??= Future<void>.microtask(() async {
      try {
        while (!gesture.cancelled && gesture.queued != null) {
          final next = gesture.queued!;
          gesture.queued = null;
          await _eraseAt(
            next.position,
            next.context,
            gesture,
            force: next.force,
          );
        }
      } finally {
        gesture.running = null;
        gesture.queued = null;
      }
    });
  }

  Future<void> _eraseAt(
    Offset position,
    EventContext context,
    _EraserGesture gesture, {
    bool force = false,
  }) async {
    final cubit = context.getEditorController();
    final transform = cubit.transformCubit.state;
    final locks = cubit.viewCubit.state.locks;
    final globalPos = transform.localToGlobal(position);
    final size = data.strokeWidth;
    final sizeSquared = size * size;
    final shouldErase =
        gesture.lastErased == null ||
        (globalPos - gesture.lastErased!).distanceSquared >
            (force ? 0 : sizeSquared);
    final page = context.getPage();
    if (page == null || !shouldErase) return;
    final ray = await context.getDocumentBloc().rayCast(
      globalPos,
      size,
      useCollection: locks.lockCollection,
      useLayer: locks.lockLayer,
      hitElementMode: data.hitElementMode,
    );
    // Resetting input or switching tools invalidates an in-flight ray cast.
    if (gesture.cancelled) return;
    var elements = ray.map((e) => e.element);
    if (!data.eraseElements) elements = elements.where((e) => e.isStroke());

    switch (data.mode) {
      case EraserMode.stroke:
        _changeStrokeElements(elements, globalPos, sizeSquared, context);
      case EraserMode.path:
        await _erasePathElements(elements, context);
    }
    if (!gesture.cancelled) gesture.lastErased = globalPos;
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
    var changed = false;
    for (final id in elements.map((e) => e.id).nonNulls) {
      if (_erased.add(id)) changed = true;
    }
    if (!changed) return;
    await context.refresh();
  }

  List<PadElement>? _cutPenElement(
    PenElement element,
    Offset globalPos,
    double limitSquared,
  ) {
    final paths = cutPenPointsForEraser(
      element.points,
      globalPos,
      sqrt(limitSquared),
    );
    return paths
        ?.map(
          (points) => element.copyWith(points: points, id: createUniqueId()),
        )
        .toList();
  }

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final gesture = _gesture;
    await _erase(event.localPosition, context, force: true);
    if (_disposed || gesture.cancelled) return;
    switch (data.mode) {
      case EraserMode.stroke:
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
    final gesture = _gesture;
    final bloc = _bloc;
    _submittedPathErase = false;
    _erased.clear();
    await bloc?.refresh(allowBake: true);
    if (!gesture.cancelled) await bloc?.delayedBake();
  }

  @override
  void dispose(DocumentBloc bloc) {
    _disposed = true;
    resetInput(bloc);
    _bloc = null;
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.none;
}
