part of 'handler.dart';

// This class represents the handler for the PenTool.
class PenHandler extends Handler<PenTool> with ColoredHandler {
  // Map to store the PenElements.
  final Map<int, PenElement> elements = {};
  // Map to store the starting positions of each element.
  final Map<int, Offset> startPosition = {};
  // Map to store the last positions of each element.
  final Map<int, Offset> lastPosition = {};
  // Dictionary to plot the total distance traveled by each pointer
  Map<int, double> totalDistance = {};
  // Timer to track the time interval for updating the line.
  Timer? _timer;
  Offset? localPos;
  PenHandler(super.data);

  // Create foregrounds for rendering the PenRendere
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
          .toList();

  // Reset the input for the handler.
  @override
  void resetInput(DocumentBloc bloc) {
    submitElements(bloc, elements.keys.toList());
    elements.clear();
    lastPosition.clear();
  }

  // Handle the pointer release event.
  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind,
        refresh: false);
    submitElements(context.getDocumentBloc(), [event.pointer]);
  }

// Flag to check if elements are being submitted.
  bool _currentlyBaking = false;

  // Submit elements for processing and rendering.
  Future<void> submitElements(DocumentBloc bloc, List<int> indexes) async {
    final elements =
        indexes.map((e) => this.elements.remove(e)).whereNotNull().toList();
    if (elements.isEmpty) return;
    lastPosition.removeWhere((key, value) => indexes.contains(key));
    bloc.add(ElementsCreated(elements));
    if (_currentlyBaking) return;
    _currentlyBaking = true;
    await bloc.bake();
    _currentlyBaking = false;
    bloc.refresh();
  }

// Add a point to the element.
  void addPoint(BuildContext context, int pointer, Offset localPos,
      double pressure, PointerDeviceKind kind,
      {bool refresh = true, bool shouldCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    final viewport = currentIndexCubit.state.cameraViewport;
    final transform = context.read<TransformCubit>().state;
    final globalPos = transform.localToGlobal(localPos);
    if (!isInBounds(bloc, globalPos)) return;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    localPos =
        viewport.utilities.getPointerPosition(localPos, currentIndexCubit);
    if (lastPosition[pointer] == localPos) return;
    lastPosition[pointer] = localPos;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    double zoom = data.zoomDependent ? transform.size : 1;
    final createNew = !elements.containsKey(pointer);
    if (createNew && !shouldCreate) return;
    final element = elements[pointer] ??
        PenElement(
          zoom: transform.size,
          layer: state.currentLayer,
          property: data.property
              .copyWith(strokeWidth: data.property.strokeWidth / zoom),
        );
    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromPoint(
              globalPos.toPoint(), (createNew ? 0 : pressure) / zoom)));
    if (refresh) bloc.refresh();
  }

// This function updates the current line with the pointer's start and end position.
  void _tickShapeDetection(
      int pointer, EventContext context, Offset localPosition) {
    if (totalDistance[pointer] != null && totalDistance[pointer]! < 1000) {
      // Check if the last known position of the pointer has not changed since the timer started.
      if (lastPosition[pointer] == localPosition) {
        // If the position has not changed, get the PenElement associated with the pointer.
        final element = elements[pointer];
        // If the PenElement exists, update the line with the start and end position of the pointer.
        if (element != null && data.shapeDetectionEnabled == true) {
          final transform = context.getCameraTransform();
          elements[pointer] = element.copyWith(points: [
            PathPoint.fromPoint(
                transform.localToGlobal(startPosition[pointer]!).toPoint(), 0),
            PathPoint.fromPoint(
                transform.localToGlobal(lastPosition[pointer]!).toPoint(), 1)
          ]);
          // Add a small movement that allows the line to become straight
          lastPosition[pointer] = localPosition + const Offset(0.01, 0.01);
        }
      }
      _timer?.cancel();
      _timer = null;
    }
  }

// This function is called when the pointer is pressed down.
  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    // Save initial position
    startPosition[event.pointer] = event.localPosition;
    if (currentIndex.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      elements.clear();
      context.refresh();
      return;
    }
    elements.remove(event.pointer);
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind,
        shouldCreate: true);
  }

// This function calculates the pressure of the pointer.
  double _getPressure(PointerEvent event) =>
      event.kind == PointerDeviceKind.stylus
          ? (event.pressure - event.pressureMin) /
              (event.pressureMax - event.pressureMin)
          : 0.5;

  // This function is called when the pointer moves.
  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    // Calculates the distance the pointer travels
    double distance =
        (lastPosition[event.pointer]! - event.localPosition).distance;
    // Updates the total distance traveled by the pointer
    totalDistance[event.pointer] =
        (totalDistance[event.pointer] ?? 0) + distance;
    // Call the addPoint function to add a point to the current brush stroke.
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind);
    // Update the last known position of the pointer.
    lastPosition[event.pointer] = event.localPosition;

    // Start a timer that fires after 500 milliseconds.
    _timer = Timer(
        Duration(milliseconds: (data.shapeDetectionTime * 1000).round()),
        () => _tickShapeDetection(event.pointer, context, event.localPosition));
  }

  @override
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    elements.clear();
    context.refresh();
  }

  @override
  int getColor() => data.property.color;

  @override
  PenTool setColor(int color) => data.copyWith(
      property: data.property
          .copyWith(color: convertOldColor(color, data.property.color)));

  @override
  MouseCursor get cursor => SystemMouseCursors.precise;
}
