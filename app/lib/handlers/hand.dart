part of 'handler.dart';

class GeneralHandHandler<T> extends Handler<T> {
  bool _moved = false;

  GeneralHandHandler(super.data);

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    _moved = false;
    context.refresh();
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    _moved = true;
    context.refresh();
    return false;
  }

  @override
  MouseCursor get cursor =>
      _moved ? SystemMouseCursors.grabbing : SystemMouseCursors.grab;
}

class FallbackHandler<T extends Tool> extends GeneralHandHandler<T> {
  FallbackHandler(super.data);
}

class HandHandler extends GeneralHandHandler<HandTool> {
  HandHandler([HandTool? tool]) : super(tool ?? HandTool());
}
