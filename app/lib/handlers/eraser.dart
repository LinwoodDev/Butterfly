part of 'handler.dart';

class EraserHandler extends Handler<EraserPainter> {
  PenElement? _element;
  List<PenElement> _changed = const [];
  EraserHandler(super.data);

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _element = (await rayCast(
      context.getCameraTransform().localToGlobal(event.localPosition),
      context.buildContext,
      1,
    ))
        .whereType<Renderer<PenElement>>()
        .firstOrNull
        ?.element;
    if (_element != null) {
      _changed = [_element!];
    }
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _changeElement(event.localPosition, context);
  }

  void _changeElement(Offset position, EventContext context) {
    final globalPos = context.getCameraTransform().localToGlobal(position);
    _changed = _changed.expand((element) {
      final pointIndex = element.points
          .indexWhere((point) => (point.toOffset() - globalPos).distance == 0);
      if (pointIndex != -1) {
        // Split in two elements
        final newFirst = element.copyWith(
          points: element.points.sublist(0, pointIndex),
        );
        final newSecond = element.copyWith(
          points: element.points.sublist(pointIndex + 1),
        );
        return [
          if (newFirst.points.isNotEmpty) newFirst,
          if (newSecond.points.isNotEmpty) newSecond,
        ];
      }
      return [element];
    }).toList();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    if (_element != null) {
      context.addDocumentEvent(ElementsChanged({
        _element!: _changed,
      }));
    }
    _element = null;
    _changed = const [];
  }
}
