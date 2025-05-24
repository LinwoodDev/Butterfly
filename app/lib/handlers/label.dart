part of 'handler.dart';

class LabelHandler extends Handler<LabelTool>
    with HandlerWithCursor, TextInputClient {
  LabelContext? _context;
  DocumentBloc? _bloc;

  bool get isCurrentlyEditing => _context?.element != null;

  LabelHandler(super.data);

  LabelContext _createContext(
    NoteData document, {
    Point<double>? position,
    double zoom = 1,
    LabelElement? element,
  }) {
    final scale = (data.zoomDependent ? 1 / zoom : 1.0) * data.scale;
    final mode = element != null
        ? (element is TextElement ? LabelMode.text : LabelMode.markdown)
        : data.mode;
    final styleSheet = data.styleSheet;
    switch (mode) {
      case LabelMode.text:
        final forced = switch (_context) {
          TextContext e => e.forcedProperty,
          _ => null,
        };
        return TextContext(
          tool: data,
          element:
              (element as TextElement?) ??
              (position == null
                  ? null
                  : TextElement(
                      position: position,
                      area: text.TextArea(
                        paragraph: text.TextParagraph(
                          property:
                              forced ??
                              const text.ParagraphProperty.undefined(),
                        ),
                      ),
                      styleSheet: styleSheet,
                      scale: scale,
                      foreground: data.foreground,
                      id: createUniqueId(),
                    )),
          textPainter: TextPainter(),
          forcedProperty: forced,
        );
      case LabelMode.markdown:
        return MarkdownContext(
          tool: data,
          element:
              (element as MarkdownElement?) ??
              (position == null
                  ? null
                  : MarkdownElement(
                      position: position,
                      text: '',
                      styleSheet: styleSheet,
                      scale: scale,
                      foreground: data.foreground,
                    )),
          textPainter: TextPainter(),
        );
    }
  }

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    ...super.createForegrounds(
      currentIndexCubit,
      document,
      page,
      info,
      currentArea,
    ),
    if (_context?.element != null) ...[
      if (_context?.isCreating ?? false)
        switch (_context!) {
          TextContext e =>
            TextRenderer(e.element!, null, e) as GenericTextRenderer,
          MarkdownContext e => MarkdownRenderer(e.element!, null, e),
        },
      LabelSelectionCursor(_context!),
    ],
  ];

  TextInputConnection? _connection;

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final hitRect = _context?.getRect();
    final globalPos = context.getCameraTransform().localToGlobal(
      details.localFocalPoint,
    );
    final hit = hitRect?.contains(globalPos) ?? false;
    if (hit) {
      final position = _context!.textPainter.getPositionForOffset(
        globalPos - Offset(hitRect!.left, hitRect.top),
      );
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
    final globalPos = context.getCameraTransform().localToGlobal(
      details.localFocalPoint,
    );
    final hit = hitRect?.contains(globalPos) ?? false;
    if (hit) {
      final position = _context!.textPainter.getPositionForOffset(
        globalPos - Offset(hitRect!.left, hitRect.top),
      );
      _context = _context!.copyWith(
        selection: TextSelection(
          baseOffset: _context!.selection.baseOffset,
          extentOffset: position.offset,
        ),
      );
      _refreshToolbar(context.getDocumentBloc());
      context.refresh();
    }
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) =>
      create(context, details.localPosition, context.isShiftPressed);

  Offset _doubleTapPos = Offset.zero;

  @override
  void onDoubleTapDown(TapDownDetails details, EventContext context) =>
      _doubleTapPos = details.localPosition;

  @override
  void onDoubleTap(EventContext context) =>
      create(context, _doubleTapPos, true);

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == PointerDeviceKind.mouse &&
      event.buttons != kSecondaryMouseButton;

  Future<void> create(
    EventContext context,
    Offset localPosition, [
    bool forceCreate = false,
  ]) async {
    final currentIndex = context.getCurrentIndex();
    localPosition = PointerManipulationHandler.calculatePointerPosition(
      currentIndex,
      localPosition,
      context.viewportSize,
      context.getCameraTransform(),
    );
    final pixelRatio = context.devicePixelRatio;
    final state = context.getState();
    final document = state?.data;
    if (document == null) return;
    final focusNode = Focus.of(context.buildContext);
    final globalPos = context.getCameraTransform().localToGlobal(localPosition);
    final hitRect = _context?.getRect();
    final hit = hitRect?.contains(globalPos) ?? false;
    final hadFocus = focusNode.hasFocus && !hit;
    FocusScope.of(context.buildContext).requestFocus(focusNode);
    final theme = Theme.of(context.buildContext);
    final style = theme.textTheme.bodyLarge!;
    if (hadFocus || _context?.element == null) {
      if (_context?.element != null) _submit(context.getDocumentBloc());
      final hit = await context.getDocumentBloc().rayCast(
        globalPos,
        0.0,
        useCollection: true,
      );
      final labelRenderer = hit.whereType<Renderer<LabelElement>>().firstOrNull;
      if (labelRenderer == null) {
        _context = _createContext(
          document,
          position: globalPos.toPoint(),
          zoom: context.getCameraTransform().size,
        );
      } else {
        final page = context.getPage();
        if (page == null) return;
        final id = (labelRenderer.element as PadElement).id;
        if (id == null) return;
        context.getDocumentBloc().add(ElementsRemoved([id]));
        _context = _createContext(document, element: labelRenderer.element);
      }
    }
    if (hit) {
      final position = _context!.textPainter.getPositionForOffset(
        globalPos - Offset(hitRect!.left, hitRect.top),
      );
      _context = _context!.copyWith(
        selection: TextSelection.collapsed(offset: position.offset),
      );
    }
    if (!(_connection?.attached ?? false)) {
      _connection =
          TextInput.attach(
              this,
              TextInputConfiguration(
                inputType: TextInputType.text,
                obscureText: false,
                autocorrect: false,
                inputAction: TextInputAction.newline,
                keyboardAppearance: theme.brightness,
                enableDeltaModel: false,
                enableSuggestions: false,
                enableInteractiveSelection: true,
              ),
            )
            ..setEditingState(currentTextEditingValue)
            ..setStyle(
              fontFamily: style.fontFamily,
              fontSize: style.fontSize! * pixelRatio,
              fontWeight: style.fontWeight,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.left,
            );
    } else {
      _updateEditingState();
    }
    _bloc = context.getDocumentBloc();
    _connection!.show();
    _refreshToolbar(_bloc!);
    context.refresh();
  }

  Future<TextElement?> openDialog(
    EventContext context,
    Offset localPosition,
  ) async {
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
  PreferredSizeWidget? getToolbar(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return null;
    _context ??= _createContext(state.data);
    return LabelToolbarView(
      value: _context!,
      onChanged: (value) => _change(bloc, value),
    );
  }

  @override
  Renderer createCursor(Offset position) {
    return LabelCursor(LabelCursorData(data, position, _context));
  }

  void _change(DocumentBloc bloc, LabelContext value) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final context = _context;
    _context = value;
    if (context == null) return;
    final id = context.element?.id;

    if (context.element != null && value.element != null && id != null) {
      if (!value.isCreating) {
        bloc.add(
          ElementsChanged({
            id: [value.element!],
          }),
        );
      }
    }
    if (context.tool != value.tool) {
      changeTool(bloc, value.tool);
    }
    bloc.refresh();
    _refreshToolbar(bloc);
    _updateEditingState();
  }

  Future<void> _refreshToolbar(DocumentBloc bloc) async =>
      bloc.state.currentIndexCubit?.refreshToolbar(bloc);

  @override
  void dispose(DocumentBloc bloc) {
    _connection?.close();
    _connection = null;
    _submit(bloc);
  }

  void _submit(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final context = _context;
    if (context == null) return;
    final element = context.element;
    if (element == null) return;
    final id = element.id;
    final isEmpty = context.isEmpty;
    if (context.isCreating && !isEmpty) {
      bloc.add(ElementsCreated([element]));
    } else if (!context.isCreating && isEmpty && id != null) {
      bloc.add(ElementsRemoved([id]));
      bloc.delayedBake();
    }
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) =>
      _onContextMenu(details.localPosition, context);
  bool _startLongPress = false;

  @override
  void onLongPressDown(LongPressDownDetails details, EventContext context) {
    _startLongPress = details.kind != PointerDeviceKind.mouse;
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) {
    if (!_startLongPress) return;
    _onContextMenu(details.localPosition, context);
  }

  Future<void> _onContextMenu(
    Offset localPosition,
    EventContext context,
  ) async {
    if (_context == null) return;
    showModal(
      context: context.buildContext,
      useRootNavigator: true,
      builder: (context) => AdaptiveTextSelectionToolbar.editable(
        clipboardStatus: ClipboardStatus.pasteable,
        onLiveTextInput: () {
          _connection?.show();
          Navigator.of(context).pop();
        },
        onCopy: () {
          _copyText(false);
          Navigator.of(context).pop();
        },
        onCut: () {
          _copyText(true);
          Navigator.of(context).pop();
        },
        onPaste: () {
          _pasteText();
          Navigator.of(context).pop();
        },
        onSelectAll: () {
          _selectAllText();
          Navigator.of(context).pop();
        },
        anchors: TextSelectionToolbarAnchors(primaryAnchor: localPosition),
        onLookUp: null,
        onSearchWeb: null,
        onShare: () {
          SharePlus.instance.share(ShareParams(text: _context?.text ?? ''));
        },
      ),
    );
  }

  @override
  void connectionClosed() {
    _connection?.connectionClosedReceived();
    _connection = null;
  }

  @override
  AutofillScope? get currentAutofillScope => null;

  @override
  TextEditingValue get currentTextEditingValue {
    final context = _context;
    if (context == null) return const TextEditingValue();
    final state = _bloc?.state;
    if (state is! DocumentLoaded) return const TextEditingValue();
    final element = context.element;
    final text = context.text;
    if (element == null || text == null) return const TextEditingValue();
    (int, int) getTextProperty(TextElement e) {
      final indexed = e.area.paragraph.getIndexedSpan(
        context.selection.start,
        false,
      );
      if (indexed == null) return (0, text.length);
      return (indexed.index, indexed.model.length);
    }

    var (indexed, length) = switch (element) {
      TextElement e => getTextProperty(e),
      _ => (0, text.length),
    };
    if (switch (context) {
      TextContext e => e.shouldNewSpan(state.data),
      _ => false,
    }) {
      indexed = min(context.selection.start, text.length);
      length = 0;
    }
    final end = min(indexed + length, text.length);

    return TextEditingValue(
      text: text,
      selection: TextSelection(
        baseOffset: context.selection.baseOffset.clamp(0, text.length),
        extentOffset: context.selection.extentOffset.clamp(0, text.length),
        affinity: context.selection.affinity,
        isDirectional: context.selection.isDirectional,
      ),
      composing: TextRange(start: indexed, end: end),
    );
  }

  void _updateEditingState() {
    if (!(_connection?.attached ?? false)) {
      _connection = null;
    }
    _connection?.setEditingState(currentTextEditingValue);
  }

  @override
  void performAction(TextInputAction action) {
    switch (action) {
      case TextInputAction.newline:
      case TextInputAction.done:
        if (HardwareKeyboard.instance.isControlPressed) {
          _newElement();
        } else {
          _updateText('\n', false);
        }
        break;
      default:
    }
  }

  Future<void> _newElement() async {
    final bloc = _bloc;
    final state = bloc?.state;
    if (bloc == null || state is! DocumentLoadSuccess) return;
    final oldContext = _context;
    if (oldContext == null) return;
    await _updateText('\n', false);
    final element = _context?.labelElement;
    if (element == null) return;
    var newPosition = element.position;

    final caret =
        _context?.textPainter.getOffsetForCaret(
          TextPosition(offset: oldContext.length + 1),
          Rect.zero,
        ) ??
        Offset.zero;
    newPosition += Point(0, caret.dy);
    _context = oldContext;
    _submit(bloc);
    _context = _createContext(state.data, position: newPosition);
    _updateEditingState();
    bloc.refresh();
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

  Future<void> _updateText(String value, [bool replace = true]) async {
    TextElement element;
    final state = _bloc?.state;
    if (state is! DocumentLoadSuccess || _context == null) return;
    final data = state.data;

    final lastValue = currentTextEditingValue;
    final start = replace
        ? lastValue.composing.start
        : lastValue.selection.start;
    final length = replace ? null : lastValue.selection.end - start;
    final newIndex = replace
        ? lastValue.selection.end - lastValue.text.length + value.length
        : start + value.length;
    final currentText = replace
        ? value.substring(
            start,
            value.length - lastValue.text.length + lastValue.composing.end,
          )
        : value;
    if (_context == null) return;
    switch (_context!) {
      case TextContext e:
        final old = e.element;
        if (old != null) {
          final newSpan = e.shouldNewSpan(data);
          final paragraph = newSpan
              ? old.area.paragraph.replace(
                  text.TextSpan.text(
                    text: currentText,
                    property:
                        e.forcedSpanProperty ??
                        const text.SpanProperty.undefined(),
                  ),
                  start,
                  length,
                )
              : old.area.paragraph.replaceText(
                  currentText,
                  start,
                  length,
                  replace,
                );
          final area = old.area.copyWith(paragraph: paragraph);
          element = old.copyWith(area: area);
        } else {
          final paragraph = text.TextParagraph(
            textSpans: [text.TextSpan.text(text: value)],
            property:
                e.forcedProperty ?? const text.ParagraphProperty.undefined(),
          );
          final area = text.TextArea(paragraph: paragraph);
          element = TextElement(area: area, id: createUniqueId());
        }
        _context = e.copyWith(
          element: element,
          selection: TextSelection.collapsed(offset: newIndex),
        );
      case MarkdownContext e:
        var text = e.text ?? '';
        text = replace
            ? value
            : text.replaceRange(
                start,
                lastValue.selection.end.clamp(0, text.length),
                value,
              );
        _context = e.copyWith(
          element: e.element?.copyWith(text: text),
          selection: TextSelection.collapsed(offset: newIndex),
        );
    }
    await _bloc?.refresh();
    if (_bloc != null) await _refreshToolbar(_bloc!);
    if (!replace) _updateEditingState();
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}

  @override
  void didChangeInputControl(
    TextInputControl? oldControl,
    TextInputControl? newControl,
  ) {
    if (isCurrentlyEditing) {
      oldControl?.hide();
      newControl?.show();
    }
  }

  int _getVerticalNewSelection(bool forward) {
    final context = _context;
    if (context == null) return 0;
    final selection = context.selection.start;
    var nextLine = context.nextLineIndex(selection);
    final currentLine = context.previousLineIndex(selection);
    if (nextLine <= 0) nextLine = context.length + 1;
    var nextNextLine = context.nextLineIndex(nextLine + 1);
    if (nextNextLine <= nextLine) {
      nextNextLine = context.length + 2;
      nextLine = context.length;
    }
    var nextLineLength = nextNextLine - nextLine + 1;
    final previousLine = context.previousLineIndex(max(currentLine, 0));
    var previousLineLength = max(currentLine - previousLine, 0);
    final lineSelection = min(
      max(selection - currentLine, 1),
      forward ? nextLineLength : previousLineLength,
    );
    return (forward ? nextLine + lineSelection : previousLine + lineSelection)
        .clamp(0, context.length);
  }

  @override
  Map<Type, Action<Intent>> getActions(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    return {
      ...super.getActions(context),
      DeleteCharacterIntent: CallbackAction<DeleteCharacterIntent>(
        onInvoke: (intent) {
          final element = _context?.element;
          final selection = _context?.selection;
          if (element == null || selection == null) return null;
          var start = selection.start;
          var length = selection.end - start;
          if (length == 0) {
            if (start == 0) return null;
            if (!intent.forward) {
              start--;
            }
            length = 1;
          }
          switch (_context) {
            case TextContext e:
              var element = e.element;
              if (element == null) return e;
              var area = element.area;
              final paragraph = area.paragraph.remove(start, length);
              area = area.copyWith(paragraph: paragraph);
              final newElement = element.copyWith(area: area);

              _context = e.copyWith(
                element: newElement,
                selection: TextSelection.collapsed(offset: start),
              );
            case MarkdownContext e:
              var element = e.element;
              if (element == null) return e;
              element = element.copyWith(
                text: element.text.replaceRange(start, selection.end, ''),
              );
              _context = e.copyWith(
                element: element,
                selection: TextSelection.collapsed(offset: start),
              );
            default:
              return null;
          }
          bloc.refresh();
          _refreshToolbar(bloc);
          _updateEditingState();
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
              _updateEditingState();
              _refreshToolbar(bloc);
              return null;
            },
          ),
      SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
        onInvoke: (intent) => _selectAllText(),
      ),
      ExtendSelectionByCharacterIntent:
          CallbackAction<ExtendSelectionByCharacterIntent>(
            onInvoke: (intent) {
              final maxLength = _context?.length ?? 0;
              var selection =
                  _context?.selection ??
                  const TextSelection.collapsed(offset: 0);
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
              _context = _context?.copyWith(selection: selection);
              _context = switch (_context) {
                TextContext e => e.copyWith(
                  forcedSpanProperty:
                      e.element?.area.paragraph
                          .getSpan(selection.baseOffset)
                          ?.property ??
                      e.forcedSpanProperty,
                  forceParagraph: null,
                ),
                _ => _context,
              };
              bloc.refresh();
              _refreshToolbar(bloc);
              _updateEditingState();
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
              _updateEditingState();
              _refreshToolbar(bloc);
              return null;
            },
          ),
      DeleteToNextWordBoundaryIntent:
          CallbackAction<DeleteToNextWordBoundaryIntent>(
            onInvoke: (intent) {
              final selection = _context?.selection;
              if (selection == null) return null;
              var index = selection.baseOffset;
              var wordIndex = _context?.previousWordIndex(index) ?? 0;
              if (wordIndex > 0) wordIndex--;
              if (wordIndex < 0) {
                index = wordIndex;
              }
              final length = selection.end - wordIndex;
              switch (_context) {
                case TextContext e:
                  final element = e.element;
                  if (element == null) return e;
                  var area = element.area;
                  var paragraph = area.paragraph;
                  paragraph = paragraph.remove(wordIndex, length.abs());
                  area = area.copyWith(paragraph: paragraph);
                  final newElement = element.copyWith(area: area);

                  _context = e.copyWith(
                    element: newElement,
                    selection: TextSelection.collapsed(offset: wordIndex),
                  );
                  break;
                case MarkdownContext e:
                  final element = e.element;
                  if (element == null) return e;
                  final text = element.text.replaceRange(
                    wordIndex,
                    length.abs(),
                    '',
                  );

                  _context = e.copyWith(
                    element: element.copyWith(text: text),
                    selection: TextSelection.collapsed(offset: wordIndex),
                  );
                default:
                  return null;
              }

              bloc.refresh();
              _refreshToolbar(bloc);
              _updateEditingState();
              return null;
            },
          ),
      CopySelectionTextIntent: CallbackAction<CopySelectionTextIntent>(
        onInvoke: (intent) => _copyText(intent.collapseSelection),
      ),
      PasteTextIntent: CallbackAction<PasteTextIntent>(
        onInvoke: (intent) => _pasteText(),
      ),
    };
  }

  void _copyText(bool cut) {
    final selection = _context?.selection;
    if (selection == null) return;
    final text = _context?.text;
    if (text == null) return;
    Clipboard.setData(
      ClipboardData(text: text.substring(selection.start, selection.end)),
    );
    if (cut) {
      _updateText('');
    }
    return;
  }

  void _pasteText() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value == null) return;
      _updateText(value.text ?? '', false);
      if (_bloc != null) _refreshToolbar(_bloc!);
    });
  }

  void _selectAllText() {
    final length = _context?.length ?? 0;
    _context = _context?.copyWith(
      selection: TextSelection(baseOffset: length, extentOffset: 0),
    );
    _context = switch (_context) {
      TextContext e => e.copyWith(
        forcedSpanProperty:
            e.element?.area.paragraph.getSpan(length)?.property ??
            e.forcedSpanProperty,
        forceParagraph: null,
      ),
      _ => _context,
    };
    _bloc?.refresh();
    _updateEditingState();
    if (_bloc != null) _refreshToolbar(_bloc!);
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.none;
}
