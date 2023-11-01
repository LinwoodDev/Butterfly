part of 'handler.dart';

class EyeDropperHandler extends Handler<EyeDropperTool> {
  EyeDropperHandler(super.data);

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localPosition);
    final state = context.getState();
    if (state == null) return;
    final data = await context.getCurrentIndexCubit().render(
          state.data,
          state.page,
          state.info,
          width: 1,
          height: 1,
          x: globalPos.dx,
          y: globalPos.dy,
        );
    if (data == null) return;
    final image = img.Image.fromBytes(width: 1, height: 1, bytes: data.buffer);
    final pixel = image.getPixel(0, 0);
    final color = pixel.r.toInt() << 24 |
        pixel.g.toInt() << 16 |
        pixel.b.toInt() << 8 |
        pixel.a.toInt();
    Clipboard.setData(ClipboardData(
      text: '#${color.toRadixString(16).padLeft(8, '0').toUpperCase()}',
    ));
  }
}
