part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter> {
  LabelHandler(super.data);

  @override
  Future<void> onTapUp(TapUpDetails details, EventContext context) async {
    final pixelRatio = context.devicePixelRatio;
    final newElement = await openDialog(context, details.localPosition);
    if (newElement != null) {
      context.addDocumentEvent(ElementsCreated([newElement]));
      context
          .getDocumentBloc()
          .bake(viewportSize: context.viewportSize, pixelRatio: pixelRatio);
    }
  }

  Future<LabelElement?> openDialog(
      EventContext context, Offset localPosition) async {
    final bloc = context.getDocumentBloc();
    final transform = context.getCameraTransform();
    return await showDialog(
        context: context.buildContext,
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
