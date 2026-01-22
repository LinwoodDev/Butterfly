part of 'handler.dart';

class EraserHandler extends Handler<EraserTool> {
  bool _currentlyErasing = false;
  Future<void>? _erasingFuture;
  Offset? _currentPos, _lastErased;
  final Map<String, List<PadElement>> _pendingChanges = {};

  EraserHandler(super.data);
  // Called when the user presses the pointer (e.g., a finger or the mouse) on the screen. It starts the erasing action.
  @override
  Future<void> onPointerDown(PointerDownEvent event, EventContext context) {
    _pendingChanges.clear();
    return _changeElement(event.localPosition, context);
  }

  // Creates the cursors for the eraser. It shows an eraser cursor when the user is erasing.
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
    ..._pendingChanges.values.expand(
      (elements) => elements.map((e) => Renderer.fromInstance(e)),
    ),
  ];

  @override
  Map<String, RendererState> get rendererStates => Map.fromEntries(
    _pendingChanges.keys.map((e) => MapEntry(e, RendererState.hidden)),
  );

  // Called when the user moves or hovers the pointer on the screen. They update the current position of the cursor and call the _changeElement method.
  @override
  Future<void> onPointerMove(
    PointerMoveEvent event,
    EventContext context,
  ) async {
    _currentPos = event.localPosition;
    context.refreshForegrounds();
    await _changeElement(event.localPosition, context);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refreshForegrounds();
  }

  //method that handles the erasing logic. It determines whether an element should be erased based on its distance from the cursor and the stroke width of the eraser.
  Future<void> _changeElement(Offset position, EventContext context) async {
    final currentIndex = context.getCurrentIndex();
    final transform = currentIndex.transformCubit.state;
    final utilities = currentIndex.utilities;
    final globalPos = transform.localToGlobal(position);
    final size = data.strokeWidth;
    final sizeSquared = size * size;
    final shouldErase =
        _lastErased == null ||
        (globalPos - _lastErased!).distanceSquared > sizeSquared;
    final page = context.getPage();
    if (page == null) return;
    if (_currentlyErasing || !shouldErase) return;
    _currentlyErasing = true;
    _lastErased = globalPos;
    final future = () async {
      final ray = await context.getDocumentBloc().rayCast(
        globalPos,
        size,
        useCollection: utilities.lockCollection,
        useLayer: utilities.lockLayer,
      );
      var elements = ray.map((e) => e.element);
      if (!data.eraseElements) {
        elements = elements.where((e) => e.isStroke());
      }

      final limitSquared = sizeSquared;
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

      if (anyChanged) {
        context.refreshForegrounds();
      }
    }();
    _erasingFuture = future;
    await future;
    _erasingFuture = null;
    _currentlyErasing = false;
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

  // Called when the user releases the pointer. It completes the erasing action.
  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    if (_erasingFuture != null) await _erasingFuture;
    await _changeElement(event.localPosition, context);
    if (_pendingChanges.isNotEmpty) {
      context.getDocumentBloc().add(ElementsChanged(Map.from(_pendingChanges)));
      _pendingChanges.clear();
    }
  }

  // Returns the mouse cursor to be used when the user interacts with the eraser tool.
  @override
  MouseCursor get cursor => SystemMouseCursors.none;
}
