part of 'editor_runtime.dart';

@Freezed(equal: false)
sealed class ToolRuntimeState with _$ToolRuntimeState {
  const ToolRuntimeState._();

  const factory ToolRuntimeState({
    int? index,
    required Handler handler,
    Handler<Tool>? temporaryHandler,
    int? temporaryIndex,
    @Default([]) List<Renderer> foregrounds,
    Selection? selection,
    @Default(false) bool pinned,
    List<Renderer>? temporaryForegrounds,
    @Default({}) Map<int, Handler<Tool>> toggleableHandlers,
    @Default([]) List<Renderer> networkingForegrounds,
    @Default({}) Map<int, List<Renderer>> toggleableForegrounds,
    @Default(MouseCursor.defer) MouseCursor cursor,
    MouseCursor? temporaryCursor,
    @Default(TemporaryState.allowClick) TemporaryState temporaryState,
    PreferredSizeWidget? toolbar,
    PreferredSizeWidget? temporaryToolbar,
  }) = _ToolRuntimeState;

  MouseCursor get currentCursor => temporaryCursor ?? cursor;

  List<Renderer> getAllForegrounds([bool networking = true]) => [
    ...foregrounds,
    ...?temporaryForegrounds,
    ...toggleableForegrounds.values.expand((e) => e),
    if (networking) ...networkingForegrounds,
  ];
}

class ToolCubit extends Cubit<ToolRuntimeState> {
  ToolCubit([ToolRuntimeState? initial])
    : super(initial ?? ToolRuntimeState(handler: HandHandler()));

  final foregroundRefreshRunner = CoalescedAsyncRunner(delay: Duration.zero);
  EditorController? _controller;
  Timer? _networkingDebounceTimer;

  void bindController(EditorController controller) {
    _controller = controller;
  }

  @override
  void onChange(Change<ToolRuntimeState> change) {
    super.onChange(change);
    if (change.nextState.foregrounds != change.currentState.foregrounds ||
        change.nextState.temporaryForegrounds !=
            change.currentState.temporaryForegrounds) {
      scheduleNetworkingState();
    }
  }

  void scheduleNetworkingState({
    List<Renderer<dynamic>>? foregrounds,
    Offset? cursor,
  }) {
    final controller = _controller;
    if (controller == null || controller.isClosed) return;
    _networkingDebounceTimer?.cancel();
    _networkingDebounceTimer = Timer(const Duration(milliseconds: 50), () {
      if (!controller.isClosed) {
        _sendNetworkingState(
          controller,
          foregrounds: foregrounds,
          cursor: cursor,
        );
      }
    });
  }

  void replace(ToolRuntimeState state) => emit(state);

  Handler getHandler({bool disableTemporary = false, bool editable = true}) {
    if (!editable) return HandHandler();
    return disableTemporary
        ? state.handler
        : state.temporaryHandler ?? state.handler;
  }

  T? fetchHandler<T extends Handler>({
    bool disableTemporary = false,
    bool editable = true,
  }) {
    final handler = getHandler(
      disableTemporary: disableTemporary,
      editable: editable,
    );
    if (handler is T) return handler;
    return null;
  }

  void setActiveTool({
    required int? index,
    required Handler handler,
    required MouseCursor cursor,
    required List<Renderer> foregrounds,
    required PreferredSizeWidget? toolbar,
    required Map<String, RendererState> rendererStates,
  }) => emit(
    state.copyWith(
      index: index,
      handler: handler,
      cursor: cursor,
      foregrounds: foregrounds,
      toolbar: toolbar,
      temporaryForegrounds: null,
      temporaryHandler: null,
      temporaryToolbar: null,
      temporaryCursor: null,
      temporaryIndex: null,
    ),
  );

  void setTemporaryTool({
    required Handler<Tool>? handler,
    required int? index,
    required List<Renderer>? foregrounds,
    required PreferredSizeWidget? toolbar,
    required MouseCursor? cursor,
    required Map<String, RendererState>? rendererStates,
    TemporaryState? temporaryState,
  }) => emit(
    state.copyWith(
      temporaryHandler: handler,
      temporaryIndex: index,
      temporaryForegrounds: foregrounds,
      temporaryToolbar: toolbar,
      temporaryCursor: cursor,
      temporaryState: temporaryState ?? state.temporaryState,
    ),
  );

  void setToggleable({
    Map<int, Handler<Tool>>? handlers,
    Map<int, List<Renderer>>? foregrounds,
  }) => emit(
    state.copyWith(
      toggleableHandlers: handlers ?? state.toggleableHandlers,
      toggleableForegrounds: foregrounds ?? state.toggleableForegrounds,
    ),
  );

  void setForegrounds({
    List<Renderer>? foregrounds,
    List<Renderer>? temporaryForegrounds,
    Map<int, List<Renderer>>? toggleableForegrounds,
    List<Renderer>? networkingForegrounds,
    MouseCursor? cursor,
    MouseCursor? temporaryCursor,
    Map<String, RendererState>? rendererStates,
    Map<String, RendererState>? temporaryRendererStates,
  }) => emit(
    state.copyWith(
      foregrounds: foregrounds ?? state.foregrounds,
      temporaryForegrounds: temporaryForegrounds ?? state.temporaryForegrounds,
      toggleableForegrounds:
          toggleableForegrounds ?? state.toggleableForegrounds,
      networkingForegrounds:
          networkingForegrounds ?? state.networkingForegrounds,
      cursor: cursor ?? state.cursor,
      temporaryCursor: temporaryCursor ?? state.temporaryCursor,
    ),
  );

  void setToolbar({
    PreferredSizeWidget? toolbar,
    PreferredSizeWidget? temporaryToolbar,
  }) => emit(
    state.copyWith(
      toolbar: toolbar ?? state.toolbar,
      temporaryToolbar: temporaryToolbar ?? state.temporaryToolbar,
    ),
  );

  void setCursor(MouseCursor cursor) {
    if (state.cursor != cursor) emit(state.copyWith(cursor: cursor));
  }

  void setIndex(int? index) => emit(state.copyWith(index: index));

  void setSelection(Selection? selection) =>
      emit(state.copyWith(selection: selection));

  void insertSelection(dynamic selected, [bool toggle = true]) {
    final selection = state.selection;
    if (selection == null) {
      setSelection(Selection.from(selected));
      return;
    }
    Selection? next;
    if (selection.selected.contains(selected) && toggle) {
      if (selection.selected.length != 1) {
        next = selection.remove(selected);
      }
    } else {
      next = selection.insert(selected);
    }
    setSelection(next);
  }

  void changeSelection(dynamic selected, [bool toggle = true]) {
    Selection? selection;
    if (selected is Selection?) {
      selection = selected;
    } else if (!toggle ||
        !(state.selection?.selected.contains(selected) ?? false)) {
      selection = Selection.from(selected);
    }
    setSelection(selection);
  }

  void removeSelection(List selected) {
    Selection? selection = state.selection;
    if (selection == null) return;
    for (final s in selected) {
      selection = selection?.remove(s);
    }
    setSelection(selection);
  }

  void resetSelection({bool force = false}) {
    if (force || !state.pinned) emit(state.copyWith(selection: null));
  }

  Tool? getTool(DocumentInfo info) {
    final index = state.index;
    if (index == null ||
        info.tools.isEmpty ||
        index < 0 ||
        index >= info.tools.length) {
      return null;
    }
    return info.tools[index];
  }

  T? fetchTool<T extends Tool>(DocumentInfo info) {
    final tool = getTool(info);
    if (tool is T) return tool;
    return null;
  }

  void togglePin() => emit(state.copyWith(pinned: !state.pinned));

  void setTemporaryState(TemporaryState temporaryState) =>
      emit(state.copyWith(temporaryState: temporaryState));

  void resetRuntime() => emit(ToolRuntimeState(handler: HandHandler()));

  Future<void> resetInput(dynamic bloc, EditorInputCubit inputCubit) async {
    await state.handler.resetInput(bloc);
    inputCubit.resetInputState();
  }

  void changeTemporaryHandlerMove(RendererCubit rendererCubit) {
    setTemporaryTool(
      handler: HandHandler(),
      index: null,
      foregrounds: null,
      toolbar: null,
      cursor: null,
      rendererStates: null,
    );
    rendererCubit.setRendererStates(temporaryRendererStates: const {});
  }

  Future<void> updateHandler(
    DocumentBloc bloc,
    RendererCubit rendererCubit,
    Handler handler,
  ) async {
    replace(
      state.copyWith(
        handler: handler,
        cursor: handler.cursor ?? MouseCursor.defer,
        toolbar: await handler.getToolbar(bloc),
      ),
    );
    rendererCubit.setRendererStates(rendererStates: handler.rendererStates);
  }

  Future<void> updateTool(
    EditorController controller,
    DocumentBloc bloc,
    Tool tool,
  ) async {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.handler.dispose(bloc);
    final handler = Handler.fromTool(tool);
    for (final renderer in state.foregrounds) {
      renderer.dispose();
    }
    final foregrounds = handler.createForegrounds(
      controller,
      docState.data,
      docState.page,
      docState.info,
      docState.currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    setActiveTool(
      index: state.index,
      handler: handler,
      cursor: handler.cursor ?? MouseCursor.defer,
      foregrounds: foregrounds,
      toolbar: await handler.getToolbar(bloc),
      rendererStates: handler.rendererStates,
    );
    controller.rendererCubit.setRendererStates(
      rendererStates: handler.rendererStates,
    );
  }

  Future<void> updateTemporaryTool(
    EditorController controller,
    DocumentBloc bloc,
    Tool tool,
  ) async {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.temporaryHandler?.dispose(bloc);
    final handler = Handler.fromTool(tool);
    for (final renderer in state.temporaryForegrounds ?? const <Renderer>[]) {
      renderer.dispose();
    }
    final foregrounds = handler.createForegrounds(
      controller,
      docState.data,
      docState.page,
      docState.info,
      docState.currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    setTemporaryTool(
      handler: handler,
      index: state.temporaryIndex,
      foregrounds: foregrounds,
      toolbar: await handler.getToolbar(bloc),
      cursor: handler.cursor,
      rendererStates: handler.rendererStates,
    );
    controller.rendererCubit.setRendererStates(
      temporaryRendererStates: handler.rendererStates,
    );
  }

  Future<void> updateTogglingTools(
    EditorController controller,
    DocumentBloc bloc,
    List<Tool> tools,
  ) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final newHandlers = Map<int, Handler<Tool>>.from(state.toggleableHandlers);
    final newForegrounds = Map<int, List<Renderer>>.from(
      state.toggleableForegrounds,
    );
    final currentTools = blocState.info.tools;
    for (final tool in tools) {
      if (tool.id == null) continue;
      final index = currentTools.indexWhere((element) => element.id == tool.id);
      if (index == -1) continue;
      final old = state.toggleableHandlers[index];
      if (old == null || old.data == tool) continue;
      old.dispose(bloc);
      for (final renderer in state.toggleableForegrounds[index] ?? []) {
        renderer.dispose();
      }
      final handler = Handler.fromTool(tool);
      final foregrounds = handler.createForegrounds(
        controller,
        blocState.data,
        blocState.page,
        blocState.info,
        blocState.currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              blocState.data,
              blocState.assetService,
              blocState.page,
            ),
          ),
        );
      }
      newHandlers[index] = handler;
      newForegrounds[index] = foregrounds;
    }
    setToggleable(handlers: newHandlers, foregrounds: newForegrounds);
  }

  void disposeForegrounds() {
    for (final r in state.foregrounds) {
      r.dispose();
    }
  }

  void disposeTemporaryForegrounds() {
    for (final r in state.temporaryForegrounds ?? []) {
      r.dispose();
    }
  }

  void disposeNetworkingForegrounds() {
    for (final r in state.networkingForegrounds) {
      r.dispose();
    }
  }

  void disposeToggleableForegrounds() {
    for (final r in state.toggleableForegrounds.values.expand((e) => e)) {
      r.dispose();
    }
  }

  void disposeAllForegrounds() {
    disposeForegrounds();
    disposeTemporaryForegrounds();
    disposeNetworkingForegrounds();
    disposeToggleableForegrounds();
  }

  R useHandler<R>(
    DocumentBloc bloc,
    int index,
    R Function(Handler<Tool> handler) callback, {
    required bool editable,
  }) {
    Handler<Tool>? handler;
    bool needsDispose = false;
    if (state.index == index) {
      handler = fetchHandler<Handler<Tool>>(
        disableTemporary: true,
        editable: editable,
      );
    } else if (state.toggleableHandlers.containsKey(index)) {
      handler = state.toggleableHandlers[index];
    }
    if (handler == null) {
      List<Tool> tools = const [];
      final blocState = bloc.state;
      if (blocState is DocumentLoaded) tools = blocState.info.tools;
      final tool = tools.elementAtOrNull(index) ?? HandTool();
      handler = Handler.fromTool(tool);
      needsDispose = true;
    }
    final result = callback(handler);
    if (needsDispose) {
      if (result is Future) {
        result.then((value) => handler?.dispose(bloc));
      } else {
        handler.dispose(bloc);
      }
    }
    return result;
  }

  Future<Handler?> changeTool(
    EditorController controller,
    DocumentBloc bloc, {
    int? index,
    BuildContext? context,
    Handler<Tool>? handler,
    bool allowBake = true,
  }) async {
    talker.verbose('Changing tool to index: $index');
    await resetInput(bloc, controller.inputCubit);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (controller.saveCubit.state.embedding?.editable == false) {
      return null;
    }
    final document = blocState.data;
    final info = blocState.info;
    index ??= state.index ?? 0;
    if (handler == null && (index < 0 || index >= info.tools.length)) {
      return null;
    }
    handler ??= Handler.fromTool(info.tools[index]);
    var selectState = SelectState.normal;
    if (context != null) {
      selectState = await handler.onSelected(context);
    }
    if (selectState != SelectState.none) {
      state.handler.dispose(bloc);
      state.temporaryHandler?.dispose(bloc);
      disposeTemporaryForegrounds();
      disposeForegrounds();
      final foregrounds = handler.createForegrounds(
        controller,
        document,
        blocState.page,
        info,
        blocState.currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              blocState.assetService,
              blocState.page,
            ),
          ),
        );
      }
      if (selectState == SelectState.normal) {
        controller.editorSessionCubit?.updateSelectedTool(handler.data, index);
        setActiveTool(
          index: index,
          handler: handler,
          cursor: handler.cursor ?? MouseCursor.defer,
          foregrounds: foregrounds,
          toolbar: await handler.getToolbar(bloc),
          rendererStates: handler.rendererStates,
        );
        controller.rendererCubit.setRendererStates(
          rendererStates: handler.rendererStates,
          temporaryRendererStates: const {},
        );
        if (allowBake) {
          await controller.rendererCubit.bake(controller, blocState);
        }
      } else {
        if (isHandlerEnabled(index)) {
          disableHandler(bloc, index);
        } else {
          setToggleable(
            handlers: {...state.toggleableHandlers, index: handler},
            foregrounds: {...state.toggleableForegrounds, index: foregrounds},
          );
        }
      }
    }
    return handler;
  }

  Future<void> toggleHandler(
    EditorController controller,
    DocumentBloc bloc,
    int index,
  ) async {
    if (state.toggleableHandlers.containsKey(index)) {
      disableHandler(bloc, index);
    } else {
      await enableHandler(controller, bloc, index);
    }
  }

  Future<Handler?> enableHandler(
    EditorController controller,
    DocumentBloc bloc,
    int index,
  ) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoaded) return null;
    if (index < 0 || index >= blocState.info.tools.length) {
      return null;
    }
    final tool = blocState.info.tools[index];
    final handler = Handler.fromTool(tool);
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final currentArea = blocState.currentArea;
    final foregrounds = handler.createForegrounds(
      controller,
      document,
      page,
      info,
      currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            document,
            blocState.assetService,
            page,
          ),
        ),
      );
    }
    setToggleable(
      handlers: Map.from(state.toggleableHandlers)..[index] = handler,
      foregrounds: Map.from(state.toggleableForegrounds)..[index] = foregrounds,
    );
    return handler;
  }

  bool disableHandler(DocumentBloc bloc, int index) {
    final handler = state.toggleableHandlers[index];
    if (handler == null) {
      return false;
    }
    handler.dispose(bloc);
    final foregrounds = Map<int, List<Renderer>>.from(
      state.toggleableForegrounds,
    );
    final current = foregrounds.remove(index);
    for (final r in current ?? []) {
      r.dispose();
    }
    setToggleable(
      handlers: Map.from(state.toggleableHandlers)..remove(index),
      foregrounds: foregrounds,
    );
    return true;
  }

  bool isHandlerEnabled(int index) =>
      state.toggleableHandlers.containsKey(index);

  void reset(EditorController controller, DocumentBloc bloc) {
    for (final r in controller.rendererCubit.renderers) {
      r.dispose();
    }
    controller.rendererCubit.initializedElements.clear();
    state.handler.dispose(bloc);
    state.temporaryHandler?.dispose(bloc);
    for (var e in state.toggleableHandlers.values) {
      e.dispose(bloc);
    }
    disposeAllForegrounds();
    resetRuntime();
    controller.rendererCubit.replace(const RendererRuntimeState());
  }

  Future<Handler?> changeTemporaryHandlerIndex(
    BuildContext context,
    EditorController controller,
    int index, {
    DocumentBloc? bloc,
    TemporaryState temporaryState = TemporaryState.allowClick,
    bool force = false,
  }) async {
    bloc ??= context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (index < 0 || index >= blocState.info.tools.length) {
      return null;
    }
    final tool = blocState.info.tools[index];
    final temporaryHandler = state.temporaryHandler;
    if (!force && index == state.temporaryIndex && temporaryHandler != null) {
      return temporaryHandler;
    }
    return changeTemporaryHandler(
      context,
      controller,
      tool,
      bloc: bloc,
      temporaryState: temporaryState,
      index: index,
    );
  }

  Future<Handler<T>?> changeTemporaryHandler<T extends Tool>(
    BuildContext context,
    EditorController controller,
    T tool, {
    DocumentBloc? bloc,
    int? index,
    TemporaryState temporaryState = TemporaryState.allowClick,
  }) async {
    bloc ??= context.read<DocumentBloc>();
    final handler = Handler.fromTool(tool);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.data;
    final page = blocState.page;
    final currentArea = blocState.currentArea;
    state.temporaryHandler?.dispose(bloc);
    final selectState = await handler.onSelected(context);

    if (selectState == SelectState.normal) {
      disposeTemporaryForegrounds();
      final temporaryForegrounds = handler.createForegrounds(
        controller,
        document,
        page,
        blocState.info,
        currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          temporaryForegrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              blocState.assetService,
              page,
            ),
          ),
        );
      }
      setTemporaryTool(
        handler: handler,
        index: index,
        foregrounds: temporaryForegrounds,
        toolbar: await handler.getToolbar(bloc),
        cursor: handler.cursor,
        rendererStates: handler.rendererStates,
        temporaryState: temporaryState,
      );
      controller.rendererCubit.setRendererStates(
        temporaryRendererStates: handler.rendererStates,
      );
      await controller.rendererCubit.bake(controller, blocState);
    } else if (selectState == SelectState.toggle && index != null) {
      await toggleHandler(controller, bloc, index);
    }
    return handler;
  }

  void resetReleaseHandler(DocumentBloc bloc, [RendererCubit? rendererCubit]) {
    if (state.temporaryState == TemporaryState.removeAfterRelease) {
      resetTemporaryHandler(bloc, true, rendererCubit);
    }
  }

  void resetDownHandler(DocumentBloc bloc, [RendererCubit? rendererCubit]) {
    resetTemporaryHandler(bloc, false, rendererCubit);
  }

  void resetTemporaryHandler(
    DocumentBloc bloc, [
    bool force = false,
    RendererCubit? rendererCubit,
  ]) {
    if (state.temporaryHandler == null) {
      return;
    }
    if (!force && state.temporaryState != TemporaryState.removeAfterClick) {
      if (state.temporaryState == TemporaryState.allowClick) {
        setTemporaryState(TemporaryState.removeAfterClick);
      }
      return;
    }
    state.temporaryHandler?.dispose(bloc);
    disposeTemporaryForegrounds();
    setTemporaryTool(
      handler: null,
      index: null,
      foregrounds: null,
      toolbar: null,
      cursor: null,
      rendererStates: null,
    );
    rendererCubit?.setRendererStates(temporaryRendererStates: const {});
  }

  Future<void> refresh(
    EditorController controller,
    DocumentLoaded blocState, {
    bool allowBake = true,
  }) async {
    talker.verbose('Refreshing tools');
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;
    const mapEq = MapEquality();
    if (!controller.isClosed) {
      disposeAllForegrounds();
      final temporaryForegrounds = state.temporaryHandler?.createForegrounds(
        controller,
        document,
        page,
        info,
        currentArea,
      );
      if (temporaryForegrounds != null &&
          state.temporaryHandler?.setupForegrounds == true) {
        await Future.wait(
          temporaryForegrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              assetService,
              page,
            ),
          ),
        );
      }
      final foregrounds = state.handler.createForegrounds(
        controller,
        document,
        page,
        info,
        currentArea,
      );
      if (state.handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              assetService,
              page,
            ),
          ),
        );
      }
      final toggleableForegrounds = <int, List<Renderer>>{};
      for (final entry in state.toggleableHandlers.entries) {
        final handler = entry.value;
        final index = entry.key;
        final foregrounds = handler.createForegrounds(
          controller,
          document,
          page,
          info,
          currentArea,
        );
        if (handler.setupForegrounds) {
          await Future.wait(
            foregrounds.map(
              (e) async => await e.setup(
                controller.transformCubit,
                document,
                assetService,
                page,
              ),
            ),
          );
        }
        toggleableForegrounds[index] = foregrounds;
      }
      final rendererStates = state.handler.rendererStates;
      final currentTemporaryRendererStates =
          controller.rendererCubit.state.temporaryRendererStates ??
          const <String, RendererState>{};
      final temporaryRendererStates =
          state.temporaryHandler?.rendererStates ??
          const <String, RendererState>{};
      final statesChanged = !mapEq.equals(
        controller.rendererCubit.state.rendererStates,
        rendererStates,
      );
      final temporaryStatesChanged = !mapEq.equals(
        currentTemporaryRendererStates,
        temporaryRendererStates,
      );
      final shouldBake = statesChanged || temporaryStatesChanged;
      final resetBake =
          controller.rendererCubit.rendererStateChangesAffectBaked(
            controller.rendererCubit.state.rendererStates,
            rendererStates,
          ) ||
          controller.rendererCubit.rendererStateChangesAffectBaked(
            currentTemporaryRendererStates,
            temporaryRendererStates,
          );
      setForegrounds(
        temporaryForegrounds: temporaryForegrounds,
        toggleableForegrounds: toggleableForegrounds,
        foregrounds: foregrounds,
        cursor: state.handler.cursor ?? MouseCursor.defer,
        temporaryCursor: state.temporaryHandler?.cursor,
      );
      controller.rendererCubit.setRendererStates(
        rendererStates: statesChanged
            ? rendererStates
            : controller.rendererCubit.state.rendererStates,
        temporaryRendererStates: temporaryStatesChanged
            ? temporaryRendererStates
            : currentTemporaryRendererStates,
      );
      if (allowBake) {
        if (shouldBake && resetBake) {
          return controller.rendererCubit.bake(
            controller,
            blocState,
            reset: true,
          );
        } else if (!controller.rendererCubit.state.cameraViewport.baked ||
            controller
                .rendererCubit
                .state
                .cameraViewport
                .unbakedElements
                .isNotEmpty) {
          return controller.rendererCubit.delayedBake(controller, blocState);
        }
      }
    }
  }

  Future<void> refreshToolbar(DocumentBloc bloc) async {
    final toolbar = await state.handler.getToolbar(bloc);
    final temporaryToolbar = await state.temporaryHandler?.getToolbar(bloc);
    setToolbar(toolbar: toolbar, temporaryToolbar: temporaryToolbar);
  }

  Future<void> refreshForegrounds(
    EditorController controller,
    DocumentLoaded blocState,
  ) => foregroundRefreshRunner.schedule(
    () => _refreshForegrounds(controller, blocState),
  );

  Future<void> _refreshForegrounds(
    EditorController controller,
    DocumentLoaded blocState,
  ) async {
    if (controller.isClosed) return;
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;

    disposeForegrounds();
    disposeTemporaryForegrounds();

    final temporaryForegrounds = state.temporaryHandler?.createForegrounds(
      controller,
      document,
      page,
      info,
      currentArea,
    );
    if (temporaryForegrounds != null &&
        temporaryForegrounds.isNotEmpty &&
        state.temporaryHandler?.setupForegrounds == true) {
      await Future.wait(
        temporaryForegrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            document,
            assetService,
            page,
          ),
        ),
      );
    }

    final foregrounds = state.handler.createForegrounds(
      controller,
      document,
      page,
      info,
      currentArea,
    );
    if (foregrounds.isNotEmpty && state.handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            document,
            assetService,
            page,
          ),
        ),
      );
    }

    const mapEq = MapEquality<String, RendererState>();
    final rendererStates = state.handler.rendererStates;
    final currentTemporaryRendererStates =
        controller.rendererCubit.state.temporaryRendererStates ??
        const <String, RendererState>{};
    final temporaryRendererStates =
        state.temporaryHandler?.rendererStates ??
        const <String, RendererState>{};
    final statesChanged = !mapEq.equals(
      controller.rendererCubit.state.rendererStates,
      rendererStates,
    );
    final temporaryStatesChanged = !mapEq.equals(
      currentTemporaryRendererStates,
      temporaryRendererStates,
    );
    final resetBake =
        controller.rendererCubit.rendererStateChangesAffectBaked(
          controller.rendererCubit.state.rendererStates,
          rendererStates,
        ) ||
        controller.rendererCubit.rendererStateChangesAffectBaked(
          currentTemporaryRendererStates,
          temporaryRendererStates,
        );

    setForegrounds(
      foregrounds: foregrounds,
      temporaryForegrounds: temporaryForegrounds,
      cursor: state.handler.cursor ?? MouseCursor.defer,
      temporaryCursor: state.temporaryHandler?.cursor,
    );
    controller.rendererCubit.setRendererStates(
      rendererStates: statesChanged
          ? rendererStates
          : controller.rendererCubit.state.rendererStates,
      temporaryRendererStates: temporaryStatesChanged
          ? temporaryRendererStates
          : currentTemporaryRendererStates,
    );

    if ((statesChanged || temporaryStatesChanged) && resetBake) {
      await controller.rendererCubit.bake(controller, blocState, reset: true);
    } else if (!controller.rendererCubit.state.cameraViewport.baked ||
        controller
            .rendererCubit
            .state
            .cameraViewport
            .unbakedElements
            .isNotEmpty) {
      await controller.rendererCubit.delayedBake(controller, blocState);
    }
  }

  void updateIndex(EditorController controller, DocumentBloc bloc) {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    final info = docState.info;
    final index = info.tools.indexOf(state.handler.data);
    if (index < 0) {
      changeTool(controller, bloc, index: state.index ?? 0);
    }
    if (index == state.index) {
      return;
    }
    setIndex(index);
    final selection = state.selection;
    if (selection?.selected.contains(state.handler.data) ?? false) {
      resetSelection();
    }
  }

  Future<void> disposeRuntime(dynamic bloc) async {
    state.handler.dispose(bloc);
    state.temporaryHandler?.dispose(bloc);
    for (final handler in state.toggleableHandlers.values) {
      handler.dispose(bloc);
    }
    for (final renderer in state.getAllForegrounds()) {
      renderer.dispose();
    }
    foregroundRefreshRunner.cancel();
    await foregroundRefreshRunner.disposeAndWait();
    _networkingDebounceTimer?.cancel();
    _networkingDebounceTimer = null;
    _controller = null;
  }

  @override
  Future<void> close() {
    _networkingDebounceTimer?.cancel();
    _networkingDebounceTimer = null;
    _controller = null;
    return super.close();
  }
}
