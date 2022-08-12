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

class EditLabelElementDialog extends StatelessWidget {
  final LabelElement element;
  final TextEditingController _textController = TextEditingController();
  EditLabelElementDialog({super.key, this.element = const LabelElement()});

  @override
  Widget build(BuildContext context) {
    var property = element.property;
    _textController.text = element.text;
    void submit() => Navigator.of(context)
        .pop(element.copyWith(text: _textController.text, property: property));
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
      child: Column(
        children: [
          Header(
            leading: const Icon(PhosphorIcons.textTLight),
            title: Text(AppLocalizations.of(context)!.enterText),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Expanded(
                    child: ListView(shrinkWrap: true, children: [
                  TextField(
                    controller: _textController,
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(filled: true),
                    onSubmitted: (value) => submit(),
                  ),
                  LabelPropertyView(
                    initialValue: property,
                    onChanged: (value) => property = value,
                  ),
                ])),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.cancel),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                      onPressed: submit,
                      child: Text(AppLocalizations.of(context)!.ok))
                ])
              ]),
            ),
          ),
        ],
      ),
    ));
  }
}
