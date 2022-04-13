part of 'handler.dart';

class LabelHandler extends Handler {
  @override
  Future<void> onTapUp(
      Size viewportSize, BuildContext context, TapUpDetails details) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final ratio = MediaQuery.of(context).devicePixelRatio;
    final newElement = await openDialog(context, details.localPosition);
    if (newElement != null) {
      bloc
        ..add(ElementsCreated([newElement]))
        ..add(ImageBaked(viewportSize, ratio, transform));
    }
  }

  Future<LabelElement?> openDialog(
      BuildContext context, Offset localPosition) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state as DocumentLoadSuccess;
    final painter = state.currentPainter as LabelPainter;
    final transform = context.read<TransformCubit>().state;
    return await showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
            value: bloc,
            child: EditLabelElementDialog(
              element: LabelElement(
                property: painter.property,
                position: transform.localToGlobal(localPosition),
              ),
            )));
  }
}
