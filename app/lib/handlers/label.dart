part of 'handler.dart';

class LabelHandler extends Handler<LabelPainter>
    with HandlerWithCursor, TextInputClient {
  LabelContext? _context;
  DocumentBloc? _bloc;

  bool get isCurrentlyEditing => _context?.element != null;

  LabelHandler(super.data);

  LabelContext _createContext(
      {Point<double>? position, double zoom = 1, LabelElement? element}) {
    final scale = data.zoomDependent ? 1 / zoom : 1.0;
    final mode = element != null
        ? (element is TextElement ? LabelMode.text : LabelMode.markdown)
        : data.mode;
    switch (mode) {
      case LabelMode.text:
        final forced = _context?.mapOrNull(text: (e) => e.forcedProperty);
        return TextContext(
          painter: data,
          isCreating: true,
          element: (element as TextElement?) ??
              (position == null
                  ? null
                  : TextElement(
                      position: position,
                      area: text.TextArea(
                        paragraph: text.TextParagraph.text(
                          property: forced ??
                              const text.ParagraphProperty.undefined(),
                        ),
                      ),
                      styleSheet: data.styleSheet,
                      scale: scale,
                      foreground: data.foreground,
                    )),
          textPainter: TextPainter(),
          forcedProperty: forced,
        );
      case LabelMode.markdown:
        return MarkdownContext(
          painter: data,
          isCreating: true,
          element: (element as MarkdownElement?) ??
              (position == null
                  ? null
                  : MarkdownElement(
                      position: position,
                      text: '',
                      styleSheet: data.styleSheet,
                      scale: scale,
                      foreground: data.foreground,
                    )),
          textPainter: TextPainter(),
        );
    }
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        ...super.createForegrounds(
            currentIndexCubit, document, page, info, currentArea),
        if (_context?.element != null) ...[
          if (_context?.isCreating ?? false)
            _context!.map(
                text: (e) => TextRenderer(e.element!, e),
                markdown: (e) => MarkdownRenderer(e.element!, e)),
          LabelSelectionCursor(_context!)
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
  void onTapUp(TapUpDetails details, EventContext context) =>
      create(context, details.localPosition, context.isShiftPressed);

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) =>
      create(context, details.localPosition, true);

  Future<void> create(EventContext context, Offset localPosition,
      [bool forceCreate = false]) async {
    final pixelRatio = context.devicePixelRatio;
    final focusNode = Focus.of(context.buildContext);
    final globalPos = context.getCameraTransform().localToGlobal(localPosition);
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
      final hit = await rayCast(globalPos, context.getDocumentBloc(),
          context.getCameraTransform(), 0.0);
      final labelRenderer = hit.whereType<Renderer<LabelElement>>().firstOrNull;
      if (labelRenderer == null) {
        _context = _createContext(
            position: globalPos.toPoint(),
            zoom: context.getCameraTransform().size);
      } else {
        context
            .getDocumentBloc()
            .add(ElementsRemoved([labelRenderer.element as PadElement]));
        _context = _createContext(element: labelRenderer.element);
      }
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
  PreferredSizeWidget getToolbar(DocumentBloc bloc) {
    _context ??= _createContext();
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
    final isEmpty = context.isEmpty ?? true;
    if (element != null) {
      if (context.isCreating && !isEmpty) {
        bloc.add(ElementsCreated([element]));
      } else if (!context.isCreating && isEmpty) {
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
  TextEditingValue? get currentTextEditingValue => _context?.element == null
      ? null
      : TextEditingValue(
          text: _context!.text!,
          selection: _context!.selection,
        );

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
    final state = _bloc?.state;
    if (state is! DocumentLoadSuccess || _context == null) return;
    final data = state.data;

    var newIndex = value.length;
    final selection = _context!.selection;
    final start = selection.start;
    final length = selection.end - start;
    newIndex += selection.start;
    _context = _context?.map(text: (e) {
      final old = e.element;
      if (old != null) {
        final newSpan =
            e.getDefinedForcedSpanProperty(data) != e.getSpanProperty(data);
        final paragraph = newSpan
            ? old.area.paragraph.replace(
                text.TextSpan.text(
                  text: value,
                  property: e.forcedSpanProperty ??
                      const text.SpanProperty.undefined(),
                ),
                start,
                length)
            : old.area.paragraph.replaceText(value, start, length);
        final area = old.area.copyWith(
          paragraph: paragraph,
        );
        element = old.copyWith(area: area);
      } else {
        final paragraph = text.TextParagraph.text(
          textSpans: [text.TextSpan.text(text: value)],
          property:
              e.forcedProperty ?? const text.ParagraphProperty.undefined(),
        );
        final area = text.TextArea(
          paragraph: paragraph,
        );
        element = TextElement(area: area);
      }
      return e.copyWith(
        element: element,
        selection: TextSelection.collapsed(offset: newIndex),
      );
    }, markdown: (e) {
      var text = e.text ?? '';
      text =
          text.replaceRange(start, selection.end.clamp(0, text.length), value);
      return e.copyWith(
        element: e.element?.copyWith(
          text: text,
        ),
        selection: TextSelection.collapsed(offset: newIndex),
      );
    });
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
    final lineSelection = min(max(selection - currentLine, 1),
        forward ? nextLineLength : previousLineLength);
    return (forward ? nextLine + lineSelection : previousLine + lineSelection)
        .clamp(0, context.length);
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
          var start = selection.start;
          var length = selection.end - start;
          if (length == 0) {
            if (start == 0) return null;
            if (!intent.forward) {
              start--;
            }
            length = 1;
          }
          _context = _context?.map(text: (e) {
            var element = e.element;
            if (element == null) return e;
            var area = element.area;
            final paragraph = area.paragraph.remove(
              start,
              length,
            );
            area = area.copyWith(paragraph: paragraph);
            final newElement = element.copyWith(area: area);

            return e.copyWith(
              element: newElement,
              selection: TextSelection.collapsed(offset: start),
            );
          }, markdown: (e) {
            var element = e.element;
            if (element == null) return e;
            element = element.copyWith(
                text: element.text.replaceRange(start, selection.end, ''));
            return e.copyWith(
              element: element,
              selection: TextSelection.collapsed(offset: start),
            );
          });
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
          final length = _context?.length ?? 0;
          _context = _context?.copyWith(
            selection: TextSelection(
              baseOffset: length,
              extentOffset: 0,
            ),
          );
          _context = _context?.maybeMap(
              text: (e) => e.copyWith(
                    forcedSpanProperty:
                        e.element?.area.paragraph.getSpan(length)?.property ??
                            e.forcedSpanProperty,
                    forceParagraph: null,
                  ),
              orElse: () => _context);
          bloc.refresh();
          _refreshToolbar(bloc);
          return null;
        },
      ),
      ExtendSelectionByCharacterIntent:
          CallbackAction<ExtendSelectionByCharacterIntent>(
        onInvoke: (intent) {
          final maxLength = _context?.length ?? 0;
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
          _context = _context?.maybeMap(
            text: (e) => e.copyWith(
              forcedSpanProperty: e.element?.area.paragraph
                      .getSpan(selection.baseOffset)
                      ?.property ??
                  e.forcedSpanProperty,
              forceParagraph: null,
            ),
            orElse: () => _context,
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
          final selection = _context?.selection;
          if (selection == null) return null;
          var index = selection.baseOffset;
          var wordIndex = _context?.previousWordIndex(index) ?? 0;
          if (wordIndex > 0) wordIndex--;
          if (wordIndex < 0) {
            index = wordIndex;
          }
          final length = selection.end - wordIndex;
          _context = _context?.map(
            text: (e) {
              final element = e.element;
              if (element == null) return e;
              var area = element.area;
              var paragraph = area.paragraph;
              paragraph = paragraph.remove(
                wordIndex,
                length.abs(),
              );
              area = area.copyWith(paragraph: paragraph);
              final newElement = element.copyWith(area: area);

              return e.copyWith(
                element: newElement,
                selection: TextSelection.collapsed(offset: wordIndex),
              );
            },
            markdown: (e) {
              final element = e.element;
              if (element == null) return e;
              final text =
                  element.text.replaceRange(wordIndex, length.abs(), '');

              return e.copyWith(
                element: element.copyWith(text: text),
                selection: TextSelection.collapsed(offset: wordIndex),
              );
            },
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
          final text = _context?.text;
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
