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
  void onPointerUp(BuildContext context, PointerUpEvent event) {
    if (movingElement != null) {
      submitMove(context);
      return;
    }
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
