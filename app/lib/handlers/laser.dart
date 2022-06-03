part of 'handler.dart';

class LaserHandler extends Handler {
  Map<int, PenElement> elements = {};
  List<PenElement> submittedElements = [];
  DateTime? _lastChanged;
  Timer? _timer;

  LaserHandler(super.cubit);
  Duration _getDuration(LaserPainter painter) =>
      Duration(milliseconds: (painter.duration * 1000).round());

  void _startTimer(DocumentBloc bloc) {
    _lastChanged = DateTime.now();
    _timer?.cancel();
    final painter = cubit.fetchPainter<LaserPainter>(bloc);
    if (painter == null) return;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final DateTime now = DateTime.now();
      // Test if the last change was more than [duration] seconds ago
      final difference = now.difference(_lastChanged!);
      if (difference > _getDuration(painter)) {
        _lastChanged = null;
        submittedElements = [];
        elements = {};
        _stopTimer(bloc);
      }
      // Fade out the elements
      _updateColors(painter);
      cubit.refresh(bloc);
    });
  }

  void _updateColors(LaserPainter painter) {
    final difference = DateTime.now().difference(_lastChanged!);
    final duration = _getDuration(painter);
    submittedElements = submittedElements.map((element) {
      var color = Color(element.property.color);
      final opacity = 1 -
          ((difference.inMilliseconds / duration.inMilliseconds) *
              color.opacity);
      color = color.withOpacity(opacity.clamp(0, 1));
      return element.copyWith(
        property: element.property.copyWith(color: color.value),
      );
    }).toList();
    var color = Color(painter.color);
    // Fade out opacity
    final opacity = 1 -
        ((difference.inMilliseconds / duration.inMilliseconds) * color.opacity);
    color = color.withOpacity(opacity.clamp(0, 1));
    final colorValue = color.value;
    elements.forEach((key, element) {
      elements[key] = element.copyWith(
        property: element.property.copyWith(color: colorValue),
      );
    });
  }

  void _stopTimer(DocumentBloc bloc) {
    _timer?.cancel();
    _timer = null;
    final painter = cubit.fetchPainter<LaserPainter>(bloc);
    if (painter == null) return;
    _updateColors(painter);
  }

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
    return elements.values.map((e) => PenRenderer(e)).toList()
      ..addAll(submittedElements.map((e) => PenRenderer(e)));
  }

  @override
  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
    _startTimer(context.read<DocumentBloc>());
  }

  void addPoint(
    BuildContext context,
    int pointer,
    Offset localPosition,
    double pressure,
    PointerDeviceKind kind,
  ) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = cubit.fetchPainter<LaserPainter>(bloc);
    if (painter == null) return;
    final inputType = context.read<SettingsCubit>().state.inputType;
    if (!inputType.canCreate(pointer, elements.keys.firstOrNull, kind)) {
      return;
    }
    final element = elements[pointer] ??
        PenElement(
          layer: state.currentLayer,
          property: PenProperty(
              strokeWidth: painter.strokeWidth,
              strokeMultiplier: painter.strokeMultiplier,
              color: painter.color),
        );

    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(
              transform.localToGlobal(localPosition), pressure)));
    cubit.refresh(bloc);
    _stopTimer(bloc);
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
  @override
  int? getColor(DocumentBloc bloc) => getPainter<LaserPainter>(bloc)?.color;

  @override
  LaserPainter? setColor(DocumentBloc bloc, int color) {
    final painter = getPainter<LaserPainter>(bloc);
    if (painter == null) return null;
    return painter.copyWith(color: color);
  }
}
