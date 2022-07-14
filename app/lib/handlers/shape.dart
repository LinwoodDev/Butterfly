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
  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {
    addShape(context, event.pointer, event.localPosition, event.pressure,
        event.kind, false);
    submitElement(viewportSize, context, event.pointer);
  }

  void submitElement(Size viewportSize, BuildContext context, int index) {
    final bloc = context.read<DocumentBloc>();
    var element = elements.remove(index);
    if (element == null) return;
    submittedElements.add(element);
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

    final element = elements[pointer] ??
        ShapeElement(
          layer: state.currentLayer,
          firstPosition: globalPosition,
          secondPosition: globalPosition,
          property: data.property.copyWith(
            strokeWidth: data.property.strokeWidth / zoom,
          ),
        );

    elements[pointer] = element.copyWith(
      secondPosition: globalPosition,
    );
    if (refresh) bloc.refresh();
  }

  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    addShape(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
  }

  @override
  void onPointerMove(
          Size viewportSize, BuildContext context, PointerMoveEvent event) =>
      addShape(context, event.pointer, event.localPosition, event.pressure,
          event.kind);

  @override
  int? getColor(DocumentBloc bloc) => data.property.color;

  @override
  ShapePainter? setColor(DocumentBloc bloc, int color) =>
      data.copyWith(property: data.property.copyWith(color: color));
}
