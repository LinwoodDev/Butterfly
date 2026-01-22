part of 'handler.dart';

class AreaHandler extends Handler<AreaTool> {
  final _selectionManager = RectSelectionForegroundManager(
    enableRotation: false,
  );
  Offset? _start, _end;
  Area? _currentArea;

  AreaHandler(super.data);

  Rect? getSelectionRect() => _currentArea?.rect;
  void _updateSelectionRect() => _selectionManager.select(getSelectionRect());

  Rect? get currentRect {
    if (_start == null || _end == null) return null;
    return Rect.fromPoints(_start!, _end!);
  }

  set currentRect(Rect? value) {
    _start = value?.topLeft;
    _end = value?.bottomRight;
  }

  void _updateArea() {
    final area = _currentArea;
    final transform = _selectionManager.getTransform();
    final rect = _selectionManager.selection;
    if (area == null || transform == null) return;
    _currentArea = area.copyWith(
      position: (rect.topLeft + transform.position).toPoint(),
      width: rect.width * transform.scaleX,
      height: rect.height * transform.scaleY,
    );
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == PointerDeviceKind.mouse &&
      event.buttons != kSecondaryMouseButton;

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) {
    final rect = currentRect;
    return [
      if (currentArea == null) ...[
        if (rect != null)
          AreaForegroundRenderer(
            Area(
              width: rect.width,
              height: rect.height,
              position: rect.topLeft.toPoint(),
            ),
          ),
        ...[
          _currentArea,
          ...page.areas.where((element) => element.name != _currentArea?.name),
        ].nonNulls.map((e) => AreaForegroundRenderer(e)),
      ],
      _selectionManager.renderer,
    ];
  }

  @override
  void resetInput(DocumentBloc bloc) => currentRect = null;

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    final transform = context.getCameraTransform();
    _selectionManager.updateCurrentPosition(
      transform.localToGlobal(event.localPosition),
    );
    _selectionManager.updateCursor(
      transform.size,
      context.getSettings().touchSensitivity,
    );
    context.refreshForegrounds();
  }

  @override
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    _start = null;
    context.refreshForegrounds();
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    if (currentIndex.buttons == kSecondaryMouseButton &&
        currentIndex.temporaryHandler == null) {
      return true;
    }
    final transform = context.getCameraTransform();
    var localPos = details.localFocalPoint;
    localPos = PointerManipulationHandler.calculatePointerPosition(
      currentIndex,
      localPos,
      context.viewportSize,
      transform,
    );
    final globalPos = transform.localToGlobal(localPos);
    if (_selectionManager.isValid) {
      _selectionManager.startTransform(
        globalPos,
        transform.size,
        context.getSettings().touchSensitivity,
      );
      context.refreshForegrounds();
      return true;
    }

    _start = globalPos;
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final transform = context.getCameraTransform();
    final currentIndex = context.getCurrentIndex();
    var localPos = details.localFocalPoint;
    localPos = PointerManipulationHandler.calculatePointerPosition(
      currentIndex,
      localPos,
      context.viewportSize,
      transform,
    );
    var globalPos = transform.localToGlobal(localPos);
    if (_selectionManager.isValid) {
      _selectionManager.updateCurrentPosition(globalPos);
      _updateArea();
      context.refreshForegrounds();
      return;
    }
    final start = _start;
    if (start == null) return;
    if (data.constrainedWidth != 0) {
      globalPos = Offset(data.constrainedWidth + _start!.dx, globalPos.dy);
    }
    if (data.constrainedHeight != 0) {
      globalPos = Offset(globalPos.dx, data.constrainedHeight + _start!.dy);
    }
    if (data.constrainedAspectRatio != 0) {
      final aspectRatio = data.constrainedAspectRatio;
      final width = globalPos.dx - start.dx;
      final height = globalPos.dy - start.dy;
      final currentAspectRatio = width / height;
      if (currentAspectRatio < aspectRatio) {
        globalPos = Offset(_start!.dx + height * aspectRatio, globalPos.dy);
      } else {
        globalPos = Offset(globalPos.dx, _start!.dy + width / aspectRatio);
      }
    }
    _end = globalPos;
    context.refreshForegrounds();
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails details, EventContext context) async {
    final rect = currentRect;
    if (_selectionManager.isValid) {
      _updateArea();
      final area = _currentArea;
      if (area != null) {
        context.getDocumentBloc().add(AreaChanged(area.name, area));
      }
      _selectionManager.resetTransform();
      _updateSelectionRect();
      context.refresh();
      return;
    }
    final state = context.getState();
    if (state == null || rect == null) return;
    context.refresh();
    final name = await createAreaName(
      context.buildContext,
      state.page,
      data.askForName,
    );
    if (name == null) return;
    currentRect = null;
    context.getDocumentBloc().add(
      AreasCreated([
        Area(
          width: rect.width,
          height: rect.height,
          position: rect.topLeft.toPoint(),
          name: name,
        ),
      ]),
    );
    context.refresh();
  }

  Offset? _contextMenuOffset;

  @override
  void onDoubleTapDown(TapDownDetails details, EventContext context) {
    _contextMenuOffset = details.localPosition;
  }

  @override
  void onDoubleTap(EventContext context) {
    if (_contextMenuOffset == null) return;
    _inspectArea(_contextMenuOffset!, context);
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    _currentArea = context.getPage()?.getArea(
      context.getCameraTransform().localToGlobal(details.localPosition),
    );
    _updateSelectionRect();
    context.refresh();
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) =>
      _inspectArea(details.localPosition, context);

  Future<void> _inspectArea(Offset localPosition, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    final zoom = context.getCameraTransform().size;
    final distance = context.getSettings().selectSensitivity / zoom;
    final globalPosition = context.getCameraTransform().localToGlobal(
      localPosition,
    );
    final areas = state.page.getAreas(globalPosition, distance);
    var area = areas.firstOrNull ?? state.currentArea;
    if (_selectionManager.isValid) {
      if (_selectionManager.selection.contains(globalPosition)) {
        area = _currentArea;
      }
      _selectionManager.deselect();
      _currentArea = null;
    }
    if (area == null) return;
    if (areas.length > 1) {
      area = await showDialog<Area>(
        context: context.buildContext,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).selectArea),
          scrollable: true,
          content: Column(
            children: areas
                .map(
                  (e) => ListTile(
                    title: Text(e.name),
                    onTap: () => Navigator.of(context).pop(e),
                  ),
                )
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
            ),
          ],
        ),
      );
      if (area == null) return;
    }
    var buildContext = context.buildContext;
    if (buildContext.mounted) {
      await _openAreaContextMenu(buildContext, localPosition, area);
      context.refresh();
    }
  }

  Future<void> _openAreaContextMenu(
    BuildContext context,
    Offset localPosition,
    Area area,
  ) async {
    final bloc = context.read<DocumentBloc>();
    final settingsCubit = context.read<SettingsCubit>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    return showContextMenu(
      context: context,
      position: localPosition,
      builder: buildAreaContextMenu(bloc, state, area, settingsCubit),
    );
  }

  @override
  MouseCursor? get cursor => _selectionManager.cursor;
}

Future<String?> createAreaName(
  BuildContext context,
  DocumentPage page, [
  bool askForName = true,
]) async {
  String? name = page.createAreaName(context);
  if (askForName) {
    name = await showDialog<String>(
      context: context,
      builder: (_) => NameDialog(
        value: name,
        validator: defaultNameValidator(context, page.getAreaNames().toList()),
      ),
    );
  }
  return name;
}
