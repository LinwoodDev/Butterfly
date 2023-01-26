part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter>
    with HandlerWithCursor, TextInputClient {
  text.TextContext _context;

  bool get isCurrentlyEditing => _context.area != null;

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

  TextInputConnection? _connection;

  @override
  Future<void> onTapUp(TapUpDetails details, EventContext context) async {
    final pixelRatio = context.devicePixelRatio;
    FocusScope.of(context.buildContext).unfocus();
    FocusScope.of(context.buildContext)
        .requestFocus(Focus.of(context.buildContext));
    final style = Theme.of(context.buildContext).textTheme.bodyLarge!;
    _connection = TextInput.attach(
        this,
        const TextInputConfiguration(
          inputType: TextInputType.text,
          obscureText: false,
          autocorrect: true,
          inputAction: TextInputAction.done,
          keyboardAppearance: Brightness.light,
          textCapitalization: TextCapitalization.sentences,
        ))
      ..setEditingState(const TextEditingValue(text: 'A'))
      ..setStyle(
        fontFamily: style.fontFamily,
        fontSize: style.fontSize! * pixelRatio,
        fontWeight: style.fontWeight,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
    await Future.delayed(const Duration(seconds: 1));
    _connection?.show();
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

  @override
  void connectionClosed() {
    _connection = null;
  }

  @override
  // TODO: implement currentAutofillScope
  AutofillScope? get currentAutofillScope => null;

  @override
  // TODO: implement currentTextEditingValue
  TextEditingValue? get currentTextEditingValue => const TextEditingValue();

  @override
  void performAction(TextInputAction action) {
    if (kDebugMode) {
      print(action.name);
    }
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    if (kDebugMode) {
      print('Private command: $action; $data');
    }
  }

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    if (kDebugMode) {
      print('Autocorrection prompt: $start, $end');
    }
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    if (kDebugMode) {
      print('Editing value: $value');
    }
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    if (kDebugMode) {
      print('Floating cursor: $point');
    }
  }

  @override
  void didChangeInputControl(
      TextInputControl? oldControl, TextInputControl? newControl) {
    if (isCurrentlyEditing) {
      oldControl?.hide();
      newControl?.show();
    }
  }

  @override
  Map<Type, Action<Intent>> getActions(BuildContext context) {
    return {
      DeleteCharacterIntent: CallbackAction<DeleteCharacterIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Delete character');
          }
          return null;
        },
      ),
      SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Select all');
          }
          return null;
        },
      ),
    };
  }
}
