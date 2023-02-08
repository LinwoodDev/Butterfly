part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter>
    with HandlerWithCursor, TextInputClient {
  text.TextContext? _context;
  DocumentBloc? _bloc;

  bool get isCurrentlyEditing => _context?.area != null;

  LabelHandler(super.data);

  text.TextContext _createContext([Offset? position]) {
    if (_context != null) {
      return _context!.copyWith(
        isCreating: true,
        element: position == null
            ? null
            : TextElement(
                position: position,
                area: const text.TextArea(
                  paragraph: text.TextParagraph.text(),
                ),
              ),
      );
    }
    return text.TextContext(
      painter: data,
      isCreating: true,
      element: position == null
          ? null
          : TextElement(
              position: position,
              area: const text.TextArea(
                paragraph: text.TextParagraph.text(),
              ),
            ),
    );
  }

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      [
        ...super.createForegrounds(currentIndexCubit, document, currentArea),
        if (_context?.element != null && (_context?.isCreating ?? false))
          TextRenderer(_context!.element!, _context!.selection)
      ];

  TextInputConnection? _connection;

  @override
  Future<void> onTapUp(TapUpDetails details, EventContext context) async {
    final pixelRatio = context.devicePixelRatio;
    FocusScope.of(context.buildContext)
        .requestFocus(Focus.of(context.buildContext));
    final style = Theme.of(context.buildContext).textTheme.bodyLarge!;
    if (!(_connection?.attached ?? false)) {
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
    }
    _bloc = context.getDocumentBloc();
    _connection!.show();

    _context = _createContext(
        context.getCameraTransform().localToGlobal(details.localPosition));
    context.refresh();
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
    final bloc = context.read<DocumentBloc>();
    _context ??= _createContext();
    return LabelToolbarView(
      value: _context!,
      onChanged: (value) => _change(bloc, value),
    );
  }

  @override
  Renderer createCursor(Offset position) {
    return TextCursor(TextCursorData(data, position, _context));
  }

  void _change(DocumentBloc bloc, text.TextContext value) {
    final context = _context;
    _context = value.copyWith();

    if (context != null && context.element != null && value.element != null) {
      if (!value.isCreating) {
        bloc.add(ElementsChanged({
          context.element!: [value.element!]
        }));
      }
    }
    bloc.refresh();
  }

  @override
  void dispose(DocumentBloc bloc) {
    _connection?.close();
    _connection = null;
    _submit(bloc);
  }

  void _submit(DocumentBloc bloc) {
    final context = _context;
    if (context == null) return;
    final element = context.element;
    if (context.isCreating && element != null) {
      bloc.add(ElementsCreated([element]));
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
  TextEditingValue? get currentTextEditingValue => TextEditingValue(
        selection:
            _context?.selection ?? const TextSelection.collapsed(offset: 0),
      );

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
    if (_context == null) return;
    final textSpans = [
      text.TextSpan.text(
        text: value.text,
      ),
    ];
    TextElement element;
    final old = _context?.element;
    if (old != null) {
      final paragraph = old.area.paragraph.copyWith(
        textSpans: textSpans,
        property: _context!.forcedProperty ?? old.area.paragraph.property,
      );
      final area = old.area.copyWith(
        paragraph: paragraph,
      );
      element = old.copyWith(area: area);
    } else {
      final paragraph = text.TextParagraph.text(
        textSpans: textSpans,
        property: _context!.forcedProperty ??
            const text.ParagraphProperty.undefined(),
      );
      final area = text.TextArea(
        paragraph: paragraph,
      );
      element = TextElement(area: area);
    }
    _context = _context!.copyWith(
      element: element,
    );
    _bloc?.refresh();
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
      ExtendSelectionByCharacterIntent:
          CallbackAction<ExtendSelectionByCharacterIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Extend selection by character');
          }
          _context = _context?.copyWith();
          return null;
        },
      ),
    };
  }
}
