part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter> {
  LabelHandler(super.data);

  @override
  Future<void> onTapUp(
      Size viewportSize, BuildContext context, TapUpDetails details) async {
    final bloc = context.read<DocumentBloc>();
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final newElement = await openDialog(context, details.localPosition);
    if (newElement != null) {
      bloc.add(ElementsCreated([newElement]));
      bloc.bake(viewportSize: viewportSize, pixelRatio: pixelRatio);
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
  int? getColor(DocumentBloc bloc) => data.property.color;

  @override
  LabelPainter? setColor(DocumentBloc bloc, int color) =>
      data.copyWith(property: data.property.copyWith(color: color));
}
