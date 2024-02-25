part of 'handler.dart';

class EyeDropperHandler extends Handler<EyeDropperTool> {
  EyeDropperHandler(super.data);

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) async {
    final globalPos =
        context.getCameraTransform().localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
    final data = await context.getCurrentIndexCubit().render(
          state.data,
          state.page,
          state.info,
          ImageExportOptions(
            width: 1,
            height: 1,
            x: globalPos.dx,
            y: globalPos.dy,
          ),
        );
    if (data == null) return;
    final image = img.decodePng(data.buffer.asUint8List());
    if (image == null) return;
    final pixel = image.getPixel(0, 0);
    final handler =
        context.getCurrentIndexCubit().getHandler(disableTemporary: true);
    if (handler is ColoredHandler) {
      final color = pixel.a.toInt() << 24 |
          pixel.r.toInt() << 16 |
          pixel.g.toInt() << 8 |
          pixel.b.toInt();
      final newTool = handler.setColor(color);
      final index = state.info.tools.indexOf(handler.data);
      context.getDocumentBloc().add(ToolsChanged({index: newTool}));
    } else {
      final color =
          pixel.r.toInt() << 16 | pixel.g.toInt() << 8 | pixel.b.toInt();
      saveToClipboard(
        context.buildContext,
        '#${color.toRadixString(16).padLeft(6, '0')}',
      );
    }
  }
}
