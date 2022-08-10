part of 'handler.dart';

class AreaHandler extends Handler<AreaPainter> {
  Rect? currentRect;

  AreaHandler(super.data);

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) =>
      [
        if (currentArea == null) ...[
          if (currentRect != null)
            AreaRenderer(Area(
                width: currentRect!.width,
                height: currentRect!.height,
                position: currentRect!.topLeft)),
          ...document.areas.map((e) => AreaRenderer(e)).toList()
        ],
      ];

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    final bloc = context.getDocumentBloc();
    final state = context.getState();
    final transform = context.getCameraTransform();
    final globalPosition = transform.localToGlobal(event.localPosition);
    final area = state?.document.getArea(globalPosition);
    final currentIndexCubit = context.getCurrentIndexCubit();
    if (area != null || state?.currentArea != null) {
      showContextMenu(
        position: event.position,
        context: context.buildContext,
        builder: (context, close) => MultiBlocProvider(
            providers: [
              BlocProvider<DocumentBloc>.value(
                value: bloc,
              ),
              BlocProvider<CurrentIndexCubit>.value(
                value: currentIndexCubit,
              ),
            ],
            child: AreaContextMenu(
              close: close,
              position: event.localPosition,
              area: (state?.currentArea ?? area)!,
            )),
      );
      return;
    }
    final position = transform.localToGlobal(event.localPosition);
    currentRect = Rect.fromLTWH(position.dx, position.dy, 0, 0);
    if (state?.document.getAreaByRect(currentRect!) != null) {
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
    final position = transform.localToGlobal(event.localPosition);
    _setRect(state.document, position);
    context.refresh();
  }

  Future<String?> _showAreaLabelDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
            value: context.read<DocumentBloc>(), child: AreaLabelDialog()));
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
    final position = transform.localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
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

    context.addDocumentEvent(AreaCreated(Area(
        name: name,
        width: currentRect!.width,
        height: currentRect!.height,
        position: currentRect!.topLeft)));
    context.refresh();
    currentRect = null;
  }
}
