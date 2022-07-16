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
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state as DocumentLoadSuccess;
    final transform = context.read<TransformCubit>().state;
    final globalPosition = transform.localToGlobal(event.localPosition);
    final area = state.document.getArea(globalPosition);
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    if (area != null || state.currentArea != null) {
      showContextMenu(
        position: event.position,
        context: context,
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
              area: (state.currentArea ?? area)!,
            )),
      );
      return;
    }
    final position = transform.localToGlobal(event.localPosition);
    currentRect = Rect.fromLTWH(position.dx, position.dy, 0, 0);
    if (state.document.getAreaByRect(currentRect!) != null) {
      currentRect = null;
      return;
    }
    bloc.refresh();
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    if (currentRect == null) return;
    final transform = context.read<TransformCubit>().state;
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final position = transform.localToGlobal(event.localPosition);
    _setRect(state.document, position);
  }

  Future<String?> _showAreaLabelDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.enterName),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.name,
                  filled: true,
                ),
                controller: controller,
              ),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.cancel),
                  onPressed: () => Navigator.pop(context, null),
                ),
                ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.ok),
                  onPressed: () => Navigator.pop(context, controller.text),
                ),
              ],
            ));
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
        final smallest = nextHeight > nextWidth ? nextWidth : nextHeight;
        width = data.constrainedAspectRatio * smallest;
        height = smallest / data.constrainedAspectRatio;
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
    final nextRect = Rect.fromLTWH(
        width < 0 ? currentRect!.left + width : currentRect!.left,
        height < 0 ? currentRect!.top + height : currentRect!.top,
        width.abs(),
        height.abs());
    if (document.getAreaByRect(nextRect) != null) {
      currentRect = nextRect;
    }
  }

  @override
  Future<void> onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) async {
    if (currentRect == null) return;
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = context.read<DocumentBloc>().state as DocumentLoadSuccess;
    final position = transform.localToGlobal(event.localPosition);
    if (state.document.getAreaByRect(currentRect!) != null) {
      currentRect = null;
      bloc.refresh();
      return;
    }
    _setRect(state.document, position);
    final name = await _showAreaLabelDialog(context);
    if (name == null) {
      currentRect = null;
      bloc.refresh();
      return;
    }

    bloc.add(AreaCreated(Area(
        name: name,
        width: currentRect!.width,
        height: currentRect!.height,
        position: currentRect!.topLeft)));
    bloc.refresh();
    currentRect = null;
  }
}
