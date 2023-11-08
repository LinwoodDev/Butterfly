part of 'handler.dart';

class EraserHandler extends Handler<EraserTool> {
  bool _currentlyErasing = false;
  Offset? _currentPos, _lastErased;
  EraserHandler(super.data);

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _changeElement(event.localPosition, context);
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        if (_currentPos != null)
          EraserCursor(
              ToolCursorData(EraserInfo.fromEraser(data), _currentPos!))
      ];

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

  Future<void> _changeElement(Offset position, EventContext context) async {
    final globalPos = context.getCameraTransform().localToGlobal(position);
    final size = data.strokeWidth;
    final shouldErase =
        _lastErased == null || (globalPos - _lastErased!).distance > size;
    final page = context.getPage();
    if (page == null) return;
    if (!_currentlyErasing && shouldErase) {
      _lastErased = globalPos;
      _currentlyErasing = true;
      // Raycast
      final ray = await rayCast(globalPos, context.getDocumentBloc(),
          context.getCameraTransform(), size);
      final elements = ray.map((e) => e.element).whereType<PenElement>();
      final modified = <int, List<PadElement>>{};
      for (final element in elements) {
        List<List<PathPoint>> paths = [[]];
        for (final point in element.points) {
          if ((point.toOffset() - globalPos).distance > size) {
            paths.last.add(point);
            continue;
          } else if (paths.last.isNotEmpty) {
            paths.add([]);
          }
        }
        if (paths.length <= 1) continue;
        final index = page.content.indexOf(element);
        modified[index] = paths
            .where((element) => element.isNotEmpty)
            .map((e) => element.copyWith(points: e))
            .toList();
      }
      if (modified.isNotEmpty) {
        context.getDocumentBloc().add(ElementsChanged(modified));
        await context.getDocumentBloc().stream.first;
      }
      _currentlyErasing = false;
    }
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    _changeElement(event.localPosition, context);
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.precise;
}
