part of 'handler.dart';

class AreaHandler extends Handler<AreaPainter> {
  Rect? currentRect;

  AreaHandler(super.data);

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      [
        if (currentArea == null) ...[
          if (currentRect != null)
            AreaForegroundRenderer(Area(
                width: currentRect!.width,
                height: currentRect!.height,
                position: currentRect!.topLeft.toPoint())),
          ...document.areas.map((e) => AreaForegroundRenderer(e)).toList()
        ],
      ];

  @override
  void resetInput(DocumentBloc bloc) => currentRect = null;

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    if (context.getCurrentIndex().moveEnabled) {
      currentRect = null;
      context.refresh();
      return;
    }
    final bloc = context.getDocumentBloc();
    final state = context.getState();
    if (state == null) return;
    final transform = context.getCameraTransform();
    var localPosition = event.localPosition;
    final cubit = context.getCurrentIndexCubit();
    localPosition = cubit.state.cameraViewport.tool
            ?.getGridPosition(localPosition, state.document, cubit) ??
        localPosition;
    final globalPosition = transform.localToGlobal(localPosition);
    final area = state.document.getArea(globalPosition);
    final currentIndexCubit = context.getCurrentIndexCubit();
    if (area != null || state.currentArea != null) {
      showContextMenu(
        position: event.position,
        context: context.buildContext,
        builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<DocumentBloc>.value(
                value: bloc,
              ),
              BlocProvider<CurrentIndexCubit>.value(
                value: currentIndexCubit,
              ),
            ],
            child: AreaContextMenu(
              position: event.localPosition,
              area: (state.currentArea ?? area)!,
            )),
      );
      return;
    }
    currentRect = Rect.fromLTWH(globalPosition.dx, globalPosition.dy, 0, 0);
    if (state.document.getAreaByRect(currentRect!) != null) {
      currentRect = null;
      return;
    }
    context.refresh();
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    if (currentRect == null) return;
    final transform = context.getCameraTransform();
    final state = context.getState();
    if (state == null) return;
    var localPosition = event.localPosition;
    final cubit = context.getCurrentIndexCubit();
    localPosition = cubit.state.cameraViewport.tool
            ?.getGridPosition(localPosition, state.document, cubit) ??
        localPosition;
    final position = transform.localToGlobal(localPosition);
    _setRect(state.document, position);
    context.refresh();
  }

  Future<String?> _showAreaLabelDialog(BuildContext context) async {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return null;
    if (data.askForName) {
      return showDialog<String>(
          context: context,
          builder: (_) => BlocProvider.value(
              value: context.read<DocumentBloc>(),
              child: NameDialog(
                  validator: defaultNameValidator(
                      context, state.document.getAreaNames().toList()))));
    }
    var name = '', index = 1;
    while (name.isEmpty || state.document.getAreaByName(name) != null) {
      name = AppLocalizations.of(context).areaIndex(index);
      index++;
    }
    return name;
  }

  void _setRect(AppDocument document, Offset nextPosition) {
    currentRect ??= Rect.fromLTWH(nextPosition.dx, nextPosition.dy, 0, 0);
    double width = 0, height = 0;
    final nextWidth = nextPosition.dx - currentRect!.left;
    final nextHeight = nextPosition.dy - currentRect!.top;
    if (data.constrainedHeight != 0 && data.constrainedWidth != 0) {
      width = data.constrainedWidth;
      height = data.constrainedHeight;
    }
    if (data.constrainedAspectRatio != 0) {
      if (data.constrainedHeight != 0) {
        height = data.constrainedHeight;
        width = data.constrainedAspectRatio * height;
      } else if (data.constrainedWidth != 0) {
        width = data.constrainedWidth;
        height = width / data.constrainedAspectRatio;
      } else {
        final largest = nextHeight > nextWidth ? nextWidth : nextHeight;
        width = data.constrainedAspectRatio * largest;
        height = largest / data.constrainedAspectRatio;
      }
    } else {
      if (data.constrainedHeight != 0) {
        height = data.constrainedHeight;
        width = nextWidth;
      } else if (data.constrainedWidth != 0) {
        width = data.constrainedWidth;
        height = nextHeight;
      } else {
        width = nextWidth;
        height = nextHeight;
      }
    }
    final nextRect =
        Rect.fromLTWH(currentRect!.left, currentRect!.top, width, height);
    if (document.getAreaByRect(nextRect.normalized()) == null) {
      currentRect = nextRect;
    }
  }

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final transform = context.getCameraTransform();
    var localPosition = event.localPosition;
    final cubit = context.getCurrentIndexCubit();
    final state = context.getState();
    if (state == null) return;
    localPosition = cubit.state.cameraViewport.tool
            ?.getGridPosition(localPosition, state.document, cubit) ??
        localPosition;
    final position = transform.localToGlobal(localPosition);
    _setRect(state.document, position);
    currentRect = currentRect?.normalized();
    if (currentRect?.size.isEmpty ?? true) {
      currentRect = null;
      context.refresh();
      return;
    }
    if (state.document.getAreaByRect(currentRect!) != null) {
      currentRect = null;
      context.refresh();
      return;
    }
    final name = await _showAreaLabelDialog(context.buildContext);
    if (name == null) {
      currentRect = null;
      context.refresh();
      return;
    }
    if (state.document.getAreaByName(name) != null) {
      currentRect = null;
      context.refresh();
      return;
    }

    context.addDocumentEvent(AreasCreated([
      Area(
          name: name,
          width: currentRect!.width,
          height: currentRect!.height,
          position: currentRect!.topLeft.toPoint())
    ]));
    context.refresh();
    currentRect = null;
  }
}
