part of '../view.dart';

Future<void> _importDroppedContent(
  BuildContext context,
  SystemDropDetails details,
) async {
  final bloc = context.read<DocumentBloc>();
  final state = bloc.state;
  if (state is! DocumentLoadSuccess) return;
  final position = bloc.transformCubit.state.localToGlobal(
    details.localPosition,
  );
  // The user explicitly dropped this content; allow bounded remote reads.
  final imported = await details.readContents(safeMode: false);
  if (!context.mounted || bloc.isClosed) return;
  final errors = [...imported.errors];
  final result = await context.read<ImportService>().importContents(
    imported.contents,
    document: state.data,
    position: position,
    onError: errors.add,
  );
  if (!context.mounted || bloc.isClosed) return;
  result?.submit(pageName: state.pageName, layer: state.currentLayer);
  if (errors.isNotEmpty) throw errors.first;
}

void _reportDropError(BuildContext context, Object error, StackTrace stack) {
  talker.error('Could not import dropped content', error, stack);
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(AppLocalizations.of(context).errorWhileImportingContent),
    ),
  );
}

Handler _getViewportHandler(DocumentLoaded state, EditorController cubit) =>
    state is DocumentPresentationState
    ? state.handler
    : cubit.toolCubit.getHandler(
        editable: cubit.saveCubit.state.embedding?.editable != false,
      );

class _LoadedViewport extends StatelessWidget {
  const _LoadedViewport({
    required this.bloc,
    required this.state,
    required this.viewportSize,
    required this.touchBottom,
    required this.input,
    required this.canvasKey,
    required this.bake,
    required this.delayBake,
  });

  final DocumentBloc bloc;
  final DocumentLoaded state;
  final Size viewportSize;
  final double touchBottom;
  final _ViewportInputCoordinator input;
  final GlobalKey<_ViewportCanvasState> canvasKey;
  final VoidCallback bake;
  final VoidCallback delayBake;

  Widget _buildInputSurface(
    BuildContext context,
    EditorController cubit,
    RendererRuntimeState rendererState,
    _HandlerGetter getHandler,
  ) {
    EventContext getEventContext() =>
        input.createEventContext(context, viewportSize);
    final pointerInput = (
      context: context,
      cubit: cubit,
      state: state,
      bloc: bloc,
      getHandler: getHandler,
      getEventContext: getEventContext,
      delayBake: delayBake,
    );

    bool handlePointer(PointerEvent event) =>
        input.handlePointer(event, pointerInput, touchBottom: touchBottom);

    final gestureSettings = MediaQuery.maybeGestureSettingsOf(context);
    final recognizers = <GestureRecognizer>[];
    GestureRecognizerFactory bind<T extends GestureRecognizer>(
      T Function() create,
      void Function(T) configure,
    ) => GestureRecognizerFactoryWithHandlers<T>(create, (recognizer) {
      recognizers.add(recognizer..gestureSettings = gestureSettings);
      configure(recognizer);
    });

    // Manage the stock recognizers and their semantics without hit testing
    // them directly. The listener admits pointers before they enter the arena.
    final gestures = RawGestureDetector(
      behavior: .deferToChild,
      gestures: {
        TapGestureRecognizer: bind(TapGestureRecognizer.new, (recognizer) {
          recognizer.onTapDown = (details) => input.handleGesture(() {
            getHandler().onTapDown(details, getEventContext());
          });
          recognizer.onTapUp = (details) => input.handleGesture(() {
            getHandler().onTapUp(details, getEventContext());
            cubit.inputCubit.removeButtons();
          });
          recognizer.onSecondaryTapUp = (details) => input.handleGesture(() {
            getHandler().onSecondaryTapUp(details, getEventContext());
          });
        }),
        LongPressGestureRecognizer: bind(LongPressGestureRecognizer.new, (
          recognizer,
        ) {
          recognizer.onLongPressDown = (details) => input.handleGesture(() {
            getHandler().onLongPressDown(details, getEventContext());
          });
          recognizer.onLongPressStart = (details) => input.handleGesture(() {
            getHandler().onLongPressStart(details, getEventContext());
          });
          recognizer.onLongPressEnd = (details) => input.handleGesture(() {
            getHandler().onLongPressEnd(details, getEventContext());
          });
        }),
        ScaleGestureRecognizer: bind(ScaleGestureRecognizer.new, (recognizer) {
          recognizer.dragStartBehavior = .start;
          recognizer.onStart = (details) =>
              input.handleScaleStart(details, pointerInput);
          recognizer.onUpdate = (details) =>
              input.handleScaleUpdate(details, pointerInput);
          recognizer.onEnd = (details) =>
              input.handleScaleEnd(details, pointerInput);
        }),
      },
    );

    return Listener(
      behavior: .translucent,
      onPointerSignal: (event) =>
          input.handlePointerSignal(event, pointerInput),
      onPointerPanZoomStart: (event) {
        input.beginTrackpadGesture();
        for (final recognizer in recognizers) {
          recognizer.addPointerPanZoom(event);
        }
      },
      onPointerDown: (event) {
        if (!handlePointer(event)) return;
        for (final recognizer in recognizers) {
          recognizer.addPointer(event);
        }
      },
      onPointerMove: handlePointer,
      onPointerUp: handlePointer,
      onPointerCancel: handlePointer,
      onPointerHover: (event) {
        cubit.inputCubit.updateLastPosition(event.localPosition);
        getHandler().onPointerHover(event, getEventContext());
      },
      child: Stack(
        fit: .expand,
        children: [
          _ViewportCanvas(
            key: canvasKey,
            rendererState: rendererState,
            documentState: state,
            delayBake: delayBake,
          ),
          gestures,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditorController>();
    Handler getHandler() => _getViewportHandler(state, cubit);

    return BlocBuilder<RendererCubit, RendererRuntimeState>(
      buildWhen: (previous, current) =>
          previous.cameraViewport != current.cameraViewport ||
          previous.rendererStates != current.rendererStates ||
          previous.temporaryRendererStates != current.temporaryRendererStates,
      builder: (context, rendererState) =>
          BlocBuilder<ToolCubit, ToolRuntimeState>(
            buildWhen: (previous, current) =>
                previous.handler != current.handler ||
                previous.temporaryHandler != current.temporaryHandler ||
                previous.cursor != current.cursor ||
                previous.temporaryCursor != current.temporaryCursor,
            builder: (context, toolState) {
              // Rotated caches cover a larger axis-aligned rectangle than
              // the screen. Compare the measured viewport, not the cache.
              final realSize =
                  rendererState.cameraViewport.viewportSize ??
                  rendererState.cameraViewport.toRealSize();
              final viewportMatches =
                  (realSize.width - viewportSize.width).abs() < 2 &&
                  (realSize.height - viewportSize.height).abs() < 2;
              if (state is DocumentLoadSuccess && !viewportMatches) {
                bake();
              }

              return Actions(
                actions: getHandler().getActions(context),
                child: DefaultTextEditingShortcuts(
                  child: Focus(
                    child: MouseRegion(
                      cursor: toolState.currentCursor,
                      child: SystemDropTarget(
                        showFeedback: true,
                        onDrop: (details) =>
                            _importDroppedContent(context, details),
                        onError: (error, stack) =>
                            _reportDropError(context, error, stack),
                        enabled:
                            state is DocumentLoadSuccess &&
                            cubit.saveCubit.state.embedding?.editable != false,
                        child: Builder(
                          builder: (context) => _buildInputSurface(
                            context,
                            cubit,
                            rendererState,
                            getHandler,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}
