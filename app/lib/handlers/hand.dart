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

  @override
  void onPointerUp(BuildContext context, PointerUpEvent event) {
    if (movingElement != null) {
      submitMove(context);
      return;
    }
  }
}
