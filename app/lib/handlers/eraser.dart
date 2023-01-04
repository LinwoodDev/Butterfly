part of 'handler.dart';

class EraserHandler extends Handler<EraserPainter> {
  Map<PenElement, List<PenElement>> _elements = {};
  bool _currentlyErasing = false;
  Offset? _currentPos;
  EraserHandler(super.data);

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _changeElement(event.localPosition, context);
  }

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      [
        if (_currentPos != null) EraserCursor(PainterCursor(data, _currentPos!))
      ];

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
    _changeElement(event.localPosition, context);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }

  Future<void> _changeElement(Offset position, EventContext context) async {
    final globalPos = context.getCameraTransform().localToGlobal(position);
    final size = data.property.strokeWidth;
    if (!_currentlyErasing) {
      _currentlyErasing = true;
      // Raycast
      final ray = await rayCast(globalPos, context.buildContext, size);
      final newElements = ray
          .map((e) => e.element)
          .whereType<PenElement>()
          .where((element) => !_elements.containsKey(element));
      _elements
          .addAll(Map.fromEntries(newElements.map((e) => MapEntry(e, [e]))));
      _currentlyErasing = false;
    }
    _elements = _elements.map((key, value) {
      return MapEntry<PenElement, List<PenElement>>(
          key,
          value.expand((element) {
            List<List<PathPoint>> paths = [[]];
            for (final point in element.points) {
              if ((point.toOffset() - globalPos).distance > size) {
                // If so, add to last path
                paths.last.add(point);
              } else if (paths.last.isNotEmpty) {
                paths.add([]);
              }
            }
            return paths
                .where((element) => element.isNotEmpty)
                .map((e) => element.copyWith(points: e));
          }).toList());
    });
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    _changeElement(event.localPosition, context);
    context.addDocumentEvent(ElementsChanged(_elements));
  }
}
