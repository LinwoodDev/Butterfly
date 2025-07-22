part of 'handler.dart';

class EraserHandler extends Handler<EraserTool> {
  bool _currentlyErasing = false;
  Offset? _currentPos, _lastErased;
  EraserHandler(super.data);
  // Called when the user presses the pointer (e.g., a finger or the mouse) on the screen. It starts the erasing action.
  @override
  Future<void> onPointerDown(PointerDownEvent event, EventContext context) {
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
  ];
  // Called when the user moves or hovers the pointer on the screen. They update the current position of the cursor and call the _changeElement method.
  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _changeElement(event.localPosition, context);
    _currentPos = event.localPosition;
    context.refresh();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }

  //method that handles the erasing logic. It determines whether an element should be erased based on its distance from the cursor and the stroke width of the eraser.
  Future<void> _changeElement(Offset position, EventContext context) async {
    final currentIndex = context.getCurrentIndex();
    final transform = currentIndex.transformCubit.state;
    final utilities = currentIndex.utilities;
    final globalPos = transform.localToGlobal(position);
    final size = data.strokeWidth;
    final shouldErase =
        _lastErased == null || (globalPos - _lastErased!).distance > size;
    final page = context.getPage();
    if (page == null) return;
    if (_currentlyErasing || !shouldErase) return;
    _currentlyErasing = true;
    _lastErased = globalPos;
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
    final modified = <String, List<PadElement>>{};
    for (final element in elements) {
      List<List<PathPoint>> paths = [[]];
      bool broken = false;
      final id = element.id;
      if (id == null) continue;
      if (element is! PenElement) {
        modified[id] = [];
        continue;
      }
      for (final point in element.points) {
        if ((point.toOffset() - globalPos).distance >= (size * size)) {
          paths.last.add(point);
          continue;
        } else {
          if (paths.last.isNotEmpty) {
            paths.add([]);
            broken = true;
          }
        }
      }
      if (broken) {
        modified[id] = [];
      }
      modified[id] = paths
          .where((element) => element.isNotEmpty)
          .map((e) => element.copyWith(points: e))
          .toList();
    }
    if (modified.isNotEmpty) {
      context.getDocumentBloc().add(ElementsChanged(modified));
    }
    _currentlyErasing = false;
  }

  // Called when the user releases the pointer. It completes the erasing action.
  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) {
    return _changeElement(event.localPosition, context);
  }

  // Returns the mouse cursor to be used when the user interacts with the eraser tool.
  @override
  MouseCursor get cursor => SystemMouseCursors.none;
}
