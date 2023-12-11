part of 'handler.dart';

class AreaHandler extends Handler<AreaTool> {
  Offset? start, end;

  AreaHandler(super.data);

  Rect? get currentRect {
    if (start == null || end == null) return null;
    return Rect.fromPoints(start!, end!);
  }

  set currentRect(Rect? value) {
    start = value?.topLeft;
    end = value?.bottomRight;
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == PointerDeviceKind.mouse &&
      event.buttons != kSecondaryMouseButton;

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
      NoteData document, DocumentPage page, DocumentInfo info,
      [Area? currentArea]) {
    final rect = currentRect;
    return [
      if (currentArea == null) ...[
        if (rect != null)
          AreaForegroundRenderer(Area(
              width: rect.width,
              height: rect.height,
              position: rect.topLeft.toPoint())),
        ...page.areas.map((e) => AreaForegroundRenderer(e))
      ],
    ];
  }

  @override
  void resetInput(DocumentBloc bloc) => currentRect = null;

  @override
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    start = null;
    context.refresh();
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    if (details.pointerCount > 1 ||
        currentIndex.buttons == kSecondaryMouseButton) return true;
    final globalPosition =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);

    start = globalPosition;
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    if (details.pointerCount > 1 ||
        currentIndex.buttons == kSecondaryMouseButton) {
      currentRect = null;
      context.refresh();
      return;
    }
    final globalPosition =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);

    end = globalPosition;
    context.refresh();
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails details, EventContext context) async {
    final currentIndex = context.getCurrentIndex();
    final rect = currentRect;
    if (details.pointerCount > 1 ||
        currentIndex.buttons == kSecondaryMouseButton ||
        (rect?.isEmpty ?? true)) {
      currentRect = null;
      context.refresh();
      return;
    }
    final state = context.getState();
    if (state == null) return;
    context.refresh();
    String? name = AppLocalizations.of(context.buildContext)
        .areaIndex(state.page.areas.length + 1);
    if (data.askForName) {
      name = await showDialog<String>(
          context: context.buildContext,
          builder: (_) => NameDialog(
                value: name,
                validator: defaultNameValidator(
                    context.buildContext, state.page.getAreaNames().toList()),
              ));
    }
    if (name == null) return;
    currentRect = null;
    context.getDocumentBloc().add(AreasCreated([
          Area(
            width: rect!.width,
            height: rect.height,
            position: rect.topLeft.toPoint(),
            name: name,
          )
        ]));
    context.refresh();
  }

  bool _startLongPress = false;

  @override
  void onLongPressDown(LongPressDownDetails details, EventContext context) {
    _startLongPress = details.kind != PointerDeviceKind.mouse;
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) {
    if (!_startLongPress) return;
    _inspectArea(details.localPosition, context);
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) =>
      _inspectArea(details.localPosition, context);

  Future<void> _inspectArea(Offset localPosition, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    final zoom = context.getCameraTransform().size;
    final distance = context.getSettings().selectSensitivity / zoom;
    final globalPosition =
        context.getCameraTransform().localToGlobal(localPosition);
    final areas = state.page.getAreas(globalPosition, distance);
    var area = areas.firstOrNull ?? state.currentArea;
    if (area == null) return;
    if (areas.length > 1) {
      area = await showDialog<Area>(
        context: context.buildContext,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).selectArea),
          scrollable: true,
          content: Column(
            children: areas
                .map((e) => ListTile(
                      title: Text(e.name),
                      onTap: () => Navigator.of(context).pop(e),
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context).cancel),
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
      BuildContext context, Offset localPosition, Area area) async {
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
}
