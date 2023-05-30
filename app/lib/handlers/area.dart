part of 'handler.dart';

class AreaHandler extends Handler<AreaPainter> {
  Offset? start, end;

  AreaHandler(super.data);

  Rect? get currentRect {
    if (start == null || end == null) return null;
    return Rect.fromPoints(start!, end!);
  }

  set currentRect(Rect? value) {
    if (value == null) {
      start = null;
      end = null;
    } else {
      start = value.topLeft;
      end = value.bottomRight;
    }
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
        ...page.areas.map((e) => AreaForegroundRenderer(e)).toList()
      ],
    ];
  }

  @override
  void resetInput(DocumentBloc bloc) => currentRect = null;

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    if (details.pointerCount > 1) return true;
    final globalPosition =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);

    start = globalPosition;
    return false;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    if (details.pointerCount > 1) {
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
    if (details.pointerCount > 1) {
      currentRect = null;
      context.refresh();
      return;
    }
    final rect = currentRect;
    if (rect == null) return;
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
    context.getDocumentBloc().add(AreasCreated([
          Area(
            width: rect.width,
            height: rect.height,
            position: rect.topLeft.toPoint(),
            name: name,
          )
        ]));
    context.refresh();
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) =>
      _inspectArea(details.localPosition, context);

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) =>
      _inspectArea(details.localPosition, context);

  Future<void> _inspectArea(Offset localPosition, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    final globalPosition =
        context.getCameraTransform().localToGlobal(localPosition);
    final areas = state.page.getAreas(globalPosition);
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
      _openAreaContextMenu(buildContext, localPosition, area);
    }
  }

  void _openAreaContextMenu(
          BuildContext context, Offset localPosition, Area area) =>
      showContextMenu(
        context: context,
        position: localPosition,
        builder: (_) => BlocProvider<DocumentBloc>.value(
            value: context.read<DocumentBloc>(),
            child: AreaContextMenu(area: area)),
      );
}
