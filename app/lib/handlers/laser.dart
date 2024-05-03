part of 'handler.dart';

class LaserHandler extends Handler<LaserTool> with ColoredHandler {
  final Map<int, PenElement> elements = {};
  final List<PenElement> submittedElements = [];
  DateTime? _lastChanged;
  Timer? _timer;

  LaserHandler(super.data);
  Duration _getDuration() =>
      Duration(milliseconds: (data.duration * 1000).round());

  void _startTimer(DocumentBloc bloc) {
    _lastChanged = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final DateTime now = DateTime.now();
      // Test if the last change was more than [duration] seconds ago
      final difference = now.difference(_lastChanged!);
      if (difference > _getDuration()) {
        _lastChanged = null;
        submittedElements.clear();
        elements.clear();
        _stopTimer();
      }
      // Fade out the elements
      _updateColors();
      bloc.refresh();
    });
  }

  void _updateColors() {
    final difference = _lastChanged == null
        ? Duration.zero
        : DateTime.now().difference(_lastChanged!);
    final duration = _getDuration();
    var color = Color(data.color);
    final toolOpacity = color.opacity;
    submittedElements.forEachIndexed((index, element) {
      var color = Color(element.property.color);
      final opacity =
          (1 - (difference.inMilliseconds / duration.inMilliseconds)) *
              toolOpacity;
      color = color.withOpacity(opacity.clamp(0, 1));
      submittedElements[index] = element.copyWith(
        property: element.property.copyWith(color: color.value),
      );
    });
    // Fade out opacity
    final opacity =
        (1 - (difference.inMilliseconds / duration.inMilliseconds)) *
            toolOpacity;
    color = color.withOpacity(opacity.clamp(0, 1));
    final colorValue = color.value;
    elements.forEach((key, element) {
      elements[key] = element.copyWith(
        property: element.property.copyWith(color: colorValue),
      );
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _updateColors();
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      elements.values
          .map((e) {
            if (e.points.length > 1) return PenRenderer(e);
            return null;
          })
          .whereType<Renderer>()
          .toList()
        ..addAll(submittedElements.map((e) => PenRenderer(e)));

  @override
  void resetInput(DocumentBloc bloc) {
    _submit(bloc, elements.keys.toList());
    elements.clear();
    submittedElements.clear();
    _stopTimer();
  }

  void _submit(DocumentBloc bloc, List<int> indexes) {
    final elements =
        indexes.map((e) => this.elements.remove(e)).whereNotNull().toList();
    if (elements.isEmpty) return;
    submittedElements.addAll(elements);
    bloc.refresh();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    addPoint(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind);
    _submit(context.getDocumentBloc(), [event.pointer]);
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      {bool forceCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    final viewport = currentIndexCubit.state.cameraViewport;
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    localPosition =
        viewport.utilities.getPointerPosition(localPosition, currentIndexCubit);
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    if (!elements.containsKey(pointer) && !forceCreate) {
      return;
    }
    final element = elements[pointer] ??
        PenElement(
          layer: state.currentLayer,
          property: PenProperty(
              strokeWidth: data.strokeWidth / transform.size,
              thinning: data.thinning,
              color: data.color),
        );

    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromPoint(
              transform.localToGlobal(localPosition).toPoint(), pressure)));
    bloc.refresh();
    _startTimer(bloc);
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    if (currentIndex.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      elements.clear();
      return;
    }
    addPoint(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind,
        forceCreate: true);
  }

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    addPoint(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind);
  }

  @override
  int getColor() => data.color;

  @override
  LaserTool setColor(int color) => data.copyWith(color: color);

  @override
  MouseCursor get cursor => SystemMouseCursors.precise;
}
