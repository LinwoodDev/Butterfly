part of 'handler.dart';

class HandHandler extends Handler {
  Renderer? movingElement;
  Renderer? selected;

  HandHandler();

  @override
  Future<bool> onRendererUpdated(
      AppDocument appDocument, Renderer old, Renderer updated) async {
    if (old == movingElement) {
      movingElement = updated;
    } else if (old == selected) {
      selected = updated;
    } else {
      return false;
    }
    return true;
  }

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) =>
      [if (movingElement != null) movingElement!];

  @override
  List<Rect> createSelections(AppDocument document, [Area? currentArea]) =>
      [if (selected != null) selected!.rect];

  void move(BuildContext context, Renderer next, [bool duplicate = false]) {
    submitMove(context);
    movingElement = next;
    if (!duplicate) {
      context.read<DocumentBloc>()
        ..add(const IndexRefreshed())
        ..add(ElementsRemoved([next.element]));
    }
  }

  void submitMove(BuildContext context) {
    if (movingElement == null) return;
    final bloc = context.read<DocumentBloc>();
    bloc.add(ElementsCreated([movingElement!.element]));
    movingElement = null;
    bloc.add(const IndexRefreshed());
  }

  bool openView = true;

  @override
  Future<void> onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) async {
    final transform = context.read<TransformCubit>().state;
    if (movingElement != null) {
      movingElement =
          movingElement?.move(transform.localToGlobal(event.localPosition));
      submitMove(context);
      return;
    }
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state as DocumentLoadSuccess;
    final hand = state.document.handProperty;
    if (openView) {
      final settings = context.read<SettingsCubit>().state;
      final radius = settings.selectSensitivity / transform.size;
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
        selected = hits.first;
        bloc.add(const IndexRefreshed());
        showSelection(context, event.localPosition);
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                SelectElementDialog(renderers: hits.toList())).then((value) {
          if (value is Renderer) {
            selected = value;
            bloc.add(const IndexRefreshed());
            showSelection(context, event.localPosition);
          }
        });
      }
    }
  }

  Future<void> showSelection(BuildContext context, Offset localPosition) async {
    final bloc = context.read<DocumentBloc>();
    final transformCubit = context.read<TransformCubit>();
    var actor = context.findAncestorWidgetOfExactType<Actions>();
    await showContextMenu(
        context: context,
        position: localPosition,
        builder: (context, close) {
          Widget? menu;
          if (selected is LabelRenderer) {
            menu = LabelElementDialog(
                position: localPosition,
                renderer: selected as LabelRenderer,
                close: close);
          }
          if (selected is ImageRenderer) {
            menu = ImageElementDialog(
                position: localPosition,
                renderer: selected as ImageRenderer,
                close: close);
          }
          menu ??= GeneralElementDialog(
              position: localPosition, renderer: selected!, close: close);
          return MultiBlocProvider(providers: [
            BlocProvider.value(value: bloc),
            BlocProvider.value(value: transformCubit)
          ], child: Actions(actions: actor?.actions ?? {}, child: menu));
        });
    selected = null;
    bloc.add(const IndexRefreshed());
  }

  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    openView = true;
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    final transform = context.read<TransformCubit>().state;
    if (openView) {
      openView = (event.delta / transform.size) == Offset.zero;
    }
    if (movingElement != null) {
      return;
    }
    context.read<TransformCubit>().move(event.delta / transform.size);
  }
}
