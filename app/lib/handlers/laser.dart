part of 'handler.dart';

class LaserHandler extends Handler<LaserTool> with ColoredHandler {
  bool _hideCursorWhileDrawing = false;
  final Map<int, PenElement> _elements = {};
  final List<PenElement> _submittedElements = [];
  DateTime? _lastChanged;
  Timer? _timer;

  LaserHandler(super.data);
  Duration _getDuration() =>
      Duration(milliseconds: (data.duration * 1000).round());
  Duration _getHideDuration() =>
      Duration(milliseconds: (data.hideDuration * 1000).round());
  Duration _getFullDuration() => _getDuration() + _getHideDuration();

  void _startTimer(DocumentBloc bloc) {
    _lastChanged = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final DateTime now = DateTime.now();
      // Test if the last change was more than [duration] seconds ago
      final difference = now.difference(_lastChanged!);
      if (difference > _getFullDuration()) {
        _lastChanged = null;
        _submittedElements.clear();
        _elements.clear();
        _stopTimer();
      }
      // Fade out the elements
      bloc.refresh();
    });
  }

  PenElement _updateElement(PenElement element, Duration difference) {
    final duration = _getDuration();
    final hideDuration = _getHideDuration();
    final double delta =
        ((difference - duration).inMilliseconds / hideDuration.inMilliseconds)
            .clamp(0, 1);
    if (data.animation == LaserAnimation.path) {
      final points = element.points;
      final subPoints = points.sublist(
        (points.length * delta).round(),
        points.length,
      );
      return element.copyWith(points: subPoints);
    }
    var color = data.color;
    final toolOpacity = color.a;
    final opacity = (1 - delta) * toolOpacity;
    color = color.withValues(a: opacity.clamp(0, 1).round());
    return element.copyWith(property: element.property.copyWith(color: color));
  }

  List<PenElement> _getSubmitted() {
    final difference = _lastChanged == null
        ? Duration.zero
        : DateTime.now().difference(_lastChanged!);
    return _submittedElements
        .map((e) => _updateElement(e, difference))
        .toList();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    ..._elements.values.map((e) {
      if (e.points.length > 1) return PenRenderer(e);
      return null;
    }).nonNulls,
    ..._getSubmitted().map((e) => PenRenderer(e)),
  ];

  @override
  void resetInput(DocumentBloc bloc) {
    _submit(bloc, _elements.keys.toList());
    _elements.clear();
    _submittedElements.clear();
    _stopTimer();
  }

  void _submit(DocumentBloc bloc, List<int> indexes) {
    final elements = indexes.map((e) => _elements.remove(e)).nonNulls.toList();
    if (elements.isEmpty) return;
    _submittedElements.addAll(elements);
    bloc.refresh();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    addPoint(
      context.buildContext,
      event.pointer,
      event.localPosition,
      context.viewportSize,
      getPressureOfEvent(event),
      event.kind,
    );
    _submit(context.getDocumentBloc(), [event.pointer]);
  }

  void addPoint(
    BuildContext context,
    int pointer,
    Offset localPosition,
    Size viewportSize,
    double pressure,
    PointerDeviceKind kind, {
    bool forceCreate = false,
  }) {
    final bloc = context.read<DocumentBloc>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    localPosition = PointerManipulationHandler.calculatePointerPosition(
      currentIndexCubit.state,
      localPosition,
      viewportSize,
      transform,
    );
    if (penOnlyInput &&
        (kind != PointerDeviceKind.stylus &&
            kind != PointerDeviceKind.invertedStylus)) {
      return;
    }
    if (!_elements.containsKey(pointer) && !forceCreate) {
      return;
    }
    final element =
        _elements[pointer] ??
        PenElement(
          collection: state.currentCollection,
          property: PenProperty(
            strokeWidth: data.strokeWidth / transform.size,
            thinning: data.thinning,
            color: data.color,
          ),
        );

    _elements[pointer] = element.copyWith(
      points: List<PathPoint>.from(element.points)
        ..add(
          PathPoint.fromPoint(
            transform.localToGlobal(localPosition).toPoint(),
            pressure,
          ),
        ),
    );
    bloc.refresh();
    _startTimer(bloc);
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    _hideCursorWhileDrawing = context.getSettings().hideCursorWhileDrawing;
    context.refresh();
    final currentIndex = context.getCurrentIndex();
    if (currentIndex.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      _elements.clear();
      return;
    }
    addPoint(
      context.buildContext,
      event.pointer,
      event.localPosition,
      context.viewportSize,
      event.pressure,
      event.kind,
      forceCreate: true,
    );
  }

  @override
  Future<void> onPointerMove(
    PointerMoveEvent event,
    EventContext context,
  ) async {
    addPoint(
      context.buildContext,
      event.pointer,
      event.localPosition,
      context.viewportSize,
      event.pressure,
      event.kind,
    );
  }

  @override
  SRGBColor getColor() => data.color;

  @override
  LaserTool setColor(SRGBColor color) => data.copyWith(color: color);

  @override
  MouseCursor get cursor => (_hideCursorWhileDrawing && _elements.isNotEmpty)
      ? SystemMouseCursors.none
      : SystemMouseCursors.precise;
}
