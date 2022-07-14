part of 'handler.dart';

class LabelHandler extends Handler {
  LabelHandler(super.data);

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
        ..add(ImageBaked(
            viewportSize: viewportSize,
            cameraTransform: transform,
            pixelRatio: pixelRatio));
    }
  }

  Future<LabelElement?> openDialog(
      BuildContext context, Offset localPosition) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    return await showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
            value: bloc,
            child: EditLabelElementDialog(
              element: LabelElement(
                property: data.property,
                position: transform.localToGlobal(localPosition),
              ),
            )));
  }

  @override
  int? getColor(DocumentBloc bloc) =>
      getPainter<PenPainter>(bloc)?.property.color;

  @override
  PenPainter? setColor(DocumentBloc bloc, int color) {
    final painter = getPainter<PenPainter>(bloc);
    if (painter == null) return null;
    return painter.copyWith(property: painter.property.copyWith(color: color));
  }
}
