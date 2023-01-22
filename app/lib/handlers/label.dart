part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter> with HandlerWithCursor {
  text.TextContext _context;

  LabelHandler(super.data) : _context = text.TextContext(painter: data);

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      [
        ...super.createForegrounds(currentIndexCubit, document, currentArea),
        if (_context.renderer != null && _context.isCreating)
          _context.renderer!,
      ];

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
    _context = value.copyWith();

    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (value.renderer == null) return;

    state.currentIndexCubit.refresh(state.document);
    if (!value.isCreating) {
      bloc.add(ElementsChanged({
        value.renderer!.element: [
          context.renderer?.element ?? value.renderer!.element
        ]
      }));
    }
  }

  @override
  void dispose(DocumentBloc bloc) {
    _submit(bloc);
  }

  void _submit(DocumentBloc bloc) {
    final context = _context;
    _context = TextContext(painter: data);
    if (context.isEmpty ?? true) return;
    final renderer = context.renderer;
    if (renderer == null) return;
    if (context.isCreating) {
      bloc.add(ElementsCreated.renderers([renderer]));
    }
  }
}
