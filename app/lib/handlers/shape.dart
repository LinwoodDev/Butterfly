part of 'handler.dart';

class ShapeHandler extends Handler {
  Map<int, ShapeElement> elements = {};
  List<ShapeElement> submittedElements = [];

  ShapeHandler(super.cubit);

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
      bloc
        ..add(ElementsCreated(current))
        ..add(
            ImageBaked(cameraTransform: context.read<TransformCubit>().state));
      submittedElements.clear();
    }
    cubit.refresh(bloc);
  }

  void addShape(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      [bool refresh = true]) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = cubit.fetchPainter<ShapePainter>(bloc);
    final globalPosition = transform.localToGlobal(localPosition);
    if (painter == null) return;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    double zoom = painter.zoomDependent ? transform.size : 1;

    final element = elements[pointer] ??
        ShapeElement(
          layer: state.currentLayer,
          firstPosition: globalPosition,
          secondPosition: globalPosition,
          property: painter.property.copyWith(
            strokeWidth: painter.property.strokeWidth / zoom,
          ),
        );

    elements[pointer] = element.copyWith(
      secondPosition: globalPosition,
    );
    if (refresh) cubit.refresh(bloc);
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
  int? getColor(DocumentBloc bloc) =>
      getPainter<ShapePainter>(bloc)?.property.color;

  @override
  ShapePainter? setColor(DocumentBloc bloc, int color) {
    final painter = getPainter<ShapePainter>(bloc);
    if (painter == null) return null;
    return painter.copyWith(property: painter.property.copyWith(color: color));
  }
}
