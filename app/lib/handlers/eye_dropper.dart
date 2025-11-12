part of 'handler.dart';

class EyeDropperHandler extends Handler<EyeDropperTool> {
  EyeDropperHandler(super.data);

  @override
  FutureOr<SelectState> onSelected(
    BuildContext context, [
    bool wasAdded = true,
  ]) {
    if (!wasAdded) {
      context.read<CurrentIndexCubit>().changeTemporaryHandler(
        context,
        data,
        temporaryState: TemporaryState.removeAfterRelease,
      );
    }
    return super.onSelected(context);
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) async {
    final globalPos = context.getCameraTransform().localToGlobal(
      event.localPosition,
    );
    final state = context.getState();
    if (state == null) return;
    final data = await context.getCurrentIndexCubit().render(
      state.data,
      state.page,
      state.info,
      ImageExportOptions(width: 1, height: 1, x: globalPos.dx, y: globalPos.dy),
    );
    if (data == null) return;
    final image = img.decodePng(data.buffer.asUint8List());
    if (image == null) return;
    final pixel = image.getPixel(0, 0);
    final handler = context.getCurrentIndexCubit().getHandler(
      disableTemporary: true,
    );
    final color = SRGBColor.from(
      r: pixel.r.toInt(),
      g: pixel.g.toInt(),
      b: pixel.b.toInt(),
    );
    if (handler is ColoredHandler) {
      handler.changeToolColor(context.getDocumentBloc(), color);
    } else {
      saveToClipboard(
        context.buildContext,
        color.toHexString(alpha: false),
        leading: ColorButton(color: color.toColor().withAlpha(255), size: 32),
      );
    }
  }
}
