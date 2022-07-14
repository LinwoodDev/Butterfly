part of 'handler.dart';

class PathEraserHandler extends Handler<PathEraserPainter> {
  PathEraserHandler(super.data);

  @override
  Future<void> onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final hits = await rayCast(context, event.localPosition,
        data.strokeWidth / transform.size, data.includeEraser);
    bloc.add(ElementsRemoved(hits.map((e) => e.element).toList()));
  }
}
