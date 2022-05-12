part of 'handler.dart';

class LabelHandler extends Handler {
  LabelHandler(super.cubit);

  @override
  Future<void> onTapUp(
      Size viewportSize, BuildContext context, TapUpDetails details) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final newElement = await openDialog(context, details.localPosition);
    if (newElement != null) {
      bloc
        ..add(ElementsCreated([newElement]))
        ..add(ImageBaked(viewportSize, transform, pixelRatio));
    }
  }

  Future<LabelElement?> openDialog(
      BuildContext context, Offset localPosition) async {
    final bloc = context.read<DocumentBloc>();
    final painter = cubit.fetchPainter<LabelPainter>(bloc);
    if (painter == null) return null;
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
