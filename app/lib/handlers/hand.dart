part of 'handler.dart';

class HandHandler extends Handler {
  PadElement? movingElement;

  HandHandler();

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
  Future<void> onPointerUp(BuildContext context, PointerUpEvent event) async {
    if (movingElement != null) {
      submitMove(context);
      return;
    }
    if (openView) {
      if (kDebugMode) {
        print('Executing ray cast...');
      }
      final hits = await rayCast(context, event.localPosition);
      if (kDebugMode) {
        print('Ray cast done. Hits: $hits');
      }
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
        showSelection(context, event.localPosition, hits.first);
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                SelectElementDialog(elements: hits.toList())).then((value) {
          if (value is PadElement) {
            showSelection(context, event.localPosition, value);
          }
        });
      }
    }
    openView = true;
  }

  void showSelection(
      BuildContext context, Offset localPosition, PadElement element) {
    final bloc = context.read<DocumentBloc>();
    final transformCubit = context.read<TransformCubit>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    var index = 0;
    var actor = context.findAncestorWidgetOfExactType<Actions>();
    showContextMenu(
        context: context,
        position: localPosition,
        builder: (context, close) {
          Widget? menu;
          if (element is LabelElement) {
            menu = LabelElementDialog(
                position: localPosition, index: index, close: close);
          }
          if (element is ImageElement) {
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
  }

  @override
  void onPointerMove(BuildContext context, PointerMoveEvent event) {
    final transform = context.read<TransformCubit>().state;
    if (openView) {
      openView = (event.delta / transform.size) == Offset.zero;
    }
    context.read<TransformCubit>().move(event.delta / transform.size);
  }
}
