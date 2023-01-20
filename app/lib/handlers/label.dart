part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter> with HandlerWithCursor {
  text.TextContext? _context;

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

  Future<TextElement?> openDialog(
      EventContext context, Offset localPosition) async {
    return null;

    /*final bloc = context.getDocumentBloc();
    final transform = context.getCameraTransform();
    return showDialog<LabelElement>(
        context: context.buildContext,
        builder: (_) => BlocProvider.value(
            value: bloc,
            child: EditLabelElementDialog(
              element: LabelElement(
                position: transform.localToGlobal(localPosition),
              ),
            )));*/
  }

  @override
  Widget? getToolbar(BuildContext context) {
    final cubit = context.read<DocumentBloc>();
    return LabelToolbarView(
      value: _context,
      onChanged: (value) => _change(cubit, value),
    );
  }

  @override
  Renderer createCursor(Offset position) {
    return TextCursor(TextCursorData(data, position, _context));
  }

  void _change(DocumentBloc bloc, TextContext value) {
    final context = _context;
    _context = value;
    if (context == null) return;

    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (context.element == value.element) return;
    state.currentIndexCubit.refresh(state.document);
    if (!value.isCreating) {
      bloc.add(ElementsChanged({
        value.element: [context.element]
      }));
    }
  }

  @override
  void dispose(DocumentBloc bloc) {
    _submit(bloc);
  }

  void _submit(DocumentBloc bloc) {
    final context = _context;
    if (context == null) return;
    _context = null;
    if (context.isEmpty) return;
    if (context.isCreating) {
      bloc.add(ElementsCreated([context.element]));
    }
  }
}
