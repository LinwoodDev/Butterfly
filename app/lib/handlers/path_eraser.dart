part of 'handler.dart';

class PathEraserHandler extends Handler {
  @override
  Future<void> onPointerMove(
      BuildContext context, PointerMoveEvent event) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = state.currentPainter as PathEraserPainter;
    final elements = state.document.content;
    final hits = await rayCast(
        context, event.localPosition, painter.strokeWidth / transform.size);
    bloc.add(ElementsRemoved(hits.map((e) => elements[e]).toList()));
  }
}
