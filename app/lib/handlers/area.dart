part of 'handler.dart';

class AreaHandler extends Handler {
  Rect? currentRect;

  AreaHandler(super.cubit);

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
    cubit.refresh(bloc);
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    if (currentRect == null) return;
    final transform = context.read<TransformCubit>().state;
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state as DocumentLoadSuccess;
    final position = transform.localToGlobal(event.localPosition);
    final nextRect = Rect.fromLTWH(currentRect!.left, currentRect!.top,
        position.dx - currentRect!.left, position.dy - currentRect!.top);
    if (state.document.getAreaByRect(nextRect) == null) {
      currentRect = nextRect;
      cubit.refresh(bloc);
    }
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
      cubit.refresh(bloc);
      return;
    }
    final nextRect = Rect.fromLTWH(currentRect!.left, currentRect!.top,
        position.dx - currentRect!.left, position.dy - currentRect!.top);
    if (state.document.getAreaByRect(nextRect) != null) {
      currentRect = nextRect;
    }
    final name = await _showAreaLabelDialog(context);
    if (name == null) {
      currentRect = null;
      cubit.refresh(bloc);
      return;
    }

    bloc.add(AreaCreated(Area(
        name: name,
        width: currentRect!.width,
        height: currentRect!.height,
        position: currentRect!.topLeft)));
    cubit.refresh(bloc);
    currentRect = null;
  }
}
