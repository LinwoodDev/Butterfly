part of 'editor_controller.dart';

extension EditorControllerMethods on EditorController {
  bool _sameRendererList(
    List<Renderer<PadElement>> a,
    List<Renderer<PadElement>> b,
  ) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!identical(a[i], b[i])) return false;
    }
    return true;
  }

  void _onTransformChanged(CameraTransform transform) {
    // Debounce transform changes to avoid excessive updates during pan/zoom
    _transformDebounceTimer?.cancel();
    _transformDebounceTimer = Timer(const Duration(milliseconds: 16), () {
      _updateVisibleElements();
    });
  }

  void _updateVisibleElements() {
    if (isClosed) return;
    final unbaked = rendererCubit.state.cameraViewport.unbakedElements;
    final baked = rendererCubit.state.cameraViewport.bakedElements;

    final rect = getViewportRect();
    final currentVisible = rendererCubit.state.cameraViewport.visibleElements;
    final currentVisibleUnbaked =
        rendererCubit.state.cameraViewport.visibleUnbakedElements;

    final visibleUnbaked = unbaked.where((e) => e.isVisible(rect)).toList();
    final visible = <Renderer<PadElement>>[
      ...baked.where((e) => e.isVisible(rect)),
      ...visibleUnbaked,
    ];

    if (_sameRendererList(visible, currentVisible) &&
        _sameRendererList(visibleUnbaked, currentVisibleUnbaked)) {
      return;
    }

    final newViewport = rendererCubit.state.cameraViewport.withUnbaked(
      unbaked,
      visibleElements: visible,
      visibleUnbakedElements: visibleUnbaked,
    );

    final docState = _activeDocumentState;
    if (docState != null) {
      _updateOnVisible(newViewport, docState).then((_) {
        final bloc = _activeDocumentBloc;
        if (!isClosed && bloc != null) {
          bloc.delayedBake();
        }
      });
    }

    if (isClosed) return;

    rendererCubit.setViewport(newViewport);
  }

  DocumentBloc? get _activeDocumentBloc {
    final bloc = _documentBloc?.target;
    if (bloc == null || bloc.isClosed) return null;
    return bloc;
  }

  DocumentLoaded? get _activeDocumentState {
    final state = _activeDocumentBloc?.state;
    return state is DocumentLoaded ? state : null;
  }

  void init(DocumentBloc bloc) {
    _documentBloc = WeakReference(bloc);
    final blocState = bloc.state;
    final index = blocState is DocumentLoadSuccess
        ? editorSessionCubit?.resolveToolIndex(blocState.info)
        : toolCubit.state.index;
    changeTool(bloc, index: index ?? 0);
    networkingService.setup(bloc);
  }

  void invalidateRenderers(Iterable<Renderer<PadElement>> renderers) {
    rendererCubit.initializedElements.removeAll(renderers);
  }

  Future<void> _updateOnVisible(
    CameraViewport newViewport,
    DocumentLoaded blocState, {
    CameraTransform? renderTransform,
    ui.Size? targetSize,
  }) async {
    final newVisibleList = newViewport.visibleElements;
    final nextVisibleSet = newVisibleList.toSet();

    final newVisible = newVisibleList
        .where((e) => !rendererCubit.initializedElements.contains(e))
        .toList();

    final newlyHidden = rendererCubit.initializedElements
        .where((e) => !nextVisibleSet.contains(e))
        .toList();

    if (newVisible.isEmpty && newlyHidden.isEmpty) return;

    final transform = renderTransform ?? transformCubit.state;
    final size = targetSize ?? newViewport.toSize();

    rendererCubit.initializedElements.removeAll(newlyHidden);

    if (newVisible.isNotEmpty) {
      talker.verbose('Updating visible elements: ${newVisible.length} new');
      final initialized = await Future.wait(
        newVisible.map((element) async {
          try {
            await Future.sync(
              () => element.onVisible(this, blocState, transform, size),
            );
            return element;
          } catch (error, stackTrace) {
            talker.error(
              'Failed to initialize visible renderer $element',
              error,
              stackTrace,
            );
          }
          return null;
        }),
      );
      rendererCubit.initializedElements.addAll(initialized.nonNulls);
    }

    if (newlyHidden.isNotEmpty) {
      await Future.wait(
        newlyHidden.map(
          (element) async =>
              await element.onHidden(this, blocState, transform, size),
        ),
      );
    }
  }

  Handler getHandler({bool disableTemporary = false}) {
    if (saveCubit.state.embedding?.editable == false) {
      return HandHandler();
    }
    if (disableTemporary) {
      return toolCubit.state.handler;
    } else {
      return toolCubit.state.temporaryHandler ?? toolCubit.state.handler;
    }
  }

  Future<Handler?> changeTool(
    DocumentBloc bloc, {
    int? index,
    BuildContext? context,
    Handler<Tool>? handler,
    bool allowBake = true,
  }) async {
    talker.verbose('Changing tool to index: $index');
    await toolCubit.resetInput(bloc, inputCubit);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (saveCubit.state.embedding?.editable == false) {
      return null;
    }
    final document = blocState.data;
    final info = blocState.info;
    index ??= toolCubit.state.index ?? 0;
    if (handler == null && (index < 0 || index >= info.tools.length)) {
      return null;
    }
    handler ??= Handler.fromTool(info.tools[index]);
    var selectState = SelectState.normal;
    if (context != null) {
      selectState = await handler.onSelected(context);
    }
    if (selectState != SelectState.none) {
      toolCubit.state.handler.dispose(bloc);
      toolCubit.state.temporaryHandler?.dispose(bloc);
      _disposeTemporaryForegrounds();
      _disposeForegrounds();
      final foregrounds = handler.createForegrounds(
        this,
        document,
        blocState.page,
        info,
        blocState.currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              transformCubit,
              document,
              blocState.assetService,
              blocState.page,
            ),
          ),
        );
      }
      if (selectState == SelectState.normal) {
        editorSessionCubit?.updateSelectedTool(handler.data, index);
        toolCubit.setActiveTool(
          index: index,
          handler: handler,
          cursor: handler.cursor ?? MouseCursor.defer,
          foregrounds: foregrounds,
          toolbar: await handler.getToolbar(bloc),
          rendererStates: handler.rendererStates,
        );
        rendererCubit.setRendererStates(
          rendererStates: handler.rendererStates,
          temporaryRendererStates: const {},
        );
        if (allowBake) await bake(blocState);
      } else {
        if (isHandlerEnabled(index)) {
          disableHandler(bloc, index);
        } else {
          toolCubit.setToggleable(
            handlers: {...toolCubit.state.toggleableHandlers, index: handler},
            foregrounds: {
              ...toolCubit.state.toggleableForegrounds,
              index: foregrounds,
            },
          );
        }
      }
    }
    return handler;
  }

  void _onToolChanged(ToolRuntimeState next) {
    if (_isClosing) {
      return;
    }
    final current = _previousToolState;
    _previousToolState = next;
    if (current == null) return;

    if (next.foregrounds != current.foregrounds ||
        next.temporaryForegrounds != current.temporaryForegrounds) {
      _networkingDebounceTimer?.cancel();
      _networkingDebounceTimer = Timer(const Duration(milliseconds: 50), () {
        if (!isClosed) _sendNetworkingState();
      });
    }
  }

  void _onInputChanged(EditorInputState next) {
    if (_isClosing) return;
    final current = _previousInputState;
    _previousInputState = next;
    if (next.lastPosition != current.lastPosition) {
      _networkingDebounceTimer?.cancel();
      _networkingDebounceTimer = Timer(const Duration(milliseconds: 50), () {
        if (!isClosed) _sendNetworkingState();
      });
    }
  }

  void _onViewChanged(EditorViewState next) {
    if (_isClosing) return;
    final current = _previousViewState;
    _previousViewState = next;
    if (current != null && next.userName != current.userName) {
      _networkingDebounceTimer?.cancel();
      _networkingDebounceTimer = Timer(const Duration(milliseconds: 50), () {
        if (!isClosed) _sendNetworkingState();
      });
    }
  }

  void _onRendererChanged(RendererRuntimeState next) {
    if (_isClosing) return;
    final current = _previousRendererState;
    _previousRendererState = next;
    final currentViewport = current.cameraViewport;
    final newViewport = next.cameraViewport;

    if (!identical(currentViewport, newViewport) &&
        currentViewport != newViewport) {
      toolCubit.state.handler.onViewportUpdated(currentViewport, newViewport);
      toolCubit.state.temporaryHandler?.onViewportUpdated(
        currentViewport,
        newViewport,
      );
    }

    currentViewport.disposeImages(except: newViewport);
  }

  void _sendNetworkingState({
    List<Renderer<dynamic>>? foregrounds,
    Offset? cursor,
  }) {
    cursor ??= inputCubit.state.lastPosition ?? Offset.zero;
    networkingService.sendUser(
      NetworkingUser(
        cursor: transformCubit.state.localToGlobal(cursor).toPoint(),
        foreground: (foregrounds ?? toolCubit.state.getAllForegrounds(false))
            .map((e) => e.element)
            .whereType<PadElement>()
            .toList(),
        name: networkingService.userName,
      ),
    );
  }

  Future<void> updateNetworkingState(
    DocumentBloc bloc, [
    Map<Channel?, NetworkingUser>? current,
  ]) async {
    talker.verbose('Updating networking state');
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final users = (current ?? networkingService.users).entries.toList();
    final usersByChannel = {for (final entry in users) entry.key: entry.value};
    final activeForegroundElements = users
        .expand((entry) => entry.value.foreground ?? const <PadElement>[])
        .toSet();

    final foregrounds = toolCubit.state.networkingForegrounds.toList();
    foregrounds.removeWhere((renderer) {
      bool shouldRemove;
      if (renderer is UserCursor) {
        final activeUser = usersByChannel[renderer.userId];
        shouldRemove = activeUser == null || activeUser != renderer.element;
      } else {
        shouldRemove = !activeForegroundElements.contains(renderer.element);
      }
      if (shouldRemove) {
        renderer.dispose();
      }
      return shouldRemove;
    });

    final existingElements = foregrounds.map((e) => e.element).toSet();
    final added = <Renderer>[];
    added.addAll(
      users
          .expand((entry) => entry.value.foreground ?? const <PadElement>[])
          .where((element) => !existingElements.contains(element))
          .map((element) => Renderer.fromInstance(element)),
    );
    added.addAll(
      users
          .where(
            (entry) =>
                foregrounds.whereType<UserCursor>().firstWhereOrNull(
                  (cursor) =>
                      cursor.userId == entry.key &&
                      cursor.element == entry.value,
                ) ==
                null,
          )
          .map((entry) => UserCursor(entry.value, entry.key)),
    );
    await Future.wait(
      added.map(
        (e) async => await e.setup(
          transformCubit,
          blocState.data,
          blocState.assetService,
          blocState.page,
        ),
      ),
    );
    foregrounds.addAll(added);
    toolCubit.setForegrounds(networkingForegrounds: foregrounds);
  }

  void updateLastPosition(Offset position) {
    // Only emit if position changed by more than 1 pixel to reduce state updates
    final lastPos = inputCubit.state.lastPosition;
    if (lastPos != null) {
      final dx = (position.dx - lastPos.dx).abs();
      final dy = (position.dy - lastPos.dy).abs();
      if (dx < 1 && dy < 1) return;
    }
    inputCubit.updateLastPosition(position);
  }

  Future<void> updateHandler(DocumentBloc bloc, Handler handler) async {
    toolCubit.replace(
      toolCubit.state.copyWith(
        handler: handler,
        cursor: handler.cursor ?? MouseCursor.defer,
        toolbar: await handler.getToolbar(bloc),
      ),
    );
    rendererCubit.setRendererStates(rendererStates: handler.rendererStates);
  }

  Future<void> updateTool(DocumentBloc bloc, Tool tool) async {
    talker.verbose('Updating tool: ${tool.runtimeType}');
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    toolCubit.state.handler.dispose(bloc);
    final handler = Handler.fromTool(tool);
    _disposeForegrounds();
    final foregrounds = handler.createForegrounds(
      this,
      docState.data,
      docState.page,
      docState.info,
      docState.currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    toolCubit.setActiveTool(
      index: toolCubit.state.index,
      handler: handler,
      cursor: handler.cursor ?? MouseCursor.defer,
      foregrounds: foregrounds,
      toolbar: await handler.getToolbar(bloc),
      rendererStates: handler.rendererStates,
    );
    rendererCubit.setRendererStates(rendererStates: handler.rendererStates);
  }

  Future<void> updateTemporaryTool(DocumentBloc bloc, Tool tool) async {
    talker.verbose('Updating temporary tool: ${tool.runtimeType}');
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    toolCubit.state.temporaryHandler?.dispose(bloc);
    final handler = Handler.fromTool(tool);
    _disposeTemporaryForegrounds();
    final foregrounds = handler.createForegrounds(
      this,
      docState.data,
      docState.page,
      docState.info,
      docState.currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    toolCubit.setTemporaryTool(
      handler: handler,
      index: toolCubit.state.temporaryIndex,
      foregrounds: foregrounds,
      toolbar: await handler.getToolbar(bloc),
      cursor: handler.cursor,
      rendererStates: handler.rendererStates,
    );
    rendererCubit.setRendererStates(
      temporaryRendererStates: handler.rendererStates,
    );
  }

  T? fetchHandler<T extends Handler>({bool disableTemporary = false}) {
    final handler = getHandler(disableTemporary: disableTemporary);
    if (handler is T) return handler;
    return null;
  }

  void _disposeForegrounds() {
    for (final r in toolCubit.state.foregrounds) {
      r.dispose();
    }
  }

  void _disposeTemporaryForegrounds() {
    for (final r in toolCubit.state.temporaryForegrounds ?? []) {
      r.dispose();
    }
  }

  void _disposeNetworkingForegrounds() {
    for (final r in toolCubit.state.networkingForegrounds) {
      r.dispose();
    }
  }

  void _disposeToggleableForegrounds() {
    for (final r in toolCubit.state.toggleableForegrounds.values.expand(
      (e) => e,
    )) {
      r.dispose();
    }
  }

  void _disposeAllForegrounds() {
    _disposeForegrounds();
    _disposeTemporaryForegrounds();
    _disposeNetworkingForegrounds();
    _disposeToggleableForegrounds();
  }

  R useHandler<R>(
    DocumentBloc bloc,
    int index,
    R Function(Handler<Tool> handler) callback,
  ) {
    Handler<Tool>? handler;
    bool needsDispose = false;
    if (toolCubit.state.index == index) {
      handler = fetchHandler<Handler<Tool>>(disableTemporary: true);
    } else if (toolCubit.state.toggleableHandlers.containsKey(index)) {
      handler = toolCubit.state.toggleableHandlers[index];
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

  Future<void> refresh(
    DocumentLoaded blocState, {
    bool allowBake = true,
  }) async {
    talker.verbose('Refreshing EditorController');
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;
    const mapEq = MapEquality();
    if (!isClosed) {
      _disposeAllForegrounds();
      final temporaryForegrounds = toolCubit.state.temporaryHandler
          ?.createForegrounds(this, document, page, info, currentArea);
      if (temporaryForegrounds != null &&
          toolCubit.state.temporaryHandler?.setupForegrounds == true) {
        await Future.wait(
          temporaryForegrounds.map(
            (e) async =>
                await e.setup(transformCubit, document, assetService, page),
          ),
        );
      }
      final foregrounds = toolCubit.state.handler.createForegrounds(
        this,
        document,
        page,
        info,
        currentArea,
      );
      if (toolCubit.state.handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async =>
                await e.setup(transformCubit, document, assetService, page),
          ),
        );
      }
      final toggleableForegrounds = <int, List<Renderer>>{};
      for (final entry in toolCubit.state.toggleableHandlers.entries) {
        final handler = entry.value;
        final index = entry.key;
        final foregrounds = handler.createForegrounds(
          this,
          document,
          page,
          info,
          currentArea,
        );
        if (handler.setupForegrounds) {
          await Future.wait(
            foregrounds.map(
              (e) async =>
                  await e.setup(transformCubit, document, assetService, page),
            ),
          );
        }
        toggleableForegrounds[index] = foregrounds;
      }
      final rendererStates = toolCubit.state.handler.rendererStates;
      final temporaryRendererStates =
          toolCubit.state.temporaryHandler?.rendererStates;
      final statesChanged = !mapEq.equals(
        rendererCubit.state.rendererStates,
        rendererStates,
      );
      final temporaryStatesChanged = !mapEq.equals(
        rendererCubit.state.temporaryRendererStates,
        temporaryRendererStates,
      );
      final shouldBake = statesChanged || temporaryStatesChanged;
      toolCubit.setForegrounds(
        temporaryForegrounds: temporaryForegrounds,
        toggleableForegrounds: toggleableForegrounds,
        foregrounds: foregrounds,
        cursor: toolCubit.state.handler.cursor ?? MouseCursor.defer,
        temporaryCursor: toolCubit.state.temporaryHandler?.cursor,
        rendererStates: statesChanged
            ? rendererStates
            : rendererCubit.state.rendererStates,
        temporaryRendererStates: temporaryStatesChanged
            ? temporaryRendererStates
            : rendererCubit.state.temporaryRendererStates,
      );
      rendererCubit.setRendererStates(
        rendererStates: statesChanged
            ? rendererStates
            : rendererCubit.state.rendererStates,
        temporaryRendererStates: temporaryStatesChanged
            ? temporaryRendererStates
            : rendererCubit.state.temporaryRendererStates,
      );
      if (allowBake) {
        if (shouldBake) {
          return bake(blocState, reset: true);
        } else if (!rendererCubit.state.cameraViewport.baked) {
          return delayedBake(blocState);
        }
      }
    }
  }

  Future<void> refreshToolbar(DocumentBloc bloc) async {
    if (!isClosed) {
      final toolbar = await toolCubit.state.handler.getToolbar(bloc);
      final temporaryToolbar = await toolCubit.state.temporaryHandler
          ?.getToolbar(bloc);
      toolCubit.setToolbar(
        toolbar: toolbar,
        temporaryToolbar: temporaryToolbar,
      );
    }
  }

  /// Lightweight refresh that only updates foregrounds without rebaking.
  /// Use this when handler internal state changes but document hasn't changed.
  Future<void> refreshForegrounds(DocumentLoaded blocState) => toolCubit
      .foregroundRefreshRunner
      .schedule(() => _refreshForegrounds(blocState));

  Future<void> _refreshForegrounds(DocumentLoaded blocState) async {
    if (isClosed) return;
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;

    _disposeForegrounds();
    _disposeTemporaryForegrounds();

    final temporaryForegrounds = toolCubit.state.temporaryHandler
        ?.createForegrounds(this, document, page, info, currentArea);
    if (temporaryForegrounds != null &&
        temporaryForegrounds.isNotEmpty &&
        toolCubit.state.temporaryHandler?.setupForegrounds == true) {
      await Future.wait(
        temporaryForegrounds.map(
          (e) async =>
              await e.setup(transformCubit, document, assetService, page),
        ),
      );
    }

    final foregrounds = toolCubit.state.handler.createForegrounds(
      this,
      document,
      page,
      info,
      currentArea,
    );
    if (foregrounds.isNotEmpty && toolCubit.state.handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async =>
              await e.setup(transformCubit, document, assetService, page),
        ),
      );
    }

    // Check if rendererStates changed and need a bake
    const mapEq = MapEquality<String, RendererState>();
    final rendererStates = toolCubit.state.handler.rendererStates;
    final temporaryRendererStates =
        toolCubit.state.temporaryHandler?.rendererStates;
    final statesChanged = !mapEq.equals(
      rendererCubit.state.rendererStates,
      rendererStates,
    );
    final temporaryStatesChanged = !mapEq.equals(
      rendererCubit.state.temporaryRendererStates,
      temporaryRendererStates,
    );

    toolCubit.setForegrounds(
      foregrounds: foregrounds,
      temporaryForegrounds: temporaryForegrounds,
      cursor: toolCubit.state.handler.cursor ?? MouseCursor.defer,
      temporaryCursor: toolCubit.state.temporaryHandler?.cursor,
      rendererStates: statesChanged
          ? rendererStates
          : rendererCubit.state.rendererStates,
      temporaryRendererStates: temporaryStatesChanged
          ? temporaryRendererStates
          : rendererCubit.state.temporaryRendererStates,
    );
    rendererCubit.setRendererStates(
      rendererStates: statesChanged
          ? rendererStates
          : rendererCubit.state.rendererStates,
      temporaryRendererStates: temporaryStatesChanged
          ? temporaryRendererStates
          : rendererCubit.state.temporaryRendererStates,
    );

    // If renderer states changed, we need to bake to hide/show original elements
    if (statesChanged || temporaryStatesChanged) {
      await bake(blocState, reset: true);
    }
  }

  /// Ultra-lightweight update for cursor changes only.
  /// Use this when only the cursor appearance needs to change.
  void updateCursor(MouseCursor cursor) {
    if (toolCubit.state.cursor != cursor) {
      toolCubit.setCursor(cursor);
    }
  }

  Future<void> toggleHandler(DocumentBloc bloc, int index) async {
    if (toolCubit.state.toggleableHandlers.containsKey(index)) {
      disableHandler(bloc, index);
    } else {
      await enableHandler(bloc, index);
    }
  }

  Future<Handler?> enableHandler(DocumentBloc bloc, int index) async {
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
      this,
      document,
      page,
      info,
      currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            transformCubit,
            document,
            blocState.assetService,
            page,
          ),
        ),
      );
    }
    toolCubit.setToggleable(
      handlers: Map.from(toolCubit.state.toggleableHandlers)..[index] = handler,
      foregrounds: Map.from(toolCubit.state.toggleableForegrounds)
        ..[index] = foregrounds,
    );
    return handler;
  }

  bool disableHandler(DocumentBloc bloc, int index) {
    final handler = toolCubit.state.toggleableHandlers[index];
    if (handler == null) {
      return false;
    }
    handler.dispose(bloc);
    final foregrounds = Map<int, List<Renderer>>.from(
      toolCubit.state.toggleableForegrounds,
    );
    final current = foregrounds.remove(index);
    for (final r in current ?? []) {
      r.dispose();
    }
    toolCubit.setToggleable(
      handlers: Map.from(toolCubit.state.toggleableHandlers)..remove(index),
      foregrounds: foregrounds,
    );
    return true;
  }

  bool isHandlerEnabled(int index) =>
      toolCubit.state.toggleableHandlers.containsKey(index);

  void reset(DocumentBloc bloc) {
    for (final r in rendererCubit.renderers) {
      r.dispose();
    }
    rendererCubit.initializedElements.clear();
    toolCubit.state.handler.dispose(bloc);
    toolCubit.state.temporaryHandler?.dispose(bloc);
    for (var e in toolCubit.state.toggleableHandlers.values) {
      e.dispose(bloc);
    }
    _disposeForegrounds();
    _disposeTemporaryForegrounds();
    _disposeNetworkingForegrounds();
    _disposeToggleableForegrounds();
    toolCubit.resetRuntime();
    rendererCubit.replace(const RendererRuntimeState());
  }

  Future<Handler?> changeTemporaryHandlerIndex(
    BuildContext context,
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
    final temporaryHandler = toolCubit.state.temporaryHandler;
    if (!force &&
        index == toolCubit.state.temporaryIndex &&
        temporaryHandler != null) {
      return temporaryHandler;
    }
    return changeTemporaryHandler(
      context,
      tool,
      bloc: bloc,
      temporaryState: temporaryState,
      index: index,
    );
  }

  Future<Handler<T>?> changeTemporaryHandler<T extends Tool>(
    BuildContext context,
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
    toolCubit.state.temporaryHandler?.dispose(bloc);
    final selectState = await handler.onSelected(context);

    if (selectState == SelectState.normal) {
      _disposeTemporaryForegrounds();
      final temporaryForegrounds = handler.createForegrounds(
        this,
        document,
        page,
        blocState.info,
        currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          temporaryForegrounds.map(
            (e) async => await e.setup(
              transformCubit,
              document,
              blocState.assetService,
              page,
            ),
          ),
        );
      }
      toolCubit.setTemporaryTool(
        handler: handler,
        index: index,
        foregrounds: temporaryForegrounds,
        toolbar: await handler.getToolbar(bloc),
        cursor: handler.cursor,
        rendererStates: handler.rendererStates,
        temporaryState: temporaryState,
      );
      rendererCubit.setRendererStates(
        temporaryRendererStates: handler.rendererStates,
      );
      await bake(blocState);
    } else if (selectState == SelectState.toggle && index != null) {
      await toggleHandler(bloc, index);
    }
    return handler;
  }

  void resetReleaseHandler(DocumentBloc bloc) {
    if (toolCubit.state.temporaryState == TemporaryState.removeAfterRelease) {
      resetTemporaryHandler(bloc, true);
    }
  }

  void resetDownHandler(DocumentBloc bloc) {
    resetTemporaryHandler(bloc);
  }

  void resetTemporaryHandler(DocumentBloc bloc, [bool force = false]) {
    if (toolCubit.state.temporaryHandler == null) {
      return;
    }
    if (!force &&
        toolCubit.state.temporaryState != TemporaryState.removeAfterClick) {
      if (toolCubit.state.temporaryState == TemporaryState.allowClick) {
        toolCubit.setTemporaryState(TemporaryState.removeAfterClick);
      }
      return;
    }
    toolCubit.state.temporaryHandler?.dispose(bloc);
    _disposeTemporaryForegrounds();
    toolCubit.setTemporaryTool(
      handler: null,
      index: null,
      foregrounds: null,
      toolbar: null,
      cursor: null,
      rendererStates: null,
    );
    rendererCubit.setRendererStates(temporaryRendererStates: const {});
  }

  Renderer? getRenderer(PadElement element) =>
      rendererCubit.getRenderer(element);

  Rect getViewportRect({Size? viewportSize}) {
    var size = viewportSize ?? rendererCubit.state.cameraViewport.toSize();

    final transform = transformCubit.state;
    final resolution = settingsCubit.state.renderResolution;

    final friction = transform.friction;
    final realWidth = size.width / transform.size;
    final realHeight = size.height / transform.size;
    Rect rect = Rect.fromLTWH(
      transform.position.dx,
      transform.position.dy,
      realWidth,
      realHeight,
    );
    if (friction != null) {
      final beginPosition = transform.position - friction.beginOffset;
      final topLeft = Offset(
        min(transform.position.dx, beginPosition.dx),
        min(transform.position.dy, beginPosition.dy),
      );
      final frictionSize = Size(
        realWidth + (friction.beginOffset.dx * transform.size).abs(),
        realHeight + (friction.beginOffset.dy * transform.size).abs(),
      );
      rect = topLeft & frictionSize;
    }
    return _snapViewportRect(rect, size, transform, resolution);
  }

  Rect _snapViewportRect(
    Rect rect,
    Size size,
    CameraTransform transform,
    RenderResolution resolution,
  ) {
    final screenRect = Rect.fromPoints(
      transform.globalToLocal(rect.topLeft),
      transform.globalToLocal(rect.bottomRight),
    );
    final snappedRect = _expandScreenRect(
      Rect.fromLTRB(
        screenRect.left.floorToDouble(),
        screenRect.top.floorToDouble(),
        screenRect.right.ceilToDouble(),
        screenRect.bottom.ceilToDouble(),
      ),
      Size(
        (size.width * resolution.multiplier).ceilToDouble(),
        (size.height * resolution.multiplier).ceilToDouble(),
      ),
    );
    return Rect.fromPoints(
      transform.localToGlobal(snappedRect.topLeft),
      transform.localToGlobal(snappedRect.bottomRight),
    );
  }

  Rect _expandScreenRect(Rect rect, Size minimumSize) {
    final dx = max(0.0, minimumSize.width - rect.width);
    final dy = max(0.0, minimumSize.height - rect.height);
    return Rect.fromLTRB(
      rect.left - (dx / 2).floorToDouble(),
      rect.top - (dy / 2).floorToDouble(),
      rect.right + (dx / 2).ceilToDouble(),
      rect.bottom + (dy / 2).ceilToDouble(),
    );
  }

  bool _rectContains(Rect outer, Rect inner) {
    const tolerance = precisionErrorTolerance;
    return outer.left <= inner.left + tolerance &&
        outer.top <= inner.top + tolerance &&
        outer.right >= inner.right - tolerance &&
        outer.bottom >= inner.bottom - tolerance;
  }

  Future<void> bake(
    DocumentLoaded blocState, {
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool resetAllLayers = false,
  }) => rendererCubit.bakeLock.synchronized(() async {
    if (isClosed) return;
    var cameraViewport = rendererCubit.state.cameraViewport;
    final startTransform = transformCubit.state;
    final startViewport = cameraViewport;
    final resolution = settingsCubit.state.renderResolution;
    var size = viewportSize ?? cameraViewport.toSize();
    final ratio = pixelRatio ?? cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    if (viewportSize == null) {
      size /= resolution.multiplier;
    }
    var transform = transformCubit.state;
    var renderers = List<Renderer<PadElement>>.from(rendererCubit.renderers);
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final rect = getViewportRect(viewportSize: size);
    size = rect.size * transform.size;
    final renderTransform = transform.improve(resolution, rect);
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final imageWidth = (size.width * ratio).ceil();
    final imageHeight = (size.height * ratio).ceil();
    var allRendererStates = rendererCubit.state.allRendererStates;
    final rendererStatesChanged = !mapEquals(
      allRendererStates,
      cameraViewport.rendererStates,
    );
    if (!rendererStatesChanged) {
      allRendererStates = cameraViewport.rendererStates;
    }
    final invisibleLayers = blocState.invisibleLayers;
    final viewportAlreadyCoversRect =
        cameraViewport.image != null &&
        cameraViewport.scale == transform.size &&
        cameraViewport.resolution == resolution &&
        cameraViewport.pixelRatio == ratio &&
        !rendererStatesChanged &&
        setEquals(cameraViewport.invisibleLayers, invisibleLayers) &&
        _rectContains(cameraViewport.toRect(), rect);
    final viewChanged =
        !viewportAlreadyCoversRect &&
        (cameraViewport.width != size.width.ceil() ||
            cameraViewport.height != size.height.ceil() ||
            cameraViewport.pixelRatio != ratio ||
            cameraViewport.resolution != resolution ||
            cameraViewport.x != renderTransform.position.dx ||
            cameraViewport.y != renderTransform.position.dy ||
            cameraViewport.scale != transform.size ||
            rendererStatesChanged ||
            !setEquals(cameraViewport.invisibleLayers, invisibleLayers));
    reset = reset || viewChanged;
    resetAllLayers = resetAllLayers || viewChanged;
    if (cameraViewport.unbakedElements.isEmpty && !reset) return;
    final currentLayer = blocState.currentLayer;
    List<Renderer<PadElement>> visibleElements;
    final oldVisible = cameraViewport.visibleElements;
    final oldVisibleSet = oldVisible.toSet();
    talker.verbose(
      'Baking viewport (reset: $reset, viewChanged: $viewChanged, '
      'rendererStatesChanged: $rendererStatesChanged)',
    );

    if (reset) {
      visibleElements = renderers
          .where((renderer) => renderer.isVisible(rect))
          .toList();
    } else {
      visibleElements = List.from(oldVisible)
        ..addAll(
          cameraViewport.unbakedElements.where(
            (renderer) =>
                !oldVisibleSet.contains(renderer) && renderer.isVisible(rect),
          ),
        );
    }

    final visibleElementsSet = visibleElements.toSet();

    await _updateOnVisible(
      cameraViewport.unbake(visibleElements: visibleElements),
      blocState,
      renderTransform: renderTransform,
      targetSize: size,
    );

    canvas.scale(ratio);

    if (viewChanged && visibleElements.isNotEmpty) {
      await Future.wait(
        visibleElements.map(
          (e) async =>
              await e.updateView(this, blocState, renderTransform, size),
        ),
      );
    }

    // Wait one frame
    await Future.delayed(const Duration(milliseconds: 1));

    ViewPainter(
      document,
      page,
      info,
      transform: renderTransform,
      cameraViewport: reset
          ? cameraViewport.unbake(
              rendererStates: allRendererStates,
              unbakedElements: visibleElements
                  .where((e) => currentLayer == e.layer)
                  .toList(),
              visibleElements: visibleElements,
            )
          : cameraViewport,
      renderBackground: false,
      renderBaked: !reset,
      renderBakedLayers: false,
      invisibleLayers: invisibleLayers,
    ).paint(canvas, size);

    final picture = recorder.endRecording();
    ui.Image newImage;
    try {
      newImage = await picture.toImage(imageWidth, imageHeight);
    } finally {
      picture.dispose();
    }

    var belowLayerImage = cameraViewport.belowLayerImage;
    var aboveLayerImage = cameraViewport.aboveLayerImage;

    if (resetAllLayers) {
      final belowLayerRecorder = ui.PictureRecorder();
      final belowLayerCanvas = ui.Canvas(belowLayerRecorder);
      belowLayerCanvas.scale(ratio);
      final aboveLayerRecorder = ui.PictureRecorder();
      final aboveLayerCanvas = ui.Canvas(aboveLayerRecorder);
      aboveLayerCanvas.scale(ratio);
      final belowLayers = <String>{}, aboveLayers = <String>{};
      bool above = false;
      for (final layer in page.layers) {
        if (layer.id == currentLayer) {
          above = true;
          continue;
        }
        final layerId = layer.id;
        if (layerId == null) continue;
        if (above) {
          aboveLayers.add(layerId);
        } else {
          belowLayers.add(layerId);
        }
      }

      ViewPainter(
        document,
        page,
        info,
        transform: renderTransform,
        cameraViewport: cameraViewport.unbake(
          rendererStates: allRendererStates,
          unbakedElements: visibleElements
              .where((e) => e.layer != null && belowLayers.contains(e.layer))
              .toList(),
          visibleElements: visibleElements,
        ),
        renderBackground: false,
        renderBaked: false,
        invisibleLayers: invisibleLayers,
      ).paint(belowLayerCanvas, size);
      ViewPainter(
        document,
        page,
        info,
        transform: renderTransform,
        cameraViewport: cameraViewport.unbake(
          rendererStates: allRendererStates,
          unbakedElements: visibleElements
              .where((e) => e.layer != null && aboveLayers.contains(e.layer))
              .toList(),
          visibleElements: visibleElements,
        ),
        renderBackground: false,
        renderBaked: false,
        invisibleLayers: invisibleLayers,
      ).paint(aboveLayerCanvas, size);

      final belowPicture = belowLayerRecorder.endRecording();
      final abovePicture = aboveLayerRecorder.endRecording();
      try {
        final result = await Future.wait([
          belowPicture.toImage(imageWidth, imageHeight),
          abovePicture.toImage(imageWidth, imageHeight),
        ]);
        belowLayerImage = result[0];
        aboveLayerImage = result[1];
      } finally {
        belowPicture.dispose();
        abovePicture.dispose();
      }
    }

    final bakedElementsSet = cameraViewport.bakedElements
        .map((e) => e.element)
        .toSet();
    final unbakedElementsSet = cameraViewport.unbakedElements
        .map((e) => e.element)
        .toSet();

    final newlyUnbaked =
        (reset
                ? rendererCubit.renderers
                : rendererCubit.state.cameraViewport.unbakedElements)
            .where(
              (element) =>
                  !bakedElementsSet.contains(element.element) &&
                  !unbakedElementsSet.contains(element.element) &&
                  !visibleElementsSet.contains(element),
            )
            .toList();

    if (isClosed) return;

    // If state changed while baking (e.g. fast move submitted a newer viewport),
    // this bake output is stale and must not overwrite the latest viewport.
    final currentViewport = rendererCubit.state.cameraViewport;
    final currentTransform = transformCubit.state;
    if (!identical(currentViewport, startViewport) ||
        currentTransform != startTransform) {
      newImage.dispose();
      final oldBelow = startViewport.belowLayerImage;
      final oldAbove = startViewport.aboveLayerImage;
      if (!identical(belowLayerImage, oldBelow)) {
        belowLayerImage?.dispose();
      }
      if (!identical(aboveLayerImage, oldAbove)) {
        aboveLayerImage?.dispose();
      }
      Future.microtask(() async {
        final latestState = _activeDocumentState;
        if (latestState == null) return;
        await bake(
          latestState,
          viewportSize: viewportSize,
          pixelRatio: pixelRatio,
          reset: reset,
          resetAllLayers: resetAllLayers,
        );
      });
      return;
    }

    final newViewport = cameraViewport.bake(
      height: size.height,
      width: size.width,
      pixelRatio: ratio,
      resolution: resolution,
      scale: transform.size,
      x: renderTransform.position.dx,
      y: renderTransform.position.dy,
      image: newImage,
      bakedElements: renderers,
      unbakedElements: newlyUnbaked,
      visibleElements: visibleElements,
      visibleUnbakedElements: newlyUnbaked
          .where((renderer) => renderer.isVisible(rect))
          .toList(),
      belowLayerImage: belowLayerImage,
      aboveLayerImage: aboveLayerImage,
      rendererStates: allRendererStates,
      invisibleLayers: invisibleLayers,
    );
    rendererCubit.setViewport(newViewport);
  });

  Future<ui.Image?> renderImage(
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options, {
    CameraViewport? cameraViewport,
    Set<String>? invisibleLayers,
    DocumentLoaded? docState,
  }) async {
    final realWidth = (options.width * options.quality).ceil();
    final realHeight = (options.height * options.quality).ceil();
    final realZoom = options.scale;
    if (realWidth <= 0 || realHeight <= 0) {
      return null;
    }
    final size = Size(options.width, options.height);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.scale(options.quality);
    final viewport =
        cameraViewport ??
        rendererCubit.state.cameraViewport.unbake(
          unbakedElements: rendererCubit.renderers,
        );
    final transform = CameraTransform(
      options.quality,
      Offset(options.x, options.y),
      realZoom,
    );
    final hiddenRenderers = <Renderer<PadElement>>[];
    if (docState != null) {
      final exportRect = Rect.fromLTWH(
        options.x,
        options.y,
        options.width,
        options.height,
      );
      for (final renderer in viewport.unbakedElements) {
        if (renderer.isVisible(exportRect)) {
          final wasInitialized = rendererCubit.initializedElements.contains(
            renderer,
          );
          if (!wasInitialized) {
            await renderer.onVisible(this, docState, transform, size);
            hiddenRenderers.add(renderer);
          }
        }
      }
    }
    final painter = ViewPainter(
      document,
      page,
      info,
      renderBackground: options.renderBackground,
      invisibleLayers: invisibleLayers,
      cameraViewport: viewport,
      transform: transform,
    );
    painter.paint(canvas, size);
    for (final renderer in hiddenRenderers) {
      await renderer.onHidden(this, docState!, transform, size);
    }
    final picture = recorder.endRecording();
    ui.Image? image;
    try {
      image = await picture.toImage(realWidth, realHeight);
    } finally {
      picture.dispose();
    }
    return image;
  }

  Future<ByteData?> render(
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options, {
    CameraViewport? cameraViewport,
    Set<String>? invisibleLayers,
    DocumentLoaded? docState,
  }) async {
    final image = await renderImage(
      document,
      page,
      info,
      options,
      cameraViewport: cameraViewport,
      invisibleLayers: invisibleLayers,
      docState: docState,
    );
    ByteData? bytes;
    try {
      bytes = await image?.toByteData(format: ui.ImageByteFormat.png);
    } finally {
      image?.dispose();
    }
    return bytes;
  }

  XmlDocument renderSVG(
    NoteData document,
    DocumentPage page,
    SvgExportOptions options, {
    Set<String>? invisibleLayers,
  }) {
    final xml = XmlDocument();
    xml.createElement(
      'svg',
      attributes: {
        'xmlns': 'http://www.w3.org/2000/svg',
        'xmlns:xlink': 'http://www.w3.org/1999/xlink',
        'version': '1.1',
        'width': '${options.width}px',
        'height': '${options.height}px',
        'viewBox':
            '${options.x} ${options.y} ${options.width} ${options.height}',
      },
    );

    final rect = Rect.fromLTWH(
      options.x,
      options.y,
      options.width.toDouble(),
      options.height.toDouble(),
    );
    if (options.renderBackground) {
      for (final e in rendererCubit.state.cameraViewport.backgrounds) {
        e.buildSvg(xml, document, page, rect);
      }
    }
    for (var e in rendererCubit.renderers) {
      if ((invisibleLayers?.contains(e.layer) ?? false) || !e.isVisible(rect)) {
        continue;
      }
      e.buildSvg(xml, document, page, rect);
    }
    return xml;
  }

  Future<void> unbake(
    DocumentLoaded blocState, {
    List<Renderer<Background>>? backgrounds,
    List<Renderer<PadElement>>? unbakedElements,
  }) async {
    final elementsToCheck = unbakedElements ?? rendererCubit.renderers;
    final oldViewport = rendererCubit.state.cameraViewport;
    final newViewport = oldViewport.unbake(
      unbakedElements: unbakedElements,
      visibleElements: elementsToCheck
          .where((e) => e.isVisible(getViewportRect()))
          .toList(),
      backgrounds: backgrounds,
    );
    await _updateOnVisible(newViewport, blocState);
    rendererCubit.setViewport(newViewport);
  }

  Future<void> replaceUnbaked(
    DocumentLoaded blocState,
    List<Renderer<PadElement>> unbakedElements, {
    List<Renderer<Background>>? backgrounds,
  }) async {
    final visibleElements = unbakedElements
        .where((e) => e.isVisible(getViewportRect()))
        .toList();
    final newViewport = rendererCubit.state.cameraViewport.replaceUnbaked(
      unbakedElements,
      visibleElements: visibleElements,
      visibleUnbakedElements: visibleElements,
      backgrounds: backgrounds,
    );
    await _updateOnVisible(newViewport, blocState);
    rendererCubit.setViewport(newViewport);
  }

  Future<void> loadElements(
    DocumentState docState, {
    bool reset = false,
  }) async {
    if (docState is! DocumentLoaded) return;
    final document = docState.data;
    final assetService = docState.assetService;
    final page = docState.page;
    var existing = rendererCubit.renderers;
    if (reset) {
      for (var e in existing) {
        rendererCubit.initializedElements.remove(e);
        e.dispose();
      }
      existing = [];
    }
    final elements = page.layers
        .where((e) => !docState.invisibleLayers.contains(e.id))
        .expand((l) => l.content.map((e) => (e, l.id)))
        .toList();
    final elementKeys = elements
        .map((element) => (element.$1, element.$2))
        .toSet();
    final existingByKey = {
      for (final renderer in existing)
        (renderer.element, renderer.layer): renderer,
    };
    final reusable = <Renderer<PadElement>>[];
    final reusableKeys = <(PadElement, String?)>{};
    for (final element in elements) {
      final key = (element.$1, element.$2);
      final renderer = existingByKey[key];
      if (renderer != null) {
        reusable.add(renderer);
        reusableKeys.add(key);
      }
    }
    final dropped = existing
        .where(
          (renderer) =>
              !elementKeys.contains((renderer.element, renderer.layer)),
        )
        .toList();
    for (final e in dropped) {
      rendererCubit.initializedElements.remove(e);
      e.dispose();
    }
    final newRenderers = elements
        .where((e) => !reusableKeys.contains((e.$1, e.$2)))
        .map((e) => Renderer.fromInstance(e.$1, e.$2))
        .toList();
    await Future.wait(
      newRenderers.map(
        (e) async =>
            await e.setup(transformCubit, document, assetService, page),
      ),
    );
    // Build layer index map for O(1) lookups instead of O(n) indexOf calls
    final layersList = page.layers.map((e) => e.id).toList();
    final layerIndexMap = <String?, int>{};
    for (var i = 0; i < layersList.length; i++) {
      layerIndexMap[layersList[i]] = i;
    }

    // Build element index map for O(1) lookups
    final elementIndexMap = <PadElement, int>{};
    for (var i = 0; i < elements.length; i++) {
      elementIndexMap[elements[i].$1] = i;
    }

    final combined = [...reusable, ...newRenderers]
      ..sort((a, b) {
        final layerA = layerIndexMap[a.layer] ?? layersList.length;
        final layerB = layerIndexMap[b.layer] ?? layersList.length;
        if (layerA != layerB) return layerA.compareTo(layerB);
        final indexA = elementIndexMap[a.element] ?? -1;
        final indexB = elementIndexMap[b.element] ?? -1;
        return indexA.compareTo(indexB);
      });
    final backgrounds = page.backgrounds.map(Renderer.fromInstance).toList();
    await Future.wait(
      backgrounds.map(
        (e) async =>
            await e.setup(transformCubit, document, assetService, page),
      ),
    );
    final rect = getViewportRect();
    final visibleElements = combined.where((e) => e.isVisible(rect)).toList();
    final oldViewport = rendererCubit.state.cameraViewport;
    final newViewport = oldViewport.unbake(
      unbakedElements: combined,
      visibleElements: visibleElements,
      backgrounds: backgrounds,
    );
    await _updateOnVisible(newViewport, docState);
    saveCubit.setSaveState(
      location: saveCubit.state.embedding?.location ?? saveCubit.state.location,
    );
    rendererCubit.setViewport(newViewport);
  }

  Future<void> addUnbaked(
    DocumentLoaded blocState,
    List<Renderer<PadElement>> unbakedElements, [
    List<Renderer<PadElement>>? visibleElements,
  ]) async {
    final rect = getViewportRect();
    visibleElements ??= unbakedElements
        .where((e) => e.isVisible(rect))
        .toList();
    final nextUnbaked = [
      ...rendererCubit.state.cameraViewport.unbakedElements,
      ...unbakedElements,
    ];
    final newViewport = rendererCubit.state.cameraViewport.withUnbaked(
      nextUnbaked,
      visibleElements: [
        ...rendererCubit.state.cameraViewport.visibleElements,
        ...visibleElements,
      ],
      visibleUnbakedElements: [
        ...rendererCubit.state.cameraViewport.visibleUnbakedElements,
        ...visibleElements,
      ],
    );
    await _updateOnVisible(newViewport, blocState);
    rendererCubit.setViewport(newViewport);
  }

  void setSaveState({
    AssetLocation? location,
    SaveState? saved,
    bool absolute = false,
    bool? isCreating,
    bool keepRead = false,
  }) => saveCubit.setSaveState(
    location: location,
    saved: saved,
    absolute: absolute,
    isCreating: isCreating,
    keepRead: keepRead,
  );

  Future<Uint8List?> renderPDF(
    DocumentLoaded docState, {
    required List<AreaPreset> areas,
    bool renderBackground = true,
    void Function(double progress)? onProgress,
    Set<String>? invisibleLayers,
  }) async {
    var name = docState.metadata.name;
    if (name.isEmpty) {
      name = 'document';
    }
    final pdf = await PdfDocument.createNew(sourceName: '$name.pdf');
    final document = docState.data;
    final info = docState.info;
    final pages = <PdfPage>[];
    final documents = <PdfDocument>[];
    for (var i = 0; i < areas.length; i++) {
      onProgress?.call(i / areas.length);
      final preset = areas[i];
      final areaName = preset.name;
      final quality = preset.quality;
      final currentOpened = docState.pageName == preset.page;
      final page = currentOpened
          ? docState.page
          : document.getPage(preset.page);
      final area = preset.area ?? page?.getAreaByName(areaName);
      if (area == null || page == null) {
        continue;
      }
      final image = await renderImage(
        document,
        page,
        info,
        ImageExportOptions(
          width: area.width,
          height: area.height,
          x: area.position.x,
          y: area.position.y,
          quality: quality,
          renderBackground: renderBackground,
        ),
        cameraViewport: await CameraViewport.build(
          transformCubit,
          document,
          docState.assetService,
          page,
        ),
        docState: docState,
        invisibleLayers: invisibleLayers ?? docState.invisibleLayers,
      );
      if (image == null) continue;
      final imgImage = await convertFlutterUiToImage(image);
      final pdfImage = await compute(
        (image) => img.JpegEncoder().encode(image),
        imgImage,
      );
      final imageDoc = await PdfDocument.createFromJpegData(
        pdfImage,
        width: area.width,
        height: area.height,
        sourceName: '$name-$areaName.jpg',
      );
      pages.addAll(imageDoc.pages);
      image.dispose();
      documents.add(imageDoc);
    }
    onProgress?.call(1.0);
    pdf.pages = pages;
    final bytes = await pdf.encodePdf();
    pdf.dispose();
    for (final doc in documents) {
      doc.dispose();
    }
    return bytes;
  }

  void updateIndex(DocumentBloc bloc) {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    final info = docState.info;
    final index = info.tools.indexOf(toolCubit.state.handler.data);
    if (index < 0) {
      changeTool(bloc, index: toolCubit.state.index ?? 0);
    }
    if (index == toolCubit.state.index) {
      return;
    }
    toolCubit.setIndex(index);
    final selection = toolCubit.state.selection;
    if (selection?.selected.contains(toolCubit.state.handler.data) ?? false) {
      toolCubit.resetSelection();
    }
  }

  Rect getContentRect([Area? currentArea]) {
    if (currentArea != null) {
      return currentArea.rect;
    }
    final renderers = rendererCubit.renderers;
    if (renderers.isEmpty) {
      return Rect.zero;
    }

    var minX = double.infinity;
    var minY = double.infinity;
    var maxX = double.negativeInfinity;
    var maxY = double.negativeInfinity;

    for (final renderer in rendererCubit.renderers) {
      final rect = renderer.expandedRect;
      if (rect != null) {
        minX = min(minX, rect.left);
        minY = min(minY, rect.top);
        maxX = max(maxX, rect.right);
        maxY = max(maxY, rect.bottom);
      }
    }

    if (minX == double.infinity) {
      return Rect.zero;
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  CameraTransform _clampTransform(CameraTransform transform) {
    final bounds = _calculateViewportBounds(null, transform);
    if (bounds == null) return transform;
    return transform.withPosition(
      Offset(
        transform.position.dx.clamp(bounds.left, bounds.right),
        transform.position.dy.clamp(bounds.top, bounds.bottom),
      ),
    );
  }

  bool _isNavigationRailVisible() {
    final settings = settingsCubit.state;
    final viewport = rendererCubit.state.cameraViewport;
    return settings.navigationRail &&
        settings.navigatorPosition == NavigatorPosition.left &&
        inputCubit.state.hideUi == HideState.visible &&
        (viewport.width ?? 0) >= LeapBreakpoints.expanded &&
        (viewport.height ?? 0) >= 400;
  }

  Rect? _calculateViewportBounds([
    Area? currentArea,
    CameraTransform? customTransform,
  ]) {
    final settings = settingsCubit.state;
    var multiplier = settings.limitViewportMultiplier;
    final positive = settings.limitViewportPositive;

    if (multiplier == null && !positive && currentArea == null) return null;

    final viewport = rendererCubit.state.cameraViewport;
    final transform = customTransform ?? transformCubit.state;
    final navigationRailOffset = _isNavigationRailVisible()
        ? kNavigationRailWidth / transform.size
        : 0.0;
    final size =
        Size(
          ((viewport.width ?? 0) / transform.size) - navigationRailOffset,
          (viewport.height ?? 0) / transform.size,
        ) /
        settings.renderResolution.multiplier;

    final contentRect = getContentRect(currentArea);

    double minX = double.negativeInfinity;
    double minY = double.negativeInfinity;
    double maxX = double.infinity;
    double maxY = double.infinity;

    if (multiplier != null || currentArea != null) {
      multiplier ??= 1;
      final padX = size.width * multiplier;
      final padY = size.height * multiplier;

      minX = contentRect.left - padX;
      minY = contentRect.top - padY;
      maxX = contentRect.right - size.width + padX;
      maxY = contentRect.bottom - size.height + padY;

      if (minX > maxX) {
        final mid = (minX + maxX) / 2;
        minX = mid;
        maxX = mid;
      }
      if (minY > maxY) {
        final mid = (minY + maxY) / 2;
        minY = mid;
        maxY = mid;
      }
    }

    if (positive && currentArea == null) {
      minX = max(-navigationRailOffset, minX);
      minY = max(0.0, minY);
      maxX = max(-navigationRailOffset, maxX);
      maxY = max(0.0, maxY);
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  Area? getRelativeArea(Area currentArea, int dx, int dy, [bool? exact]) {
    if (dx == 0 && dy == 0) return null;
    final docState = _activeDocumentState;
    if (docState is! DocumentLoadSuccess) return null;

    final rect = currentArea.rect.translate(
      dx.toDouble() * currentArea.rect.width,
      dy.toDouble() * currentArea.rect.height,
    );

    return docState.page.areas.firstWhereOrNull((area) {
      final currentAreaRect = area.rect;
      if (exact ?? viewCubit.state.areaNavigatorExact) {
        return (currentAreaRect.top - rect.top).abs() <
                precisionErrorTolerance &&
            (currentAreaRect.left - rect.left).abs() <
                precisionErrorTolerance &&
            (currentAreaRect.width - rect.width).abs() <
                precisionErrorTolerance &&
            (currentAreaRect.height - rect.height).abs() <
                precisionErrorTolerance;
      }
      return currentAreaRect.overlaps(rect.deflate(precisionErrorTolerance));
    });
  }

  void _teleportToAreaEdge(Area area, int dx, int dy) {
    final newBounds = _calculateViewportBounds(area);
    if (newBounds == null) return;

    final pos = transformCubit.state.position;
    double newX = pos.dx;
    double newY = pos.dy;
    if (dx > 0) {
      newX = newBounds.left;
    } else if (dx < 0) {
      newX = newBounds.right;
    } else {
      newX = newX.clamp(newBounds.left, newBounds.right);
    }
    if (dy > 0) {
      newY = newBounds.top;
    } else if (dy < 0) {
      newY = newBounds.bottom;
    } else {
      newY = newY.clamp(newBounds.top, newBounds.bottom);
    }
    transformCubit.teleport(Offset(newX, newY));
  }

  Future<void> navigateToRelativeArea(
    int dx,
    int dy, {
    Future<String?> Function()? createAreaName,
  }) async {
    final docState = _activeDocumentState;
    if (docState is! DocumentLoadSuccess) return;

    final current = docState.currentArea;
    if (current == null) return;

    var area = getRelativeArea(current, dx, dy);
    if (area != null) {
      _activeDocumentBloc?.add(CurrentAreaChanged(area.name));
      _teleportToAreaEdge(area, dx, dy);
      return;
    }

    if (!viewCubit.state.areaNavigatorCreate || createAreaName == null) return;
    final name = await createAreaName();
    if (name == null) return;

    final rect = current.rect.translate(
      dx.toDouble() * current.rect.width,
      dy.toDouble() * current.rect.height,
    );

    final newArea = Area(
      position: rect.topLeft.toPoint(),
      height: rect.height,
      width: rect.width,
      name: name,
    );
    final bloc = _activeDocumentBloc;
    bloc?.add(AreasCreated([AreaPreset(area: newArea)]));
    bloc?.add(CurrentAreaChanged(name));
    _teleportToAreaEdge(newArea, dx, dy);
  }

  void move(Offset delta, {bool force = false, Area? currentArea}) {
    final utilitiesState = viewCubit.state.utilities;
    if (!force) {
      if (utilitiesState.lockHorizontal) delta = Offset(0, delta.dy);
      if (utilitiesState.lockVertical) delta = Offset(delta.dx, 0);

      final bounds = _calculateViewportBounds(currentArea);
      if (bounds != null) {
        final pos = transformCubit.state.position;
        var newPos = pos + delta;
        final clampedPos = Offset(
          newPos.dx.clamp(bounds.left, bounds.right),
          newPos.dy.clamp(bounds.top, bounds.bottom),
        );

        if (currentArea != null &&
            (clampedPos.dx != newPos.dx || clampedPos.dy != newPos.dy)) {
          int dx = 0;
          int dy = 0;
          if (newPos.dx < bounds.left) {
            dx = -1;
          } else if (newPos.dx > bounds.right) {
            dx = 1;
          }

          if (newPos.dy < bounds.top) {
            dy = -1;
          } else if (newPos.dy > bounds.bottom) {
            dy = 1;
          }

          if ((dx != 0 || dy != 0) &&
              settingsCubit.state.hasFlag('edgePanAreaSwitching')) {
            final area = getRelativeArea(currentArea, dx, dy);
            if (area != null) {
              _activeDocumentBloc?.add(CurrentAreaChanged(area.name));
              _teleportToAreaEdge(area, dx, dy);
              return;
            }
          }
        }

        delta = clampedPos - pos;
      }
    }

    if (delta.dx == 0 && delta.dy == 0) {
      return;
    }
    transformCubit.move(delta);
  }

  void zoom(double delta, [Offset cursor = Offset.zero, bool force = false]) {
    final utilitiesState = viewCubit.state.utilities;
    if (utilitiesState.lockZoom && !force) {
      delta = 1;
    }
    if (delta == 1) {
      return;
    }
    if (force) {
      transformCubit.zoom(delta, cursor);
      return;
    }
    final transform = transformCubit.state.withSize(
      transformCubit.state.size * delta,
      cursor,
    );
    final clamped = _clampTransform(transform);
    transformCubit.teleport(clamped.position, clamped.size);
  }

  void size(double size, [Offset cursor = Offset.zero, bool force = false]) {
    final utilitiesState = viewCubit.state.utilities;
    if (utilitiesState.lockZoom && !force) return;
    if (force) {
      transformCubit.size(size, cursor);
      return;
    }
    final transform = _clampTransform(
      transformCubit.state.withSize(size, cursor),
    );
    transformCubit.teleport(transform.position, transform.size);
  }

  void slide(
    Offset positionVelocity,
    double sizeVelocity, {
    bool force = false,
    Area? currentArea,
  }) {
    final settings = settingsCubit.state;
    if (!settings.hasFlag('smoothNavigation')) return;
    final utilitiesState = viewCubit.state.utilities;
    Rect? bounds;
    var outOfBounds = false;
    if (!force) {
      if (utilitiesState.lockHorizontal) {
        positionVelocity = Offset(0, positionVelocity.dy);
      }
      if (utilitiesState.lockVertical) {
        positionVelocity = Offset(positionVelocity.dx, 0);
      }
      if (utilitiesState.lockZoom) sizeVelocity = 0;

      bounds = _calculateViewportBounds(currentArea);
      if (bounds != null) {
        final pos = transformCubit.state.position;
        final clampedPos = Offset(
          pos.dx.clamp(bounds.left, bounds.right),
          pos.dy.clamp(bounds.top, bounds.bottom),
        );
        outOfBounds = clampedPos != pos;
        var vX = positionVelocity.dx;
        var vY = positionVelocity.dy;

        // velocity > 0 means moving right (increasing pos) -> clamp if pos >= maxX
        // velocity < 0 means moving left (decreasing pos) -> clamp if pos <= minX
        if (pos.dx >= bounds.right && vX > 0) {
          vX = 0;
        }
        if (pos.dx <= bounds.left && vX < 0) {
          vX = 0;
        }
        if (pos.dy >= bounds.bottom && vY > 0) {
          vY = 0;
        }
        if (pos.dy <= bounds.top && vY < 0) {
          vY = 0;
        }

        positionVelocity = Offset(vX, vY);
      }
    }

    if (positionVelocity.dx == 0 &&
        positionVelocity.dy == 0 &&
        sizeVelocity == 0 &&
        !outOfBounds) {
      return;
    }
    cancelDelayedBake();
    transformCubit.slide(
      positionVelocity,
      sizeVelocity,
      positionBounds: bounds,
    );
  }

  ExternalStorage? getRemoteStorage() =>
      settingsCubit.getRemote(saveCubit.state.location.remote);

  bool hasAutosave() =>
      settingsCubit.state.autosave &&
      (networkingService.isActive ||
          !(saveCubit.state.embedding?.save ?? true) ||
          (!kIsWeb &&
              !saveCubit.state.absolute &&
              (saveCubit.state.location.isEmpty ||
                  (saveCubit.state.location.fileType?.isNote() ?? false)) &&
              (saveCubit.state.location.remote.isEmpty ||
                  (settingsCubit
                          .getRemote(saveCubit.state.location.remote)
                          ?.hasDocumentCached(saveCubit.state.location.path) ??
                      false))));

  Future<AssetLocation> save(
    DocumentBloc bloc, {
    AssetLocation? location,
    bool force = false,
    bool isAutosave = false,
  }) async {
    final absolute = saveCubit.state.absolute;
    if (location == null &&
        !force &&
        (saveCubit.state.saved == SaveState.saved ||
            saveCubit.state.saved == SaveState.absoluteRead)) {
      return saveCubit.state.location;
    }
    if (networkingService.isClient) {
      return AssetLocation.empty;
    }
    if (saveCubit.state.isSaveDelayed && isAutosave) {
      return saveCubit.state.location;
    }
    final storage = getRemoteStorage();
    final fileSystem = bloc.state.fileSystem.buildDocumentSystem(storage);
    final isDelayed = settingsCubit.state.delayedAutosave;
    if (isDelayed && isAutosave) {
      final seconds = max(0, settingsCubit.state.autosaveDelaySeconds);
      saveCubit.setDelayed(true);
      await Future.delayed(Duration(seconds: seconds));
      if (!saveCubit.state.isSaveDelayed) {
        return saveCubit.state.location;
      }
    }
    return saveCubit.savingLock.synchronized(() async {
      if (location == null &&
          !force &&
          (saveCubit.state.saved == SaveState.saved ||
              saveCubit.state.saved == SaveState.absoluteRead)) {
        return saveCubit.state.location;
      }
      var current = location ?? saveCubit.state.location;
      if (isClosed) {
        return current;
      }
      saveCubit.setSaveState(saved: SaveState.saving, location: current);
      saveCubit.setDelayed(false);
      final blocState = bloc.state;
      final currentData = await blocState.saveData();
      if (isClosed) {
        return current;
      }
      if (currentData == null || saveCubit.state.embedding != null) {
        saveCubit.setSaveState(saved: SaveState.saved);
        return AssetLocation.empty;
      }
      if (absolute || !(current.fileType?.isNote() ?? false)) {
        final file = await compute(_toFile, (currentData, false));
        final document = await fileSystem.createFileWithName(
          name: currentData.name,
          suffix: '.bfly',
          directory: absolute
              ? null
              : current.fileExtension.isEmpty
              ? saveCubit.state.location.path
              : saveCubit.state.location.parent,
          file,
        );
        current = document.location;
      } else {
        final file = await compute(_toFile, (
          currentData,
          current.fileType == AssetFileType.textNote,
        ));
        await fileSystem.updateFile(current.path, file);
      }
      settingsCubit.addRecentHistory(current);
      if (isClosed) {
        return current;
      }
      saveCubit.setSaveState(
        saved: saveCubit.state.saved == SaveState.saving
            ? SaveState.saved
            : saveCubit.state.saved,
        location: current,
      );
      return current;
    });
  }

  Future<void> close() async {
    if (_closed) return;
    _isClosing = true;
    _closed = true;
    final bloc = _activeDocumentBloc;
    if (bloc != null) {
      await toolCubit.disposeRuntime(bloc);
    }
    _documentBloc = null;
    await rendererCubit.disposeRuntime();
    await _transformSubscription?.cancel();
    _transformSubscription = null;
    await _rendererSubscription?.cancel();
    _rendererSubscription = null;
    await _toolSubscription?.cancel();
    _toolSubscription = null;
    await _inputSubscription?.cancel();
    _inputSubscription = null;
    await _viewSubscription?.cancel();
    _viewSubscription = null;
    _transformDebounceTimer?.cancel();
    _transformDebounceTimer = null;
    _networkingDebounceTimer?.cancel();
    _networkingDebounceTimer = null;
    await rendererCubit.close();
    await toolCubit.close();
    await inputCubit.close();
    await saveCubit.close();
    await viewCubit.close();
    if (!networkingService.isClosed) {
      await networkingService.close();
    }
  }

  Rect getPageRect({Set<String>? invisibleLayers}) {
    Rect? rect;
    for (final renderer in rendererCubit.renderers) {
      final rendererRect = renderer.expandedRect;
      if (rendererRect == null) continue;
      if (invisibleLayers?.contains(renderer.layer) ?? false) {
        continue;
      }
      rect = rect?.expandToInclude(rendererRect) ?? rendererRect;
    }
    return rect ?? Rect.zero;
  }

  /// If addedElements is null, the viewport gets unbaked
  Future<void> stateChanged(
    DocumentLoadSuccess current,
    DocumentBloc bloc, {
    DocumentLoadSuccess? oldState,
    List<Renderer<PadElement>> addedElements = const [],
    List<Renderer<PadElement>>? replacedElements,
    List<Renderer<Background>>? backgrounds,
    bool reset = false,
    bool unbake = false,
    bool Function()? shouldRefresh,
    bool updateIndex = false,
  }) async {
    cancelDelayedBake();
    for (var renderer in {
      ...?backgrounds,
      ...?replacedElements,
      ...addedElements,
    }) {
      await renderer.setup(
        transformCubit,
        current.data,
        current.assetService,
        current.page,
      );
    }
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    toolCubit.state.handler.onDocumentUpdated(blocState, oldState);

    final addsCombinedHighlight = addedElements.any(
      (renderer) =>
          renderer is PenRenderer && renderer.element.combineId != null,
    );
    if (replacedElements != null) {
      await replaceUnbaked(blocState, [
        ...replacedElements,
        ...addedElements,
      ], backgrounds: backgrounds);
    } else if (addsCombinedHighlight) {
      await this.unbake(
        blocState,
        unbakedElements: [...rendererCubit.renderers, ...addedElements],
      );
    } else if (unbake) {
      await this.unbake(blocState, backgrounds: backgrounds);
    } else if (backgrounds != null) {
      await this.unbake(blocState, backgrounds: backgrounds);
    } else {
      await addUnbaked(blocState, addedElements);
    }

    setSaveState(saved: SaveState.unsaved);
    if (saveCubit.state.embedding != null) {
      return;
    }
    if (reset) {
      await reload(bloc, current);
    } else {
      final refreshRequested = shouldRefresh?.call() == true;
      if (refreshRequested) {
        // For replacement updates we force a reset bake below, so avoid
        // scheduling an extra delayed bake from refresh().
        await refresh(current, allowBake: replacedElements == null);
      }
      if (replacedElements != null) {
        await bake(blocState, reset: true);
      }
    }
    if (updateIndex) {
      this.updateIndex(bloc);
    }
    if (hasAutosave()) {
      save(bloc, isAutosave: true);
    }
  }

  Future<void> updateTogglingTools(DocumentBloc bloc, List<Tool> tools) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final newHandlers = Map<int, Handler<Tool>>.from(
      toolCubit.state.toggleableHandlers,
    );
    final newForegrounds = Map<int, List<Renderer>>.from(
      toolCubit.state.toggleableForegrounds,
    );
    final currentTools = blocState.info.tools;
    for (final tool in tools) {
      if (tool.id == null) continue;
      final index = currentTools.indexWhere((element) => element.id == tool.id);
      if (index == -1) continue;
      final old = toolCubit.state.toggleableHandlers[index];
      if (old == null) continue;
      if (old.data == tool) continue;
      old.dispose(bloc);
      for (final r in toolCubit.state.toggleableForegrounds[index] ?? []) {
        r.dispose();
      }
      final handler = Handler.fromTool(tool);
      final document = blocState.data;
      final page = blocState.page;
      final info = blocState.info;
      final currentArea = blocState.currentArea;
      final foregrounds = handler.createForegrounds(
        this,
        document,
        page,
        info,
        currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              transformCubit,
              document,
              blocState.assetService,
              page,
            ),
          ),
        );
      }
      newHandlers[index] = handler;
      newForegrounds[index] = foregrounds;
    }
    toolCubit.setToggleable(handlers: newHandlers, foregrounds: newForegrounds);
  }

  void cancelDelayedBake() {
    rendererCubit.delayedBakeRunner.cancel();
  }

  Future<void> delayedBake(
    DocumentLoaded blocState, {
    ui.Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool testTransform = false,
  }) => rendererCubit.delayedBakeRunner.schedule(() async {
    final newTransform = transformCubit.state;
    final viewport = rendererCubit.state.cameraViewport;

    if (testTransform &&
        newTransform.size == viewport.scale &&
        newTransform.position == viewport.toOffset()) {
      return;
    }

    await bake(
      blocState,
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      reset: reset,
    );
  });

  Future<void> reloadTool(
    DocumentBloc bloc, [
    DocumentLoaded? blocState,
  ]) async {
    final current = blocState ?? bloc.state;
    if (current is! DocumentLoaded) return;
    final tools = current.info.tools;
    final toolIndex = toolCubit.state.index ?? 0;
    final newTool = tools.elementAtOrNull(toolIndex);
    if (newTool?.isAction() ?? true) {
      await changeTool(bloc, index: 0, allowBake: false);
    } else if (newTool != toolCubit.state.handler.data) {
      await changeTool(bloc, index: toolIndex, allowBake: false);
    }
  }

  Future<void> reloadRuntime(
    DocumentBloc bloc, [
    DocumentLoaded? blocState,
  ]) async {
    final current = blocState ?? bloc.state;
    if (current is! DocumentLoaded) return;
    await reloadTool(bloc, current);
    await loadElements(current);
    await refresh(current, allowBake: false);
    await delayedBake(current);
  }
}
