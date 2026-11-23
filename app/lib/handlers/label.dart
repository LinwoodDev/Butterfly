part of 'handler.dart';

class LabelHandler extends Handler<LabelTool>
    with HandlerWithCursor, TextInputClient {
  LabelContext? _context;
  DocumentBloc? _bloc;
  Offset? _textAnchor;
  int? _selectionAnchor;
  PointerDownEvent? _tapDown;
  PointerDownEvent? _lastTap;
  TextRange _composing = .empty;
  String? _editingPage;
  String? _editingLayer;
  bool _published = false;
  Future<NamedItem<text.TextStyleSheet>?>? _defaultStyleSheet;

  bool get isCurrentlyEditing => _context?.element != null;

  @override
  bool get isEditingText => _connection?.attached ?? false;

  @override
  Map<String, RendererState> get rendererStates => {
    ?_context?.element?.id: RendererState.hidden,
  };

  LabelHandler(super.data);

  Future<NamedItem<text.TextStyleSheet>?> _getStyleSheet(
    ButterflyFileSystem fileSystem,
  ) async =>
      data.styleSheet ??
      await (_defaultStyleSheet ??= fileSystem.findDefaultStyleSheet().then(
        (item) => item?.toNamed(),
      ));

  LabelContext _createContext({
    NamedItem<text.TextStyleSheet>? defaultStyle,
    Point<double>? position,
    double zoom = 1,
    double rotation = 0,
    String collection = '',
    LabelElement? element,
  }) {
    final scale = (data.zoomDependent ? 1 / zoom : 1.0) * data.scale;
    final mode = element != null
        ? (element is TextElement ? LabelMode.text : LabelMode.markdown)
        : data.mode;
    final styleSheet = data.styleSheet ?? defaultStyle;
    final tool = data.copyWith(styleSheet: styleSheet);
    final painter = _context?.textPainter ?? TextPainter();
    switch (mode) {
      case .text:
        final forced = switch (_context) {
          TextContext e => e.forcedProperty,
          _ => null,
        };
        return TextContext(
          tool: tool,
          element:
              (element as TextElement?) ??
              (position == null
                  ? null
                  : TextElement(
                      position: position,
                      rotation: rotation,
                      collection: collection,
                      area: text.TextArea(
                        paragraph: text.TextParagraph(
                          property:
                              forced ??
                              const text.ParagraphProperty.undefined(),
                        ),
                      ),
                      scale: scale,
                      foreground: data.foreground,
                      styleSheet: styleSheet,
                      id: createUniqueId(),
                    )),
          textPainter: painter,
          forcedProperty: forced,
        );
      case .markdown:
        return MarkdownContext(
          tool: tool,
          element:
              (element as MarkdownElement?) ??
              (position == null
                  ? null
                  : MarkdownElement(
                      position: position,
                      rotation: rotation,
                      collection: collection,
                      text: '',
                      id: createUniqueId(),
                      styleSheet: styleSheet,
                      scale: scale,
                      foreground: data.foreground,
                    )),
          textPainter: painter,
        );
    }
  }

  GenericTextRenderer _editingRenderer(LabelContext context) =>
      switch (context) {
        TextContext e => TextRenderer(e.element!, null, e),
        MarkdownContext e => MarkdownRenderer(e.element!, null, e),
      };

  @override
  bool get setupForegrounds => false;

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    ...super.createForegrounds(
      editorController,
      document,
      page,
      info,
      currentArea,
    ),
    if (_context?.element != null) ...[
      _editingRenderer(_context!)..useEditingLayout(document),
      LabelSelectionCursor(_context!),
    ],
  ];

  TextInputConnection? _connection;

  TextPosition? _positionAt(Offset globalPosition, {bool hitTest = false}) {
    final edit = _context;
    final bounds = edit?.getRect();
    if (edit == null || bounds == null) return null;
    final position = edit.toLocalPosition(globalPosition);
    if (hitTest && !bounds.contains(position)) return null;
    return edit.textPainter.getPositionForOffset(position - bounds.topLeft);
  }

  @override
  bool handlesRepeatedTap(PointerDownEvent event, EventContext context) =>
      event.buttons == kPrimaryButton &&
      !context.isShiftPressed &&
      _positionAt(
            context.getCameraTransform().localToGlobal(event.localPosition),
            hitTest: true,
          ) !=
          null;

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    _tapDown = event.buttons == kPrimaryButton ? event : null;
    _selectionAnchor = event.buttons & kPrimaryButton == 0
        ? null
        : _positionAt(
            context.getCameraTransform().localToGlobal(event.localPosition),
            hitTest: true,
          )?.offset;
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    _lastTap = null;
    if (details.pointerCount == 1) {
      _extendSelection(details.localFocalPoint, context);
    }
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    if (details.pointerCount == 1) {
      _extendSelection(details.localFocalPoint, context);
    }
  }

  void _extendSelection(Offset position, EventContext context) {
    final anchor = _selectionAnchor;
    if (anchor == null) return;
    final extent = _positionAt(
      context.getCameraTransform().localToGlobal(position),
    );
    if (extent == null) return;
    _context = _context!.copyWith(
      selection: TextSelection(baseOffset: anchor, extentOffset: extent.offset),
    );
    _refreshToolbar(context.getDocumentBloc());
    context.refreshForegrounds();
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    if (_selectionAnchor != null) {
      _selectionAnchor = null;
      _updateEditingState();
    }
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) {
    final tap = _tapDown;
    final lastTap = _lastTap;
    final elapsed = tap != null && lastTap != null
        ? tap.timeStamp - lastTap.timeStamp
        : null;
    final isDoubleTap =
        !context.isShiftPressed &&
        tap != null &&
        lastTap != null &&
        tap.kind == lastTap.kind &&
        elapsed! >= kDoubleTapMinTime &&
        elapsed <= kDoubleTapTimeout &&
        (tap.position - lastTap.position).distance <= kDoubleTapTouchSlop;
    _tapDown = null;
    _lastTap = isDoubleTap || context.isShiftPressed ? null : tap;
    create(
      context,
      details.localPosition,
      forceCreate: context.isShiftPressed,
      selectWord: isDoubleTap,
    );
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == .mouse && event.buttons != kSecondaryMouseButton;

  Future<void> create(
    EventContext context,
    Offset localPosition, {
    bool forceCreate = false,
    bool selectWord = false,
  }) async {
    _selectionAnchor = null;
    final currentIndex = context.getToolState();
    localPosition = PointerManipulationHandler.calculatePointerPosition(
      currentIndex,
      localPosition,
      context.viewportSize,
      context.getCameraTransform(),
    );
    final pixelRatio = context.devicePixelRatio;
    final state = context.getState();
    if (state == null) return;
    final focusNode = Focus.of(context.buildContext);
    final globalPos = context.getCameraTransform().localToGlobal(localPosition);
    final hit = _positionAt(globalPos, hitTest: true);
    FocusScope.of(context.buildContext).requestFocus(focusNode);
    final theme = Theme.of(context.buildContext);
    final style = theme.textTheme.bodyLarge!;
    final bloc = context.getDocumentBloc();
    if (hit == null || forceCreate) {
      final previous = _context;
      final fileSystem = context.getFileSystem();
      final locks = context.getViewState().locks;
      final transform = context.getCameraTransform();
      final hits = forceCreate
          ? <Renderer<PadElement>>{}
          : await bloc.rayCast(
              globalPos,
              0.0,
              useCollection: locks.lockCollection,
              useLayer: locks.lockLayer,
            );
      final styleSheet = await _getStyleSheet(fileSystem);
      if (!context.buildContext.mounted ||
          !identical(
            context.getEditorController().toolCubit.getHandler(),
            this,
          ) ||
          context.getState()?.pageName != state.pageName ||
          !identical(_context, previous)) {
        return;
      }

      final labelRenderer = hits
          .whereType<Renderer<LabelElement>>()
          .firstOrNull;
      final element = labelRenderer?.element;
      if (element != null && (element as PadElement).id == null) return;
      final bounds = labelRenderer?.rect;
      _beginEditing(
        _createContext(
          defaultStyle: styleSheet,
          position: globalPos.toPoint(),
          zoom: transform.size,
          rotation: -transform.rotation * 180 / pi,
          collection: state.currentCollection,
          element: element,
        ),
        bounds == null
            ? globalPos
            : labelRenderer!.transformPoint(bounds.topLeft),
        page: state.pageName,
        layer: labelRenderer?.layer ?? state.currentLayer,
        published: labelRenderer != null,
      );
    }
    final viewId = View.of(context.buildContext).viewId;
    _composing = TextRange.empty;
    _bloc = bloc;
    _layoutText(bloc);
    if (_positionAt(globalPos) case final position?) {
      final word = selectWord && hit != null
          ? _context!.textPainter.getWordBoundary(position)
          : null;
      final selection = word == null
          ? TextSelection.fromPosition(position)
          : TextSelection(baseOffset: word.start, extentOffset: word.end);
      _context = switch (_context!) {
        TextContext edit => edit.copyWith(
          selection: selection,
          forcedSpanProperty: null,
        ),
        final edit => edit.copyWith(selection: selection),
      };
    }
    if (!(_connection?.attached ?? false)) {
      _connection =
          TextInput.attach(
              this,
              TextInputConfiguration(
                viewId: viewId,
                inputType: TextInputType.multiline,
                obscureText: false,
                autocorrect: true,
                inputAction: TextInputAction.newline,
                keyboardAppearance: theme.brightness,
                enableDeltaModel: false,
                enableSuggestions: true,
                enableInteractiveSelection: true,
              ),
            )
            ..setEditingState(currentTextEditingValue)
            ..updateStyle(
              TextInputStyle(
                fontFamily: style.fontFamily,
                fontSize: style.fontSize! * pixelRatio,
                fontWeight: style.fontWeight,
                textDirection: .ltr,
                textAlign: .left,
              ),
            );
    } else {
      _updateEditingState();
    }
    _connection!.show();
    _refreshToolbar(bloc);
    context.refreshForegrounds();
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
  Future<PreferredSizeWidget?> getToolbar(DocumentBloc bloc) async {
    final state = bloc.state;
    if (state is! DocumentLoaded) return null;
    if (_context == null) {
      final styleSheet = await _getStyleSheet(state.fileSystem);
      _context ??= _createContext(defaultStyle: styleSheet);
    }
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
    final context = _context;
    if (bloc.state is! DocumentLoaded || context == null) return;
    _context = value;
    if (context.tool != value.tool) {
      changeTool(bloc, value.tool);
    }
    if (context.element != value.element) {
      _layoutText(bloc);
      _publishEdit(bloc);
    }
    bloc.refreshForegrounds();
    _refreshToolbar(bloc);
    _updateEditingState();
  }

  void _beginEditing(
    LabelContext context,
    Offset anchor, {
    required String page,
    required String? layer,
    required bool published,
  }) {
    _context = context;
    _textAnchor = anchor;
    _editingPage = page;
    _editingLayer = layer;
    _published = published;
  }

  void _publishEdit(DocumentBloc bloc) {
    final context = _context;
    final element = context?.element;
    final id = _context?.element?.id;
    if (element == null || id == null) return;
    if (context!.isEmpty) {
      if (_published) {
        bloc.add(ElementsRemoved([id], pageName: _editingPage));
        _published = false;
      }
    } else if (_published) {
      bloc.add(
        ElementsChanged({
          id: [element],
        }, pageName: _editingPage),
      );
    } else {
      bloc.add(
        ElementsCreated(
          [element],
          pageName: _editingPage,
          layer: _editingLayer,
        ),
      );
      _published = true;
    }
  }

  @override
  void onDocumentRestored(DocumentBloc bloc) {
    final context = _context;
    final state = bloc.state;
    final id = _context?.element?.id;
    if (context == null || id == null) return;
    if (state is! DocumentLoadSuccess || state.pageName != _editingPage) {
      dispose(bloc);
      return;
    }

    final saved = state.page.content.whereType<LabelElement>().firstWhereOrNull(
      (element) => (element as PadElement).id == id,
    );
    final label =
        saved ??
        switch (context) {
          TextContext edit => edit.element!.copyWith.area.paragraph(
            textSpans: [],
          ),
          MarkdownContext edit => edit.element!.copyWith(text: ''),
        };
    _published = saved != null;
    if (label == null || label == context.labelElement) return;

    final selection = TextSelection.collapsed(
      offset: context.selection.extentOffset.clamp(0, label.text.length),
    );
    _context = switch ((context, label)) {
      (TextContext edit, TextElement element) => edit.copyWith(
        element: element,
        selection: selection,
      ),
      (MarkdownContext edit, MarkdownElement element) => edit.copyWith(
        element: element,
        selection: selection,
      ),
      (_, TextElement element) => TextContext(
        tool: context.tool.copyWith(mode: .text),
        textPainter: context.textPainter,
        selection: selection,
        element: element,
      ),
      (_, MarkdownElement element) => MarkdownContext(
        tool: context.tool.copyWith(mode: .markdown),
        textPainter: context.textPainter,
        selection: selection,
        element: element,
      ),
      _ => context,
    };
    _composing = TextRange.empty;
    _editingRenderer(_context!).layoutForEditing(state.data, state.page);
    final bounds = _context!.getRect()!;
    _textAnchor = _context!.toGlobalPosition(bounds.topLeft);
    _refreshToolbar(bloc);
    _updateEditingState();
  }

  Future<void> _refreshToolbar(DocumentBloc bloc) async =>
      bloc.refreshToolbar();

  @override
  void dispose(DocumentBloc bloc) {
    if (_published) bloc.delayedBake();
    _connection?.close();
    _connection = null;
    _context = null;
    _bloc = null;
    _editingPage = null;
    _editingLayer = null;
    _published = false;
    _selectionAnchor = null;
    _tapDown = _lastTap = null;
    _composing = TextRange.empty;
    _currentPos = null;
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) =>
      _onContextMenu(details.localPosition, context);
  bool _startLongPress = false;

  @override
  void onLongPressDown(LongPressDownDetails details, EventContext context) {
    _startLongPress = details.kind != .mouse;
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) {
    if (!_startLongPress) return;
    if (_context == null) {
      create(context, details.localPosition, forceCreate: true);
    } else {
      _onContextMenu(details.localPosition, context);
    }
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

    return TextEditingValue(
      text: text,
      selection: TextSelection(
        baseOffset: context.selection.baseOffset.clamp(0, text.length),
        extentOffset: context.selection.extentOffset.clamp(0, text.length),
        affinity: context.selection.affinity,
        isDirectional: context.selection.isDirectional,
      ),
      composing: _composing,
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
      case .newline:
      case .done:
        if (HardwareKeyboard.instance.isControlPressed) {
          _newElement();
        }
        break;
      default:
    }
  }

  void _newElement() {
    final bloc = _bloc;
    final state = bloc?.state;
    if (bloc == null || state is! DocumentLoadSuccess) return;
    final oldContext = _context;
    if (oldContext == null) return;
    _replaceSelection('\n');
    final element = _context?.labelElement;
    if (element == null) return;
    final caret =
        _context?.textPainter.getOffsetForCaret(
          TextPosition(offset: oldContext.length + 1),
          Rect.zero,
        ) ??
        Offset.zero;
    final newPosition = _context!
        .toGlobalPosition(element.position.toOffset() + Offset(0, caret.dy))
        .toPoint();
    final next = _createContext(
      defaultStyle: oldContext.tool.styleSheet,
      position: newPosition,
      rotation: oldContext.rotation,
      collection: element.collection,
    );
    _beginEditing(
      next,
      newPosition.toOffset(),
      page: state.pageName,
      layer: state.currentLayer,
      published: false,
    );
    _composing = TextRange.empty;
    _layoutText(bloc);
    bloc.refreshForegrounds();
    _refreshToolbar(bloc);
    _updateEditingState();
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {}

  @override
  void showAutocorrectionPromptRect(int start, int end) {}

  @override
  void updateEditingValue(TextEditingValue value) {
    final context = _context;
    if (context?.element == null) return;
    final previous = currentTextEditingValue;
    _composing = value.composing;
    if (value.text == previous.text) {
      if (context!.selection == value.selection) return;
      _context = context.copyWith(selection: value.selection);
      _bloc?.refreshForegrounds();
      _bloc?.refreshToolbar();
      return;
    }

    _lastTap = null;
    // Prefer the IME's composing range or the selection so repeated letters
    // keep the style of the actual insertion or deletion point.
    final range =
        previous.isComposingRangeValid && previous.selection.isCollapsed
        ? previous.composing
        : previous.selection;
    final difference = value.text.length - previous.text.length;
    var start = min(range.start, range.end + difference);
    var oldEnd = range.end;
    var newEnd = oldEnd + difference;
    if (start < 0 ||
        !value.text.startsWith(previous.text.substring(0, start)) ||
        !value.text.endsWith(previous.text.substring(oldEnd))) {
      start = 0;
      final commonLength = min(previous.text.length, value.text.length);
      while (start < commonLength &&
          previous.text.codeUnitAt(start) == value.text.codeUnitAt(start)) {
        start++;
      }
      oldEnd = previous.text.length;
      newEnd = value.text.length;
      while (oldEnd > start &&
          newEnd > start &&
          previous.text.codeUnitAt(oldEnd - 1) ==
              value.text.codeUnitAt(newEnd - 1)) {
        oldEnd--;
        newEnd--;
      }
    }
    _replaceText(
      start,
      oldEnd,
      value.text.substring(start, newEnd),
      value.selection,
    );
  }

  void _replaceSelection(String replacement) {
    final selection = currentTextEditingValue.selection;
    if (!selection.isValid) return;
    _composing = TextRange.empty;
    _replaceText(
      selection.start,
      selection.end,
      replacement,
      TextSelection.collapsed(offset: selection.start + replacement.length),
    );
    _updateEditingState();
  }

  void _replaceText(
    int start,
    int end,
    String replacement,
    TextSelection selection,
  ) {
    final context = _context;
    final bloc = _bloc;
    if (context?.element == null || bloc == null) return;
    final updated = switch (context!) {
      TextContext e => e.copyWith(
        element: e.element!.copyWith.area(
          paragraph: _replaceRichText(e, start, end, replacement),
        ),
        selection: selection,
      ),
      MarkdownContext e => e.copyWith(
        element: e.element!.copyWith(
          text: e.element!.text.replaceRange(start, end, replacement),
        ),
        selection: selection,
      ),
    };
    _context = updated;
    _layoutText(bloc);
    _publishEdit(bloc);
    bloc.refreshForegrounds();
    _refreshToolbar(bloc);
  }

  text.TextParagraph _replaceRichText(
    TextContext context,
    int start,
    int end,
    String replacement,
  ) {
    final paragraph = context.paragraph!;
    if (replacement.isEmpty) return paragraph.remove(start, end - start);
    final span =
        paragraph.getSpan(start) ??
        (start > 0 ? paragraph.getSpan(start - 1) : null);
    final style = context.forcedSpanProperty;
    final replacementSpan = style == null || style == span?.property
        ? span?.copyWith(text: replacement) ??
              text.InlineSpan.text(text: replacement)
        : text.InlineSpan.text(text: replacement, property: style);
    return paragraph.replace(replacementSpan, start, end - start);
  }

  void _layoutText(DocumentBloc bloc) {
    final context = _context;
    final anchor = _textAnchor;
    final state = bloc.state;
    if (context?.element == null ||
        anchor == null ||
        state is! DocumentLoaded) {
      return;
    }
    _editingRenderer(context!).layoutForEditing(state.data, state.page);
    _context = context.withTextAnchor(anchor);
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
    final selection = context.selection.extentOffset;
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

  int _nextWordBoundary(String text, int index) {
    if (index >= text.length) return index;
    bool startIsWord = _isWordChar(text[index]);
    for (int i = index; i < text.length; i++) {
      bool currentIsWord = _isWordChar(text[i]);
      if (startIsWord && !currentIsWord) return i;
      if (!startIsWord && currentIsWord) return i;
    }
    return text.length;
  }

  int _prevWordBoundary(String text, int index) {
    if (index <= 0) return 0;
    bool startIsWord = _isWordChar(text[index - 1]);
    for (int i = index - 1; i >= 0; i--) {
      bool currentIsWord = _isWordChar(text[i]);
      if (startIsWord && !currentIsWord) return i + 1;
      if (!startIsWord && currentIsWord) return i + 1;
    }
    return 0;
  }

  bool _isWordChar(String char) {
    return RegExp(r'\w').hasMatch(char);
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
            if (!intent.forward) {
              if (start == 0) return null;
              start--;
            } else {
              if (start >= (_context?.length ?? 0)) return null;
            }
            length = 1;
          }
          _composing = TextRange.empty;
          _replaceText(
            start,
            start + length,
            '',
            TextSelection.collapsed(offset: start),
          );
          _updateEditingState();
          return null;
        },
      ),
      ExtendSelectionVerticallyToAdjacentLineIntent:
          CallbackAction<ExtendSelectionVerticallyToAdjacentLineIntent>(
            onInvoke: (intent) {
              final newOffset = _getVerticalNewSelection(intent.forward);
              _context = _context?.copyWith(
                selection: intent.collapseSelection
                    ? TextSelection.collapsed(offset: newOffset)
                    : TextSelection(
                        baseOffset: _context?.selection.baseOffset ?? 0,
                        extentOffset: newOffset,
                      ),
              );
              bloc.refreshForegrounds();
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
                if (!selection.isCollapsed) {
                  selection = TextSelection.collapsed(
                    offset: intent.forward ? selection.end : selection.start,
                  );
                } else {
                  selection = TextSelection.collapsed(
                    offset: (selection.extentOffset + (intent.forward ? 1 : -1))
                        .clamp(0, maxLength),
                  );
                }
              } else {
                selection = selection.copyWith(
                  extentOffset:
                      (selection.extentOffset + (intent.forward ? 1 : -1))
                          .clamp(0, maxLength),
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
              bloc.refreshForegrounds();
              _refreshToolbar(bloc);
              _updateEditingState();
              return null;
            },
          ),
      ExtendSelectionToLineBreakIntent:
          CallbackAction<ExtendSelectionToLineBreakIntent>(
            onInvoke: (intent) {
              final edit = _context;
              if (edit?.element == null) return null;
              final selection = edit!.selection;
              final line = edit.textPainter.getLineBoundary(selection.extent);
              final offset = intent.forward ? line.end : line.start;
              _context = edit.copyWith(
                selection: intent.collapseSelection
                    ? TextSelection.collapsed(offset: offset)
                    : selection.copyWith(extentOffset: offset),
              );
              bloc.refreshForegrounds();
              _updateEditingState();
              _refreshToolbar(bloc);
              return null;
            },
          ),
      ExtendSelectionToNextWordBoundaryIntent:
          CallbackAction<ExtendSelectionToNextWordBoundaryIntent>(
            onInvoke: (intent) {
              final selection = _context?.selection;
              if (selection == null) return null;
              final text = _context?.text ?? '';
              final target = intent.forward
                  ? _nextWordBoundary(text, selection.extentOffset)
                  : _prevWordBoundary(text, selection.extentOffset);

              final newSelection = intent.collapseSelection
                  ? TextSelection.collapsed(offset: target)
                  : selection.copyWith(extentOffset: target);

              _context = _context?.copyWith(selection: newSelection);
              _context = switch (_context) {
                TextContext e => e.copyWith(
                  forcedSpanProperty:
                      e.element?.area.paragraph
                          .getSpan(newSelection.baseOffset)
                          ?.property ??
                      e.forcedSpanProperty,
                  forceParagraph: null,
                ),
                _ => _context,
              };
              bloc.refreshForegrounds();
              _refreshToolbar(bloc);
              _updateEditingState();
              return null;
            },
          ),
      DeleteToNextWordBoundaryIntent:
          CallbackAction<DeleteToNextWordBoundaryIntent>(
            onInvoke: (intent) {
              final selection = _context?.selection;
              if (selection == null) return null;
              var start = selection.start;
              var length = selection.end - start;
              if (length == 0) {
                final text = _context?.text ?? '';
                final index = selection.extentOffset;
                final target = intent.forward
                    ? _nextWordBoundary(text, index)
                    : _prevWordBoundary(text, index);
                start = min(index, target);
                length = (target - index).abs();
              }
              if (length == 0) return null;
              _composing = TextRange.empty;
              _replaceText(
                start,
                start + length,
                '',
                TextSelection.collapsed(offset: start),
              );
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
      _replaceSelection('');
    }
    return;
  }

  void _pasteText() {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      if (value == null) return;
      _replaceSelection(value.text ?? '');
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
    _bloc?.refreshForegrounds();
    _updateEditingState();
    if (_bloc != null) _refreshToolbar(_bloc!);
  }

  @override
  MouseCursor get cursor => SystemMouseCursors.none;
}
