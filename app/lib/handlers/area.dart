part of 'handler.dart';

class AreaHandler extends Handler {
  Rect? currentArea;
  @override
  List<Renderer> createForegrounds(AppDocument document) => [
        if (currentArea != null)
          AreaRenderer(Area(
              width: currentArea!.width,
              height: currentArea!.height,
              position: currentArea!.topLeft)),
        ...document.areas.map((e) => AreaRenderer(e)).toList()
      ];
  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    final transform = context.read<TransformCubit>().state;
    final position = transform.localToGlobal(event.localPosition);
    currentArea = Rect.fromLTWH(position.dx, position.dy, 0, 0);
    context.read<DocumentBloc>().add(const IndexRefreshed());
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {}
}
