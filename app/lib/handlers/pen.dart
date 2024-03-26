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
  // List for shapeDetection
  final points = <Offset>[];
  // For control if the pointer has not moved
  bool isDrawing = false;
  // Timer to initiate shape detection after a period of inactivity
  Timer? _positionCheckTimer;
  // Variable to store the current position of the pointer
  Offset? lastPosit;
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
    isDrawing = false;
    // Cancel the timer when the pointer is lifted, preventing shape detection
    _positionCheckTimer?.cancel();
    _positionCheckTimer = null;
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind,
        refresh: false);
    submitElements(context.getDocumentBloc(), [event.pointer]);
    points.clear();
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

// This function is called when the pointer is pressed down.
  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    isDrawing = true;
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

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    if (!isDrawing) return;
    // Check if the pointer has not moved
    if (lastPosit == event.localPosition) return;
    // Update the current position with the new position of the pointer
    lastPosit = event.localPosition;
    // Cancel any existing timer
    _positionCheckTimer?.cancel();
    // Start a new timer that will call the shape detection after a delay by data.shapeDetectionTime
    _positionCheckTimer = Timer(
        Duration(milliseconds: (data.shapeDetectionTime * 1000).round()), () {
      _tickShapeDetection(event.pointer, context, event.localPosition);
    });
    // Call the addPoint function to add a point to the current brush stroke.
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind);
    points.add(event.localPosition);
  }

  void showMessage(EventContext context, String recognizedshape) {
    // show SnackBar with recognized shape
    ScaffoldMessenger.of(context.buildContext).showSnackBar(
      SnackBar(
        width: MediaQuery.of(context.buildContext).size.width * 0.1,
        behavior: SnackBarBehavior.floating,
        content: Text(
          textAlign: TextAlign.center,
          recognizedshape,
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  // Detects shapes and draws them
  void _tickShapeDetection(
      int pointer, EventContext context, Offset localPosition) {
    final transform = context.getCameraTransform();
    // Create recognizeUnistroke
    final recognized = recognizeUnistroke(points);
    final element = elements[pointer];

    if (recognized == null || points.length > 600 || element == null) {
      return;
    }
    switch (recognized.name) {
      case DefaultUnistrokeNames.line:
        double startX = points.first.dx;
        double startY = points.first.dy;
        double endX = points.last.dx;
        double endY = points.last.dy;

        Point<double> firstPosition = Point(startX, startY);
        Point<double> secondPosition = Point(endX, endY);

        // Convert coordinates from the document coordinate system to the view coordinate system
        Offset firstPositionInView =
            transform.localToGlobal(firstPosition.toOffset());
        Offset secondPositionInView =
            transform.localToGlobal(secondPosition.toOffset());

        // Create new shape element
        PadElement shapeElement = PadElement.shape(
          firstPosition: firstPositionInView.toPoint(),
          secondPosition: secondPositionInView.toPoint(),
          property: ShapeProperty(
              shape: const LineShape(),
              color: data.property.color,
              strokeWidth: data.property.strokeWidth),
        );

        // Show dialog
        showMessage(context, AppLocalizations.of(context.buildContext).line);

        // Add element on document
        context.getDocumentBloc().add(ElementsCreated([shapeElement]));

        elements.clear();
        context.refresh();

      case DefaultUnistrokeNames.circle:
        // Calculate the center of the circle as the average of the points
        double centerX =
            points.map((p) => p.dx).reduce((a, b) => a + b) / points.length;
        double centerY =
            points.map((p) => p.dy).reduce((a, b) => a + b) / points.length;
        Offset center = Offset(centerX, centerY);

        // Calculate the radius as the average of the distances of the points from the center
        double radius =
            points.map((p) => (p - center).distance).reduce((a, b) => a + b) /
                points.length;

        Point<double> firstPosition =
            Point<double>(center.dx - radius, center.dy - radius);
        Point<double> secondPosition =
            Point<double>(center.dx + radius, center.dy + radius);

        // Convert coordinates from the document coordinate system to the view coordinate system
        Offset firstPositionInView =
            transform.localToGlobal(firstPosition.toOffset());
        Offset secondPositionInView =
            transform.localToGlobal(secondPosition.toOffset());

        // Create new ShapeElement
        PadElement shapeElement = PadElement.shape(
          firstPosition: firstPositionInView.toPoint(),
          secondPosition: secondPositionInView.toPoint(),
          property: ShapeProperty(
              shape: const CircleShape(),
              color: data.property.color,
              strokeWidth: data.property.strokeWidth),
        );

        // Show dialog
        showMessage(context, AppLocalizations.of(context.buildContext).circle);

        // Add element on document
        context.getDocumentBloc().add(ElementsCreated([shapeElement]));

        elements.clear();
        context.refresh();

      case DefaultUnistrokeNames.rectangle:
        double minX = points.map((p) => p.dx).reduce(min);
        double maxX = points.map((p) => p.dx).reduce(max);
        double minY = points.map((p) => p.dy).reduce(min);
        double maxY = points.map((p) => p.dy).reduce(max);

        Point<double> firstPosition = Point(minX, minY);
        Point<double> secondPosition = Point(maxX, maxY);

        // Convert coordinates from the document coordinate system to the view coordinate system
        Offset firstPositionInView =
            transform.localToGlobal(firstPosition.toOffset());
        Offset secondPositionInView =
            transform.localToGlobal(secondPosition.toOffset());

        // Create new ShapeElement
        PadElement shapeElement = PadElement.shape(
          firstPosition: firstPositionInView.toPoint(),
          secondPosition: secondPositionInView.toPoint(),
          property: ShapeProperty(
              shape: const RectangleShape(),
              color: data.property.color,
              strokeWidth: data.property.strokeWidth),
        );

        // Show dialog
        showMessage(
            context, AppLocalizations.of(context.buildContext).rectangle);

        // Add element on document
        context.getDocumentBloc().add(ElementsCreated([shapeElement]));

        elements.clear();
        context.refresh();

      case DefaultUnistrokeNames.triangle:
        double minX = points.map((p) => p.dx).reduce(min);
        double maxX = points.map((p) => p.dx).reduce(max);
        double minY = points.map((p) => p.dy).reduce(min);
        double maxY = points.map((p) => p.dy).reduce(max);

        Point<double> firstPosition = Point(minX, minY);
        Point<double> secondPosition = Point(maxX, maxY);

        // Convert coordinates from the document coordinate system to the view coordinate system
        Offset firstPositionInView =
            transform.localToGlobal(firstPosition.toOffset());
        Offset secondPositionInView =
            transform.localToGlobal(secondPosition.toOffset());

        // Create new ShapeElement
        PadElement shapeElement = PadElement.shape(
          firstPosition: firstPositionInView.toPoint(),
          secondPosition: secondPositionInView.toPoint(),
          property: ShapeProperty(
              shape: const TriangleShape(),
              color: data.property.color,
              strokeWidth: data.property.strokeWidth),
        );

        // Show dialog
        showMessage(
            context, AppLocalizations.of(context.buildContext).triangle);

        // Add element on document
        context.getDocumentBloc().add(ElementsCreated([shapeElement]));

        elements.clear();
        context.refresh();

      default: // Manage custom shapes here
    }
    // Reset the points list for the next shape detection
    points.clear();
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
