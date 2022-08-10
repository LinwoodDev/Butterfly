part of 'handler.dart';

class LaserHandler extends Handler {
  Map<int, PenElement> elements = {};
  List<PenElement> submittedElements = [];
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
        submittedElements = [];
        elements = {};
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
    final painterOpacity = color.opacity;
    submittedElements = submittedElements.map((element) {
      var color = Color(element.property.color);
      final opacity =
          (1 - (difference.inMilliseconds / duration.inMilliseconds)) *
              painterOpacity;
      color = color.withOpacity(opacity.clamp(0, 1));
      return element.copyWith(
        property: element.property.copyWith(color: color.value),
      );
    }).toList();
    // Fade out opacity
    final opacity =
        (1 - (difference.inMilliseconds / duration.inMilliseconds)) *
            painterOpacity;
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

  bool _moving = false;

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    if (_moving) {
      _moving = false;
      return;
    }
    addPoint(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind);
    var element = elements.remove(event.pointer);
    if (element == null) return;
    submittedElements.add(element);
    context.refresh();
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      {bool forceCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
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
              strokeWidth: data.strokeWidth,
              strokeMultiplier: data.strokeMultiplier,
              color: data.color),
        );

    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(
              transform.localToGlobal(localPosition), pressure)));
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
    if (kSecondaryMouseButton == event.buttons) {
      _moving = true;
      return;
    }
    addPoint(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind);
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    if (kSecondaryMouseButton == event.buttons) {
      final transform = context.getCameraTransform();
      context.getTransformCubit().move(event.localDelta / transform.size);
      return;
    }
    addPoint(context.buildContext, event.pointer, event.localPosition,
        event.pressure, event.kind);
  }

  @override
  int? getColor(DocumentBloc bloc) => data.color;

  @override
  LaserPainter? setColor(DocumentBloc bloc, int color) {
    return data.copyWith(color: color);
  }
}
