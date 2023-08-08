part of 'handler.dart';

class GeneralMoveHandler<T> extends Handler<T> {
  bool _moved = false;

  GeneralMoveHandler(super.data);

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    context
        .getCurrentIndexCubit()
        .move(details.focalPointDelta / context.getCameraTransform().size);
    _moved = true;
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    if (_moved) {
      context.bake();
    }
    _moved = false;
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    _moved = false;
    return false;
  }

  @override
  MouseCursor get cursor =>
      _moved ? SystemMouseCursors.grabbing : SystemMouseCursors.grab;
}

class MoveHandler extends GeneralMoveHandler<MovePainter?> {
  MoveHandler([super.data]);
}
