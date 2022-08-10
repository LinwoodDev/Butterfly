part of 'handler.dart';

class HandHandler extends Handler<HandProperty> {
  Renderer<PadElement>? movingElement;
  Renderer<PadElement>? selected;
  bool _hasMoved = false;
  Offset? currentMovePosition;

  HandHandler(super.data);

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
      bloc.refresh();
    }
  }

  void submitMove(BuildContext context, [PadElement? element]) {
    if (movingElement == null && element == null) return;
    final current = (element ?? movingElement?.element)!;
    movingElement = null;
    final bloc = context.read<DocumentBloc>();
    bloc.add(ElementsCreated([current]));
    bloc.refresh();
  }

  bool openView = true;
  int? _firstPointer;

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final transform = context.getCameraTransform();
    _firstPointer = null;
    if (movingElement != null) {
      submitMove(context.buildContext,
          movingElement?.move(transform.localToGlobal(event.localPosition)));
      return;
    }
    final state = context.getState();
    if (state == null) return;
    final hand = state.document.handProperty;
    if (openView) {
      final settings = context.getSettings();
      final radius = settings.selectSensitivity / transform.size;
      final hits = await rayCast(context.buildContext, event.localPosition,
          radius, hand.includeEraser);
      if (selected != null) return;
      if (hits.isEmpty || !(state.embedding?.editable ?? true)) {
        showContextMenu(
            context: context.buildContext,
            position: event.position,
            builder: (ctx, close) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.getDocumentBloc()),
                    BlocProvider.value(value: context.getTransformCubit()),
                    BlocProvider.value(value: context.getCurrentIndexCubit()),
                  ],
                  child: Actions(
                      actions: context.buildContext
                              .findAncestorWidgetOfExactType<Actions>()
                              ?.actions ??
                          {},
                      child: BackgroundContextMenu(
                          position: event.position, close: close)),
                ));
      } else {
        selected = hits.first;
        context.refresh();
        // ignore: use_build_context_synchronously
        await showContextMenu(
            context: context.buildContext,
            position: event.position,
            builder: (_, close) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.getDocumentBloc()),
                  BlocProvider.value(value: context.getTransformCubit()),
                  BlocProvider.value(value: context.getCurrentIndexCubit()),
                ],
                child: Actions(
                  actions: context.buildContext
                          .findAncestorWidgetOfExactType<Actions>()
                          ?.actions ??
                      {},
                  child: ElementsDialog(
                      close: close,
                      elements: hits.toList(),
                      onChanged: (element) {
                        selected = element;
                        context.refresh();
                      },
                      position: event.position),
                ),
              );
            });
        selected = null;
        context.refresh();
      }
    }
    if (_hasMoved) {
      _hasMoved = false;
      context.bake();
    }
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    final index = context.getCurrentIndex();
    openView = true;
    _firstPointer ??= event.pointer;
    if (index.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      openView = false;
    }
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    final index = context.getCurrentIndex();
    final transform = context.getCameraTransform();
    if (openView) {
      openView = (event.delta / transform.size) == Offset.zero;
    }
    if (index.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      openView = false;
    }
    if (movingElement != null) {
      currentMovePosition = transform.localToGlobal(event.localPosition);
      context.refresh();
      return;
    }
    if (_firstPointer == event.pointer) {
      context.getTransformCubit().move(event.localDelta / transform.size);
      _hasMoved = true;
    }
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    if (movingElement != null) {
      currentMovePosition =
          context.getCameraTransform().localToGlobal(event.localPosition);
      context.refresh();
    }
  }
}
