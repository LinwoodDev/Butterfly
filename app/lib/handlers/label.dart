part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter>
    with HandlerWithCursor, TextInputClient {
  TextContext? _context;
  DocumentBloc? _bloc;

  bool get isCurrentlyEditing => _context?.area != null;

  LabelHandler(super.data);

  TextContext _createContext([Point<double>? position, double zoom = 1]) {
    return TextContext(
      painter: data,
      isCreating: true,
      element: position == null
          ? null
          : TextElement(
              position: position,
              area: text.TextArea(
                paragraph: text.TextParagraph.text(
                  property: _context?.forcedProperty ??
                      const text.ParagraphProperty.undefined(),
                ),
              ),
              styleSheet: data.styleSheet,
              scale: data.zoomDependent ? 1 / zoom : 1,
            ),
      textPainter: TextPainter(),
      forcedProperty: _context?.forcedProperty,
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
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final hitRect = _context?.getRect();
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);
    final hit = hitRect?.contains(globalPos) ?? false;
    if (hit) {
      final position = _context!.textPainter.getPositionForOffset(globalPos -
          Offset(
            hitRect!.left,
            hitRect.top,
          ));
      _context = _context!.copyWith(
        selection: TextSelection.collapsed(offset: position.offset),
      );
      context.refresh();
    }
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final hitRect = _context?.getRect();
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);
    final hit = hitRect?.contains(globalPos) ?? false;
    if (hit) {
      final position = _context!.textPainter.getPositionForOffset(globalPos -
          Offset(
            hitRect!.left,
            hitRect.top,
          ));
      _context = _context!.copyWith(
        selection: TextSelection(
          baseOffset: _context!.selection.baseOffset,
          extentOffset: position.offset,
        ),
      );
      context.refresh();
    }
  }

  @override
  Future<void> onTapUp(TapUpDetails details, EventContext context) async {
    final pixelRatio = context.devicePixelRatio;
    final focusNode = Focus.of(context.buildContext);
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localPosition);
    final hitRect = _context?.getRect();
    final hit = hitRect?.contains(globalPos) ?? false;
    final hadFocus = focusNode.hasFocus && !hit;
    FocusScope.of(context.buildContext).requestFocus(focusNode);
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
    if (hadFocus || _context?.element == null) {
      if (_context?.element != null) _submit(context.getDocumentBloc());
      _context = _createContext(
          globalPos.toPoint(), context.getCameraTransform().size);
    }
    if (hit) {
      final position = _context!.textPainter.getPositionForOffset(globalPos -
          Offset(
            hitRect!.left,
            hitRect.top,
          ));
      _context = _context!.copyWith(
        selection: TextSelection.collapsed(
          offset: position.offset,
        ),
      );
    }
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
  Widget? getToolbar(DocumentBloc bloc) {
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
    _context = value;
    if (context == null) return;

    if (context.element != null && value.element != null) {
      if (!value.isCreating) {
        bloc.add(ElementsChanged({
          context.element!: [value.element!]
        }));
      }
    }
    if (context.painter != value.painter) {
      bloc.add(PaintersChanged({data: value.painter}));
    }
    bloc.refresh();
    _refreshToolbar(bloc);
  }

  void _refreshToolbar(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is DocumentLoaded) {
      state.currentIndexCubit.refreshToolbar(bloc);
    }
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
    if (element != null) {
      if (context.isCreating) {
        bloc.add(ElementsCreated([element]));
      } else if (isEmpty) {
        bloc.add(ElementsRemoved([element]));
      }
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
    switch (action) {
      case TextInputAction.newline:
      case TextInputAction.done:
        _updateText('\n');
        break;
      default:
    }
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {}

  @override
  void showAutocorrectionPromptRect(int start, int end) {}

  @override
  void updateEditingValue(TextEditingValue value) {
    if (_context == null) return;
    _updateText(value.text);
  }

  void _updateText(String value) {
    TextElement element;
    final old = _context?.element;
    final state = _bloc?.state;
    if (state is! DocumentLoadSuccess) return;
    final document = state.data;

    var newIndex = value.length;

    if (old != null) {
      final selection = _context!.selection;
      final start = selection.start;
      final length = selection.end - start;
      final newSpan = _context?.getDefinedForcedSpanProperty(document) !=
          _context!.getSpanProperty(document);
      final paragraph = newSpan
          ? old.area.paragraph.replace(
              text.TextSpan.text(
                text: value,
                property: _context?.forcedSpanProperty ??
                    const text.SpanProperty.undefined(),
              ),
              start,
              length)
          : old.area.paragraph.replaceText(value, start, length);
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
    if (_bloc != null) _refreshToolbar(_bloc!);
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}

  @override
  void didChangeInputControl(
      TextInputControl? oldControl, TextInputControl? newControl) {
    if (isCurrentlyEditing) {
      oldControl?.hide();
      newControl?.show();
    }
  }

  int _getVerticalNewSelection(bool forward) {
    final selection = _context?.selection.start ?? 0;
    final paragraph = _context?.area?.paragraph;
    if (paragraph == null) return selection;
    var nextLine = paragraph.nextLineIndex(selection);
    final currentLine = paragraph.previousLineIndex(selection);
    if (nextLine <= 0) nextLine = paragraph.length + 1;
    var nextNextLine = paragraph.nextLineIndex(nextLine + 1);
    if (nextNextLine <= nextLine) {
      nextNextLine = paragraph.length + 2;
      nextLine = paragraph.length;
    }
    var nextLineLength = nextNextLine - nextLine + 1;
    final previousLine = paragraph.previousLineIndex(max(currentLine, 0));
    var previousLineLength = max(currentLine - previousLine, 0);
    final lineSelection = min(max(selection - currentLine, 1),
        forward ? nextLineLength : previousLineLength);
    return (forward ? nextLine + lineSelection : previousLine + lineSelection)
        .clamp(0, paragraph.length);
  }

  @override
  Map<Type, Action<Intent>> getActions(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return {
      DeleteCharacterIntent: CallbackAction<DeleteCharacterIntent>(
        onInvoke: (intent) {
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
          _refreshToolbar(bloc);
          return null;
        },
      ),
      ExtendSelectionVerticallyToAdjacentLineIntent:
          CallbackAction<ExtendSelectionVerticallyToAdjacentLineIntent>(
        onInvoke: (intent) {
          _context = _context?.copyWith(
            selection: intent.collapseSelection
                ? TextSelection.collapsed(
                    offset: _getVerticalNewSelection(intent.forward),
                  )
                : TextSelection(
                    baseOffset: _getVerticalNewSelection(intent.forward),
                    extentOffset: _context?.selection.extentOffset ?? 0,
                  ),
          );
          bloc.refresh();
          return null;
        },
      ),
      SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
        onInvoke: (intent) {
          final length = _context?.area?.length ?? 0;
          _context = _context?.copyWith(
            selection: TextSelection(
              baseOffset: length,
              extentOffset: 0,
            ),
            forcedSpanProperty:
                _context?.element?.area.paragraph.getSpan(length)?.property ??
                    _context?.forcedSpanProperty,
            forceParagraph: null,
          );
          bloc.refresh();
          _refreshToolbar(bloc);
          return null;
        },
      ),
      ExtendSelectionByCharacterIntent:
          CallbackAction<ExtendSelectionByCharacterIntent>(
        onInvoke: (intent) {
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
            forcedSpanProperty: _context?.element?.area.paragraph
                    .getSpan(selection.baseOffset)
                    ?.property ??
                _context?.forcedSpanProperty,
            forceParagraph: null,
          );
          bloc.refresh();
          _refreshToolbar(bloc);
          return null;
        },
      ),
      ExtendSelectionToLineBreakIntent:
          CallbackAction<ExtendSelectionToLineBreakIntent>(
        onInvoke: (intent) {
          final newSelection = _getVerticalNewSelection(intent.forward);
          final selection = _context?.selection;
          if (selection == null) return null;
          _context = _context?.copyWith(
            selection: TextSelection(
              baseOffset: selection.baseOffset,
              extentOffset: newSelection,
            ),
          );
          return null;
        },
      ),
      DeleteToNextWordBoundaryIntent:
          CallbackAction<DeleteToNextWordBoundaryIntent>(
        onInvoke: (intent) {
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
          _refreshToolbar(bloc);
          return null;
        },
      ),
      CopySelectionTextIntent: CallbackAction<CopySelectionTextIntent>(
        onInvoke: (intent) {
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
          Clipboard.getData(Clipboard.kTextPlain).then((value) {
            if (value == null) return;
            _updateText(value.text ?? '');
            _refreshToolbar(bloc);
          });
          return null;
        },
      ),
    };
  }
}
