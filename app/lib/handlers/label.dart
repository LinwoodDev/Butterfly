part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter>
    with HandlerWithCursor, TextInputClient {
  TextContext? _context;
  DocumentBloc? _bloc;

  bool get isCurrentlyEditing => _context?.area != null;

  LabelHandler(super.data);

  TextContext _createContext([Point<double>? position]) {
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
    return TextContext(
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
      textPainter: TextPainter(),
    );
  }

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      [
        ...super.createForegrounds(currentIndexCubit, document, currentArea),
        if (_context?.element != null) ...[
          if (_context?.isCreating ?? false)
            TextRenderer(_context!.element!, _context),
          TextSelectionCursor(_context!)
        ],
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
          TextInputConfiguration(
            inputType: TextInputType.text,
            obscureText: false,
            autocorrect: true,
            inputAction: TextInputAction.newline,
            keyboardAppearance: Theme.of(context.buildContext).brightness,
            textCapitalization: TextCapitalization.sentences,
          ))
        ..setEditingState(const TextEditingValue())
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

    _context = _createContext(context
        .getCameraTransform()
        .localToGlobal(details.localPosition)
        .toPoint());
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

  void _change(DocumentBloc bloc, TextContext value) {
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
    final isEmpty = element?.area.paragraph.isEmpty ?? true;
    if (context.isCreating && element != null) {
      bloc.add(ElementsCreated([element]));
    } else if (isEmpty) {
      bloc.add(ElementsRemoved([element!]));
    }
  }

  @override
  void connectionClosed() {
    _connection = null;
  }

  @override
  AutofillScope? get currentAutofillScope => null;

  @override
  TextEditingValue? get currentTextEditingValue => null;

  @override
  void performAction(TextInputAction action) {
    if (kDebugMode) {
      print(action.name);
    }
    switch (action) {
      case TextInputAction.newline:
      case TextInputAction.done:
        _updateText('\n');
        break;
      default:
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
    if (kDebugMode) {
      print('Editing value: $value');
    }
    _updateText(value.text);
  }

  void _updateText(String value) {
    TextElement element;
    final old = _context?.element;

    var newIndex = value.length;

    if (old != null) {
      final selection =
          _context!.selection ?? const TextSelection.collapsed(offset: 0);
      final start = selection.start;
      final length = selection.end - start;
      final paragraph = old.area.paragraph.replaceText(value, start, length);
      final area = old.area.copyWith(
        paragraph: paragraph,
      );
      element = old.copyWith(area: area);
      newIndex += min(selection.start, paragraph.length);
    } else {
      final paragraph = text.TextParagraph.text(
        textSpans: [text.TextSpan.text(text: value)],
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
      selection: TextSelection.collapsed(offset: newIndex),
    );
    _connection?.setEditingState(const TextEditingValue(
      text: '',
    ));
    _bloc?.refresh();
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
    final bloc = context.read<DocumentBloc>();
    return {
      DeleteCharacterIntent: CallbackAction<DeleteCharacterIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Delete character');
          }
          final element = _context?.element;
          final selection = _context?.selection;
          if (element == null || selection == null) return null;
          var area = element.area;
          var paragraph = area.paragraph;
          var start = selection.start;
          var length = selection.end - start;
          if (length == 0) {
            if (start == 0) return null;
            if (!intent.forward) {
              start--;
            }
            length = 1;
          }
          paragraph = paragraph.remove(
            start,
            length,
          );
          area = area.copyWith(paragraph: paragraph);
          final newElement = element.copyWith(area: area);

          _context = _context!.copyWith(
            element: newElement,
            selection: TextSelection.collapsed(offset: start),
          );
          bloc.refresh();
          return null;
        },
      ),
      SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Select all');
          }
          _context = _context?.copyWith(
              selection: TextSelection(
            baseOffset: _context?.area?.length ?? 0,
            extentOffset: 0,
          ));
          bloc.refresh();
          return null;
        },
      ),
      ExtendSelectionByCharacterIntent:
          CallbackAction<ExtendSelectionByCharacterIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Extend selection by character');
          }
          final maxLength = _context?.area?.length ?? 0;
          var selection =
              _context?.selection ?? const TextSelection.collapsed(offset: 0);
          if (intent.collapseSelection) {
            selection = TextSelection.collapsed(
              offset: (selection.baseOffset + (intent.forward ? 1 : -1))
                  .clamp(0, maxLength),
            );
          } else {
            selection = TextSelection(
              baseOffset: (selection.baseOffset + (intent.forward ? 1 : -1))
                  .clamp(0, maxLength),
              extentOffset: selection.extentOffset,
            );
          }
          _context = _context?.copyWith(
            selection: selection,
          );
          bloc.refresh();
          return null;
        },
      ),
      DeleteToNextWordBoundaryIntent:
          CallbackAction<DeleteToNextWordBoundaryIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Delete to next word boundary');
          }
          final element = _context?.element;
          final selection = _context?.selection;
          if (element == null || selection == null) return null;
          var index = selection.baseOffset;
          var wordIndex = element.area.paragraph.previousWordIndex(index);
          if (wordIndex > 0) wordIndex--;
          if (wordIndex < 0) {
            index = wordIndex;
          }
          var area = element.area;
          var paragraph = area.paragraph;
          final length = selection.end - wordIndex;
          paragraph = paragraph.remove(
            wordIndex,
            length.abs(),
          );
          area = area.copyWith(paragraph: paragraph);
          final newElement = element.copyWith(area: area);

          _context = _context!.copyWith(
            element: newElement,
            selection: TextSelection.collapsed(offset: wordIndex),
          );

          bloc.refresh();
          return null;
        },
      ),
      CopySelectionTextIntent: CallbackAction<CopySelectionTextIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Copy selection');
          }
          final selection = _context?.selection;
          if (selection == null) return null;
          final text = _context?.area?.paragraph.text;
          if (text == null) return null;
          Clipboard.setData(ClipboardData(
              text: text.substring(selection.start, selection.end)));
          if (intent.collapseSelection) {
            _updateText('');
          }
          return null;
        },
      ),
      PasteTextIntent: CallbackAction<PasteTextIntent>(
        onInvoke: (intent) {
          if (kDebugMode) {
            print('Paste text');
          }
          Clipboard.getData(Clipboard.kTextPlain).then((value) {
            if (value == null) return;
            _updateText(value.text ?? '');
          });
          return null;
        },
      ),
    };
  }
}
