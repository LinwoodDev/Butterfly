part of 'handler.dart';

class ShapeHandler extends Handler {
  Map<int, ShapeElement> elements = {};
  List<ShapeElement> submittedElements = [];

  ShapeHandler(super.data);

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
    return elements.values
        .map((e) => ShapeRenderer(e)..setup(document))
        .toList()
      ..addAll(submittedElements.map((e) => ShapeRenderer(e)..setup(document)));
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    addShape(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind, false);
    submitElement(context.viewportSize, context.buildContext, event.pointer);
  }

  void _setRect(Offset nextPosition, int index) {
    final element = elements[index];
    if (element == null) return;
    final currentRect =
        Rect.fromPoints(element.firstPosition, element.secondPosition);
    double width = 0, height = 0;
    final nextWidth = nextPosition.dx - currentRect.left;
    final nextHeight = nextPosition.dy - currentRect.top;
    if (data.constrainedHeight != 0 && data.constrainedWidth != 0) {
      width = data.constrainedWidth;
      height = data.constrainedHeight;
    }
    if (data.constrainedAspectRatio != 0) {
      if (data.constrainedHeight != 0) {
        height = data.constrainedHeight;
        width = data.constrainedAspectRatio * height;
      } else if (data.constrainedWidth != 0) {
        width = data.constrainedWidth;
        height = width / data.constrainedAspectRatio;
      } else {
        final largest = nextHeight > nextWidth ? nextWidth : nextHeight;
        width = data.constrainedAspectRatio * largest;
        height = largest / data.constrainedAspectRatio;
      }
    } else {
      if (data.constrainedHeight != 0) {
        height = data.constrainedHeight;
        width = nextWidth;
      } else if (data.constrainedWidth != 0) {
        width = data.constrainedWidth;
        height = nextHeight;
      } else {
        width = nextWidth;
        height = nextHeight;
      }
    }
    final secondPosition =
        Offset(currentRect.left + width, currentRect.top + height);

    elements[index] = element.copyWith(
        firstPosition: element.firstPosition, secondPosition: secondPosition);
  }

  ShapeElement _normalizeElement(ShapeElement element) {
    var firstX = element.firstPosition.dx;
    var firstY = element.firstPosition.dy;
    var secondX = element.secondPosition.dx;
    var secondY = element.secondPosition.dy;
    if (firstX > secondX) {
      final temp = firstX;
      firstX = secondX;
      secondX = temp;
    }
    if (firstY > secondY) {
      final temp = firstY;
      firstY = secondY;
      secondY = temp;
    }
    return element.copyWith(
      firstPosition: Offset(firstX, firstY),
      secondPosition: Offset(secondX, secondY),
    );
  }

  void submitElement(Size viewportSize, BuildContext context, int index) {
    final bloc = context.read<DocumentBloc>();
    var element = elements.remove(index);
    if (element == null) return;
    submittedElements.add(_normalizeElement(element));
    if (elements.isEmpty) {
      final current = List<PadElement>.from(submittedElements);
      bloc.add(ElementsCreated(current));
      bloc.bake();
      submittedElements.clear();
    }
    bloc.refresh();
  }

  void addShape(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      [bool refresh = true]) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final globalPosition = transform.localToGlobal(localPosition);
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    double zoom = data.zoomDependent ? transform.size : 1;

    if (!elements.containsKey(pointer)) {
      elements[pointer] = ShapeElement(
        layer: state.currentLayer,
        firstPosition: globalPosition,
        secondPosition: globalPosition,
        property: data.property.copyWith(
          strokeWidth: data.property.strokeWidth / zoom,
        ),
      );
    }
    _setRect(globalPosition, pointer);
    if (refresh) bloc.refresh();
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    addShape(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind);
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) => addShape(
      context.buildContext,
      event.pointer,
      event.localPosition,
      event.pressure,
      event.kind);

  @override
  int? getColor(DocumentBloc bloc) => data.property.color;

  @override
  ShapePainter? setColor(DocumentBloc bloc, int color) =>
      data.copyWith(property: data.property.copyWith(color: color));
}
