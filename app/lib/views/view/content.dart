part of '../view.dart';

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
    required this.input,
    required this.canvasKey,
    required this.bake,
    required this.delayBake,
  });

  final DocumentBloc bloc;
  final DocumentLoaded state;
  final Size viewportSize;
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

    return GestureDetector(
      onTapUp: (details) async {
        getHandler().onTapUp(details, getEventContext());
        cubit.inputCubit.removeButtons();
      },
      onTapDown: (details) =>
          getHandler().onTapDown(details, getEventContext()),
      onSecondaryTapUp: (details) =>
          getHandler().onSecondaryTapUp(details, getEventContext()),
      onScaleStart: (details) => input.handleScaleStart(details, pointerInput),
      onScaleUpdate: (details) =>
          input.handleScaleUpdate(details, pointerInput),
      onScaleEnd: (details) => input.handleScaleEnd(details, pointerInput),
      onLongPressDown: (details) =>
          getHandler().onLongPressDown(details, getEventContext()),
      onLongPressStart: (details) =>
          getHandler().onLongPressStart(details, getEventContext()),
      onLongPressEnd: (details) =>
          getHandler().onLongPressEnd(details, getEventContext()),
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerSignal: (event) =>
            input.handlePointerSignal(event, pointerInput),
        onPointerPanZoomStart: (_) => input.beginTrackpadGesture(),
        onPointerDown: (event) => input.handlePointerDown(event, pointerInput),
        onPointerMove: (event) => input.handlePointerMove(event, pointerInput),
        onPointerUp: (event) => input.handlePointerUp(event, pointerInput),
        onPointerCancel: (event) => input.handlePointerCancel(event, cubit),
        onPointerHover: (event) =>
            input.handlePointerHover(event, pointerInput),
        child: _ViewportCanvas(
          key: canvasKey,
          rendererState: rendererState,
          documentState: state,
          delayBake: delayBake,
        ),
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
              final realSize = rendererState.cameraViewport.toRealSize();
              final viewportMatches =
                  (realSize.width - viewportSize.width).abs() < 2 &&
                  (realSize.height - viewportSize.height).abs() < 2;
              if (state is DocumentLoadSuccess && !viewportMatches) {
                WidgetsBinding.instance.addPostFrameCallback((_) => bake());
              }

              return Actions(
                actions: getHandler().getActions(context),
                child: DefaultTextEditingShortcuts(
                  child: Focus(
                    child: MouseRegion(
                      cursor: toolState.currentCursor,
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
              );
            },
          ),
    );
  }
}
