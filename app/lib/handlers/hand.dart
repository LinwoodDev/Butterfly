part of 'handler.dart';

class HandHandler extends Handler {
  Renderer<PadElement>? movingElement;
  Renderer<PadElement>? selected;

  HandHandler();

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
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) =>
      [if (movingElement != null) movingElement!];

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
      context.read<DocumentBloc>()
        ..add(ElementsRemoved([next.element]))
        ..add(const IndexRefreshed());
    }
  }

  void submitMove(BuildContext context, [PadElement? element]) {
    if (movingElement == null && element == null) return;
    final current = (element ?? movingElement?.element)!;
    movingElement = null;
    context.read<DocumentBloc>()
      ..add(const IndexRefreshed())
      ..add(ElementsCreated([current]));
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
        // ignore: use_build_context_synchronously
        showSelection(context, event.localPosition);
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                SelectElementDialog(renderers: hits.toList())).then((value) {
          if (value is Renderer<PadElement>) {
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
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final transformCubit = context.read<TransformCubit>();
    var actor = context.findAncestorWidgetOfExactType<Actions>();
    if (selected != null) {
      final index = state.document.content.indexOf(selected!.element);
      if (index < 0) return;
      await showContextMenu(
          context: context,
          position: localPosition,
          builder: (context, close) {
            Widget? menu;
            if (selected is LabelRenderer) {
              menu = LabelElementDialog(
                  position: localPosition, index: index, close: close);
            }
            if (selected is ImageRenderer) {
              menu = ImageElementDialog(
                  position: localPosition, index: index, close: close);
            }
            if (selected == null) {
              close();
              return Container();
            }
            menu ??= GeneralElementDialog(
                position: localPosition, index: index, close: close);
            return MultiBlocProvider(providers: [
              BlocProvider.value(value: bloc),
              BlocProvider.value(value: transformCubit)
            ], child: Actions(actions: actor?.actions ?? {}, child: menu));
          });
    }
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
