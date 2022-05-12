part of 'handler.dart';

class HandHandler extends Handler {
  Renderer<PadElement>? movingElement;
  Renderer<PadElement>? selected;
  Offset? currentMovePosition;

  HandHandler(super.cubit);

  @override
  Future<bool> onRendererUpdated(
      AppDocument appDocument, Renderer old, Renderer updated) async {
    if (old.element == movingElement && updated is Renderer<PadElement>) {
      movingElement = updated;
    } else if (old == selected && updated is Renderer<PadElement>) {
      selected = updated;
    } else {
      return false;
    }
    return true;
  }

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
    if (movingElement != null) {
      final currentElement = currentMovePosition == null
          ? movingElement!.element
          : movingElement!.move(currentMovePosition!);
      final renderer = Renderer.fromInstance(currentElement);
      return [renderer];
    }
    return [];
  }

  @override
  List<Rect> createSelections(AppDocument document, [Area? currentArea]) {
    final rect = selected?.rect;
    return rect == null ? [] : [rect];
  }

  void move(BuildContext context, Renderer<PadElement> next,
      [bool duplicate = false]) {
    submitMove(context);
    movingElement = next;
    if (!duplicate) {
      final bloc = context.read<DocumentBloc>();
      bloc.add(ElementsRemoved([next.element]));
      cubit.refresh(bloc);
    }
  }

  void submitMove(BuildContext context, [PadElement? element]) {
    if (movingElement == null && element == null) return;
    final current = (element ?? movingElement?.element)!;
    movingElement = null;
    final bloc = context.read<DocumentBloc>();
    bloc.add(ElementsCreated([current]));
    cubit.refresh(bloc);
  }

  bool openView = true;

  @override
  Future<void> onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) async {
    final transform = context.read<TransformCubit>().state;
    if (movingElement != null) {
      submitMove(context,
          movingElement?.move(transform.localToGlobal(event.localPosition)));
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
      if (selected != null) return;
      if (hits.isEmpty || !(state.embedding?.editable ?? true)) {
        showContextMenu(
            context: context,
            position: event.position,
            builder: (ctx, close) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<DocumentBloc>()),
                    BlocProvider.value(value: context.read<TransformCubit>()),
                    BlocProvider.value(
                        value: context.read<CurrentIndexCubit>()),
                  ],
                  child: Actions(
                      actions: context
                              .findAncestorWidgetOfExactType<Actions>()
                              ?.actions ??
                          {},
                      child: BackgroundContextMenu(
                          position: event.position, close: close)),
                ));
      } else {
        selected = hits.first;
        cubit.refresh(bloc);
        // ignore: use_build_context_synchronously
        await showContextMenu(
            context: context,
            position: event.position,
            builder: (_, close) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: bloc),
                  BlocProvider.value(value: context.read<TransformCubit>()),
                  BlocProvider.value(value: context.read<CurrentIndexCubit>()),
                ],
                child: Actions(
                  actions: context
                          .findAncestorWidgetOfExactType<Actions>()
                          ?.actions ??
                      {},
                  child: ElementsDialog(
                      close: close,
                      elements: hits.toList(),
                      onChanged: (element) {
                        selected = element;
                        cubit.refresh(bloc);
                      },
                      position: event.position),
                ),
              );
            });
        selected = null;
        cubit.refresh(bloc);
      }
    }
  }

  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    openView = true;
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    if (openView) {
      openView = (event.delta / transform.size) == Offset.zero;
    }
    if (movingElement != null) {
      currentMovePosition = transform.localToGlobal(event.localPosition);
      cubit.refresh(bloc);
      return;
    }
    context.read<TransformCubit>().move(event.delta / transform.size);
  }

  @override
  void onPointerHover(
      Size viewportSize, BuildContext context, PointerHoverEvent event) {
    final bloc = context.read<DocumentBloc>();
    if (movingElement != null) {
      currentMovePosition = context
          .read<TransformCubit>()
          .state
          .localToGlobal(event.localPosition);
      cubit.refresh(bloc);
    }
  }
}
