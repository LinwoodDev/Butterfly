part of 'handler.dart';

class PathEraserHandler extends Handler {
  PathEraserHandler(super.data);

  @override
  Future<void> onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final painter = cubit.fetchPainter<PathEraserPainter>(bloc);
    if (painter == null) return;
    final hits = await rayCast(context, event.localPosition,
        painter.strokeWidth / transform.size, painter.includeEraser);
    bloc.add(ElementsRemoved(hits.map((e) => e.element).toList()));
  }
}
