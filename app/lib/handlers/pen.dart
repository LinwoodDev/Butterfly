part of 'handler.dart';

class PenHandler extends Handler {
  Map<int, PenElement> elements = {};
  List<PenElement> submittedElements = [];

  PenHandler(CurrentIndexCubit cubit) : super(cubit);

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
    return elements.values.map((e) => PenRenderer(e)).toList()
      ..addAll(submittedElements.map((e) => PenRenderer(e)));
  }

  @override
  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind, false);
    submitElement(viewportSize, context, event.pointer);
  }

  void submitElement(Size viewportSize, BuildContext context, int index) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    var element = elements.remove(index);
    if (element == null) return;
    submittedElements.add(element);
    if (elements.isEmpty) {
      bloc
        ..add(ElementsCreated(List<PadElement>.from(submittedElements)))
        ..add(ImageBaked(
            viewportSize, transform, MediaQuery.of(context).devicePixelRatio));
      submittedElements.clear();
    }
    cubit.refresh(bloc);
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      [bool refresh = true]) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = cubit.fetchPainter<PenPainter>(bloc);
    if (painter == null) return;
    final inputType = context.read<SettingsCubit>().state.inputType;
    if (!inputType.canCreate(pointer, elements.keys.firstOrNull, kind)) {
      return;
    }
    double zoom = painter.zoomDependent ? transform.size : 1;

    final element = elements[pointer] ??
        PenElement(
          layer: state.currentLayer,
          property: painter.property
              .copyWith(strokeWidth: painter.property.strokeWidth / zoom),
        );

    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(
              transform.localToGlobal(localPosition), pressure / zoom)));
    if (refresh) cubit.refresh(bloc);
  }

  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
  }

  @override
  void onPointerMove(
          Size viewportSize, BuildContext context, PointerMoveEvent event) =>
      addPoint(context, event.pointer, event.localPosition, event.pressure,
          event.kind);
}
