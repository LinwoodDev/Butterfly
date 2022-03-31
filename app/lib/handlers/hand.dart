part of 'handler.dart';

class HandHandler extends Handler {
  PadElement? movingElement;
  PadElement? selected;

  HandHandler();

  @override
  List<Rect> createSelections() => [if (selected != null) selected!.rect];

  void move(BuildContext context, PadElement next) {
    submitMove(context);
    movingElement = next;
  }

  void submitMove(BuildContext context) {
    if (movingElement == null) return;
    context.read<DocumentBloc>().add(ElementsCreated([movingElement!]));
  }

  bool openView = true;

  @override
  Future<void> onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) async {
    if (movingElement != null) {
      submitMove(context);
      return;
    }
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state as DocumentLoadSuccess;
    final hand = state.document.handProperty;
    if (openView) {
      final settings = context.read<SettingsCubit>().state;
      final transform = context.read<TransformCubit>().state;
      final radius = settings.selectSensitivity / transform.size;
      final elements = state.document.content;
      final hits = await rayCast(
          context, event.localPosition, radius, hand.includeEraser);
      if (hits.isEmpty) {
        showContextMenu(
            context: context,
            position: event.position,
            builder: (ctx, close) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<DocumentBloc>()),
                    BlocProvider.value(value: context.read<TransformCubit>()),
                  ],
                  child: Actions(
                      actions: context
                              .findAncestorWidgetOfExactType<Actions>()
                              ?.actions ??
                          {},
                      child: BackgroundContextMenu(
                          position: event.position, close: close)),
                ));
      } else if (hits.length == 1) {
        selected = elements[hits.first];
        bloc.add(const IndexRefreshed());
        showSelection(context, event.localPosition);
      } else {
        showDialog(
            context: context,
            builder: (context) => SelectElementDialog(
                elements: hits.map((e) => elements[e]).toList())).then((value) {
          if (value is PadElement) {
            selected = value;
            bloc.add(const IndexRefreshed());
            showSelection(context, event.localPosition);
          }
        });
      }
    }
    openView = true;
  }

  Future<void> showSelection(BuildContext context, Offset localPosition) async {
    final bloc = context.read<DocumentBloc>();
    final transformCubit = context.read<TransformCubit>();
    var index = 0;
    var actor = context.findAncestorWidgetOfExactType<Actions>();
    await showContextMenu(
        context: context,
        position: localPosition,
        builder: (context, close) {
          Widget? menu;
          if (selected is LabelElement) {
            menu = LabelElementDialog(
                position: localPosition, index: index, close: close);
          }
          if (selected is ImageElement) {
            menu = ImageElementDialog(
                position: localPosition, index: index, close: close);
          }
          menu ??= GeneralElementDialog(
              position: localPosition, index: index, close: close);
          return MultiBlocProvider(providers: [
            BlocProvider.value(value: bloc),
            BlocProvider.value(value: transformCubit)
          ], child: Actions(actions: actor?.actions ?? {}, child: menu));
        });
    selected = null;
    bloc.add(const IndexRefreshed());
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    final transform = context.read<TransformCubit>().state;
    if (openView) {
      openView = (event.delta / transform.size) == Offset.zero;
    }
    context.read<TransformCubit>().move(event.delta / transform.size);
  }
}
