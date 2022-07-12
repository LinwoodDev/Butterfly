part of 'handler.dart';

class PenHandler extends Handler {
  Map<int, PenElement> elements = {};
  List<PenElement> submittedElements = [];
  Map<int, Offset> lastPosition = {};

  PenHandler(super.cubit);

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
    return elements.values
        .map((e) {
          if (e.points.length > 1) return PenRenderer(e);
          return null;
        })
        .whereType<Renderer>()
        .toList()
      ..addAll(submittedElements.map((e) => PenRenderer(e)));
  }

  @override
  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        refresh: false);
    submitElement(viewportSize, context, event.pointer);
  }

  void submitElement(Size viewportSize, BuildContext context, int index) {
    final bloc = context.read<DocumentBloc>();
    var element = elements.remove(index);
    if (element == null) return;
    lastPosition.remove(index);
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

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      {bool refresh = true, bool shouldCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = cubit.fetchPainter<PenPainter>(bloc);
    if (painter == null) return;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    if (lastPosition[pointer] == localPosition) return;
    lastPosition[pointer] = localPosition;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    double zoom = painter.zoomDependent ? transform.size : 1;

    final createNew = !elements.containsKey(pointer);

    if (createNew && !shouldCreate) return;

    final element = elements[pointer] ??
        PenElement(
          layer: state.currentLayer,
          property: painter.property
              .copyWith(strokeWidth: painter.property.strokeWidth / zoom),
        );
    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(transform.localToGlobal(localPosition),
              (createNew ? 0 : pressure) / zoom)));
    if (refresh) cubit.refresh(bloc);
  }

  @override
  void onTapDown(
      Size viewportSize, BuildContext context, TapDownDetails details) {}

  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    if (cubit.state.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      elements.clear();
      cubit.refresh(context.read<DocumentBloc>());
      return;
    }
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        shouldCreate: true);
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
  }

  @override
  int? getColor(DocumentBloc bloc) =>
      getPainter<PenPainter>(bloc)?.property.color;

  @override
  PenPainter? setColor(DocumentBloc bloc, int color) {
    final painter = getPainter<PenPainter>(bloc);
    if (painter == null) return null;
    return painter.copyWith(property: painter.property.copyWith(color: color));
  }
}
