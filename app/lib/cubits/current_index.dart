import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/xml.dart';
import 'package:butterfly/renderers/cursors/user.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart' as img;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:synchronized/synchronized.dart';
import 'package:xml/xml.dart';

import '../embed/embedding.dart';
import '../handlers/handler.dart';
import '../models/viewport.dart';
import '../selections/selection.dart';
import '../theme.dart';
import '../view_painter.dart';

part 'current_index.freezed.dart';

enum SaveState { saved, saving, unsaved, absoluteRead }

enum HideState { visible, keyboard, touch }

enum RendererState { visible, temporary, hidden }

enum TemporaryState { allowClick, removeAfterClick, removeAfterRelease }

@Freezed(equal: false)
sealed class CurrentIndex with _$CurrentIndex {
  const CurrentIndex._();

  const factory CurrentIndex(
    int? index,
    Handler handler,
    CameraViewport cameraViewport,
    SettingsCubit settingsCubit,
    TransformCubit transformCubit,
    NetworkingService networkingService, {
    @Default(false) bool isSaveDelayed,
    @Default(UtilitiesState()) UtilitiesState utilities,
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
    Offset? lastPosition,
    @Default([]) List<int> pointers,
    int? buttons,
    @Default(AssetLocation(path: '')) AssetLocation location,
    Embedding? embedding,
    @Default(SaveState.saved) SaveState saved,
    PreferredSizeWidget? toolbar,
    PreferredSizeWidget? temporaryToolbar,
    @Default({}) Map<String, RendererState> rendererStates,
    @Default({}) Map<String, RendererState>? temporaryRendererStates,
    @Default(ViewOption()) ViewOption viewOption,
    @Default(HideState.visible) HideState hideUi,
    @Default(true) bool areaNavigatorCreate,
    @Default(true) bool areaNavigatorExact,
    @Default(false) bool areaNavigatorAsk,
    @Default(false) bool navigatorEnabled,
    @Default(NavigatorPage.waypoints) NavigatorPage navigatorPage,
    @Default(false) bool isCreating,
    @Default('') String userName,
  }) = _CurrentIndex;

  bool get moveEnabled =>
      (settingsCubit.state.inputGestures && pointers.length > 1) &&
      settingsCubit.state.moveOnGesture;

  bool get absolute => saved == SaveState.absoluteRead;

  MouseCursor get currentCursor => temporaryCursor ?? cursor;

  Map<String, RendererState> get allRendererStates => {
    ...rendererStates,
    ...?temporaryRendererStates,
  };

  List<Renderer> getAllForegrounds([bool networking = true]) => [
    ...foregrounds,
    ...?temporaryForegrounds,
    ...toggleableForegrounds.values.expand((e) => e),
    if (networking) ...networkingForegrounds,
  ];
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit(
    SettingsCubit settingsCubit,
    TransformCubit transformCubit,
    CameraViewport viewport, {
    Embedding? embedding,
    NetworkingService? networkingService,
    bool absolute = false,
  }) : super(
         CurrentIndex(
           null,
           HandHandler(),
           viewport,
           settingsCubit,
           transformCubit,
           networkingService ?? NetworkingService(),
           embedding: embedding,
           saved: absolute ? SaveState.absoluteRead : SaveState.saved,
         ),
       ) {
    _transformSubscription = transformCubit.stream.listen(_onTransformChanged);
  }

  StreamSubscription? _transformSubscription;
  Timer? _transformDebounceTimer;
  static const _listEquality = ListEquality<Renderer<PadElement>>();

  void _onTransformChanged(CameraTransform transform) {
    // Debounce transform changes to avoid excessive updates during pan/zoom
    _transformDebounceTimer?.cancel();
    _transformDebounceTimer = Timer(const Duration(milliseconds: 16), () {
      _updateVisibleElements();
    });
  }

  void _updateVisibleElements() {
    if (isClosed) return;
    final unbaked = state.cameraViewport.unbakedElements;
    if (unbaked.isEmpty) return;

    final rect = getViewportRect();
    final currentVisible = state.cameraViewport.visibleElements;

    // Fast path: check if counts match before detailed comparison
    final visible = unbaked.where((e) => e.isVisible(rect)).toList();
    if (visible.length == currentVisible.length &&
        visible.length == unbaked.length) {
      return;
    }

    // Use cached equality instance for comparison
    if (_listEquality.equals(visible, currentVisible)) {
      return;
    }

    emit(
      state.copyWith(
        cameraViewport: state.cameraViewport.withUnbaked(unbaked, visible),
      ),
    );
  }

  void init(DocumentBloc bloc) {
    changeTool(bloc, index: state.index ?? 0);
    state.networkingService.setup(bloc);
  }

  Future<void> _updateOnVisible(
    CameraViewport newViewport,
    DocumentLoaded blocState,
  ) async {
    final newVisibleList = newViewport.visibleElements;
    if (newVisibleList.isEmpty) return;

    final currentVisible = state.cameraViewport.visibleElements.toSet();
    final newVisible = newVisibleList
        .where((e) => !currentVisible.contains(e))
        .toList();

    if (newVisible.isEmpty) return;

    talker.verbose('Updating visible elements: ${newVisible.length} new');
    final transform = state.transformCubit.state;
    final size = newViewport.toSize();
    await Future.wait(
      newVisible.map(
        (element) async =>
            await element.onVisible(this, blocState, transform, size),
      ),
    );
  }

  ThemeData getTheme(
    bool dark, [
    VisualDensity? density,
    ColorScheme? overridden,
  ]) =>
      getThemeData(state.settingsCubit.state.design, dark, density, overridden);

  Handler getHandler({bool disableTemporary = false}) {
    if (state.embedding?.editable == false) {
      return HandHandler();
    }
    if (disableTemporary) {
      return state.handler;
    } else {
      return state.temporaryHandler ?? state.handler;
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
    await resetInput(bloc);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (blocState.embedding?.editable == false) {
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
              state.transformCubit,
              document,
              blocState.assetService,
              blocState.page,
            ),
          ),
        );
      }
      if (selectState == SelectState.normal) {
        emit(
          state.copyWith(
            index: index,
            handler: handler,
            cursor: handler.cursor ?? MouseCursor.defer,
            foregrounds: foregrounds,
            toolbar: await handler.getToolbar(bloc),
            rendererStates: handler.rendererStates,
            temporaryForegrounds: null,
            temporaryHandler: null,
            temporaryToolbar: null,
            temporaryCursor: null,
            temporaryRendererStates: null,
            temporaryIndex: null,
          ),
        );
        if (allowBake) await bake(blocState);
      } else {
        if (isHandlerEnabled(index)) {
          disableHandler(bloc, index);
        } else {
          emit(
            state.copyWith(
              toggleableHandlers: {...state.toggleableHandlers, index: handler},
              toggleableForegrounds: {
                ...state.toggleableForegrounds,
                index: foregrounds,
              },
            ),
          );
        }
      }
    }
    return handler;
  }

  Timer? _networkingDebounceTimer;

  @override
  void onChange(Change<CurrentIndex> change) {
    super.onChange(change);
    final current = change.currentState;
    final next = change.nextState;

    // Debounce networking state updates to avoid flooding the network
    if (next.foregrounds != current.foregrounds ||
        next.temporaryForegrounds != current.temporaryForegrounds ||
        next.lastPosition != current.lastPosition ||
        next.userName != current.userName) {
      _networkingDebounceTimer?.cancel();
      _networkingDebounceTimer = Timer(const Duration(milliseconds: 50), () {
        if (!isClosed) _sendNetworkingState();
      });
    }

    final currentViewport = current.cameraViewport;
    final newViewport = next.cameraViewport;

    // Only notify handlers if viewport actually changed
    if (!identical(currentViewport, newViewport) &&
        currentViewport != newViewport) {
      next.handler.onViewportUpdated(currentViewport, newViewport);
      next.temporaryHandler?.onViewportUpdated(currentViewport, newViewport);
    }

    // Schedule image disposal if changed
    final oldImage = currentViewport.image;
    if (oldImage != null && oldImage != newViewport.image) {
      Future.delayed(const Duration(seconds: 2), () => oldImage.dispose());
    }
  }

  void _sendNetworkingState({
    List<Renderer<dynamic>>? foregrounds,
    Offset? cursor,
  }) {
    cursor ??= state.lastPosition ?? Offset.zero;
    state.networkingService.sendUser(
      NetworkingUser(
        cursor: state.transformCubit.state.localToGlobal(cursor).toPoint(),
        foreground: (foregrounds ?? state.getAllForegrounds(false))
            .map((e) => e.element)
            .whereType<PadElement>()
            .toList(),
        name: state.networkingService.userName,
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
    final users = (current ?? state.networkingService.users).entries.toList();

    final foregrounds = state.networkingForegrounds.toList();
    foregrounds.removeWhere((element) {
      final shouldRemove = !users.any(
        (user) =>
            user.value.foreground?.contains(element.element) ??
            false || user != element.element,
      );
      if (shouldRemove) {
        element.dispose();
      }
      return shouldRemove;
    });
    final elements = foregrounds.map((e) => e.element).toList();
    final added = users
        .expand((user) => user.value.foreground ?? [])
        .where((e) => !elements.contains(e))
        .map((e) => Renderer.fromInstance(e))
        .toList();
    added.addAll(
      users
          .where((element) => !elements.contains(element))
          .map((e) => UserCursor(e.value, e.key)),
    );
    await Future.wait(
      added.map(
        (e) async => await e.setup(
          state.transformCubit,
          blocState.data,
          blocState.assetService,
          blocState.page,
        ),
      ),
    );
    foregrounds.addAll(added);
    emit(state.copyWith(networkingForegrounds: foregrounds));
  }

  void updateLastPosition(Offset position) {
    // Only emit if position changed by more than 1 pixel to reduce state updates
    final lastPos = state.lastPosition;
    if (lastPos != null) {
      final dx = (position.dx - lastPos.dx).abs();
      final dy = (position.dy - lastPos.dy).abs();
      if (dx < 1 && dy < 1) return;
    }
    emit(state.copyWith(lastPosition: position));
  }

  Future<void> updateHandler(DocumentBloc bloc, Handler handler) async => emit(
    state.copyWith(
      handler: handler,
      cursor: handler.cursor ?? MouseCursor.defer,
      toolbar: await handler.getToolbar(bloc),
      rendererStates: handler.rendererStates,
    ),
  );

  Future<void> updateTool(DocumentBloc bloc, Tool tool) async {
    talker.verbose('Updating tool: ${tool.runtimeType}');
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.handler.dispose(bloc);
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
            state.transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    emit(
      state.copyWith(
        index: state.index,
        handler: handler,
        foregrounds: foregrounds,
        toolbar: await handler.getToolbar(bloc),
        rendererStates: handler.rendererStates,
        cursor: handler.cursor ?? MouseCursor.defer,
      ),
    );
  }

  Future<void> updateTemporaryTool(DocumentBloc bloc, Tool tool) async {
    talker.verbose('Updating temporary tool: ${tool.runtimeType}');
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.temporaryHandler?.dispose(bloc);
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
            state.transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    emit(
      state.copyWith(
        temporaryHandler: handler,
        temporaryForegrounds: foregrounds,
        temporaryToolbar: await handler.getToolbar(bloc),
        temporaryRendererStates: handler.rendererStates,
        temporaryCursor: handler.cursor,
      ),
    );
  }

  T? fetchHandler<T extends Handler>({bool disableTemporary = false}) {
    final handler = getHandler(disableTemporary: disableTemporary);
    if (handler is T) return handler;
    return null;
  }

  void _disposeForegrounds() {
    for (final r in state.foregrounds) {
      r.dispose();
    }
  }

  void _disposeTemporaryForegrounds() {
    for (final r in state.temporaryForegrounds ?? []) {
      r.dispose();
    }
  }

  void _disposeNetworkingForegrounds() {
    for (final r in state.networkingForegrounds) {
      r.dispose();
    }
  }

  void _disposeToggleableForegrounds() {
    for (final r in state.toggleableForegrounds.values.expand((e) => e)) {
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
    if (state.index == index) {
      handler = fetchHandler<Handler<Tool>>(disableTemporary: true);
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

  Future<void> refresh(
    DocumentLoaded blocState, {
    bool allowBake = true,
  }) async {
    talker.verbose('Refreshing CurrentIndexCubit');
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;
    const mapEq = MapEquality();
    if (!isClosed) {
      _disposeAllForegrounds();
      final temporaryForegrounds = state.temporaryHandler?.createForegrounds(
        this,
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
              state.transformCubit,
              document,
              assetService,
              page,
            ),
          ),
        );
      }
      final foregrounds = state.handler.createForegrounds(
        this,
        document,
        page,
        info,
        currentArea,
      );
      if (state.handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              state.transformCubit,
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
                state.transformCubit,
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
      final temporaryRendererStates = state.temporaryHandler?.rendererStates;
      final statesChanged = !mapEq.equals(state.rendererStates, rendererStates);
      final temporaryStatesChanged = !mapEq.equals(
        state.temporaryRendererStates,
        temporaryRendererStates,
      );
      final shouldBake = statesChanged || temporaryStatesChanged;
      emit(
        state.copyWith(
          temporaryForegrounds: temporaryForegrounds,
          toggleableForegrounds: toggleableForegrounds,
          foregrounds: foregrounds,
          cursor: state.handler.cursor ?? MouseCursor.defer,
          temporaryCursor: state.temporaryHandler?.cursor,
          rendererStates: statesChanged ? rendererStates : state.rendererStates,
          temporaryRendererStates: temporaryStatesChanged
              ? temporaryRendererStates
              : state.temporaryRendererStates,
        ),
      );
      if (allowBake) {
        if (shouldBake) {
          return bake(blocState, reset: true);
        } else if (!state.cameraViewport.baked) {
          return delayedBake(blocState);
        }
      }
    }
  }

  Future<void> refreshToolbar(DocumentBloc bloc) async {
    if (!isClosed) {
      final toolbar = await state.handler.getToolbar(bloc);
      final temporaryToolbar = await state.temporaryHandler?.getToolbar(bloc);
      emit(
        state.copyWith(toolbar: toolbar, temporaryToolbar: temporaryToolbar),
      );
    }
  }

  /// Lightweight refresh that only updates foregrounds without rebaking.
  /// Use this when handler internal state changes but document hasn't changed.
  Future<void> refreshForegrounds(DocumentLoaded blocState) async {
    if (isClosed) return;
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;

    _disposeForegrounds();
    _disposeTemporaryForegrounds();

    final temporaryForegrounds = state.temporaryHandler?.createForegrounds(
      this,
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
          (e) async =>
              await e.setup(state.transformCubit, document, assetService, page),
        ),
      );
    }

    final foregrounds = state.handler.createForegrounds(
      this,
      document,
      page,
      info,
      currentArea,
    );
    if (foregrounds.isNotEmpty && state.handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async =>
              await e.setup(state.transformCubit, document, assetService, page),
        ),
      );
    }

    // Check if rendererStates changed and need a bake
    const mapEq = MapEquality<String, RendererState>();
    final rendererStates = state.handler.rendererStates;
    final temporaryRendererStates = state.temporaryHandler?.rendererStates;
    final statesChanged = !mapEq.equals(state.rendererStates, rendererStates);
    final temporaryStatesChanged = !mapEq.equals(
      state.temporaryRendererStates,
      temporaryRendererStates,
    );

    emit(
      state.copyWith(
        foregrounds: foregrounds,
        temporaryForegrounds: temporaryForegrounds,
        cursor: state.handler.cursor ?? MouseCursor.defer,
        temporaryCursor: state.temporaryHandler?.cursor,
        rendererStates: statesChanged ? rendererStates : state.rendererStates,
        temporaryRendererStates: temporaryStatesChanged
            ? temporaryRendererStates
            : state.temporaryRendererStates,
      ),
    );

    // If renderer states changed, we need to bake to hide/show original elements
    if (statesChanged || temporaryStatesChanged) {
      await bake(blocState, reset: true);
    }
  }

  /// Ultra-lightweight update for cursor changes only.
  /// Use this when only the cursor appearance needs to change.
  void updateCursor(MouseCursor cursor) {
    if (state.cursor != cursor) {
      emit(state.copyWith(cursor: cursor));
    }
  }

  Tool? getTool(DocumentInfo info) {
    var index = state.index;
    if (index == null) {
      return null;
    }
    if (info.tools.isEmpty || index < 0 || index >= info.tools.length) {
      return null;
    }
    return info.tools[index];
  }

  T? fetchTool<T extends Tool>(DocumentInfo info) {
    final tool = getTool(info);
    if (tool is T) return tool;
    return null;
  }

  Future<void> toggleHandler(DocumentBloc bloc, int index) async {
    if (state.toggleableHandlers.containsKey(index)) {
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
            state.transformCubit,
            document,
            blocState.assetService,
            page,
          ),
        ),
      );
    }
    emit(
      state.copyWith(
        toggleableHandlers: Map.from(state.toggleableHandlers)
          ..[index] = handler,
        toggleableForegrounds: Map.from(state.toggleableForegrounds)
          ..[index] = foregrounds,
      ),
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
    emit(
      state.copyWith(
        toggleableHandlers: Map.from(state.toggleableHandlers)..remove(index),
        toggleableForegrounds: foregrounds,
      ),
    );
    return true;
  }

  bool isHandlerEnabled(int index) =>
      state.toggleableHandlers.containsKey(index);

  void reset(DocumentBloc bloc) {
    for (final r in renderers) {
      r.dispose();
    }
    state.handler.dispose(bloc);
    state.temporaryHandler?.dispose(bloc);
    for (var e in state.toggleableHandlers.values) {
      e.dispose(bloc);
    }
    _disposeForegrounds();
    _disposeTemporaryForegrounds();
    _disposeNetworkingForegrounds();
    _disposeToggleableForegrounds();
    emit(
      state.copyWith(
        index: null,
        handler: HandHandler(),
        cursor: MouseCursor.defer,
        foregrounds: const <Renderer>[],
        temporaryHandler: null,
        temporaryForegrounds: null,
        temporaryCursor: null,
        temporaryRendererStates: null,
        toolbar: null,
        temporaryToolbar: null,
        temporaryIndex: null,
        rendererStates: const <String, RendererState>{},
        toggleableHandlers: const <int, Handler<Tool>>{},
        toggleableForegrounds: const <int, List<Renderer>>{},
        networkingForegrounds: const <Renderer>[],
        cameraViewport: CameraViewport.unbaked(),
      ),
    );
  }

  void changeIndex(int i) {
    emit(state.copyWith(index: i));
  }

  void addPointer(int pointer) {
    final pointers = state.pointers;
    if (pointers.contains(pointer)) return;
    emit(state.copyWith(pointers: [...pointers, pointer]));
  }

  void removePointer(int pointer) {
    final pointers = state.pointers;
    if (!pointers.contains(pointer)) return;
    emit(
      state.copyWith(pointers: pointers.where((p) => p != pointer).toList()),
    );
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
    final temporaryHandler = state.temporaryHandler;
    if (!force && index == state.temporaryIndex && temporaryHandler != null) {
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
    state.temporaryHandler?.dispose(bloc);
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
              state.transformCubit,
              document,
              blocState.assetService,
              page,
            ),
          ),
        );
      }
      emit(
        state.copyWith(
          temporaryHandler: handler,
          temporaryForegrounds: temporaryForegrounds,
          temporaryToolbar: await handler.getToolbar(bloc),
          temporaryCursor: handler.cursor,
          temporaryRendererStates: handler.rendererStates,
          temporaryState: temporaryState,
          temporaryIndex: index,
        ),
      );
      await bake(blocState);
    } else if (selectState == SelectState.toggle && index != null) {
      await toggleHandler(bloc, index);
    }
    return handler;
  }

  void resetReleaseHandler(DocumentBloc bloc) {
    if (state.temporaryState == TemporaryState.removeAfterRelease) {
      resetTemporaryHandler(bloc, true);
    }
  }

  void resetDownHandler(DocumentBloc bloc) {
    resetTemporaryHandler(bloc);
  }

  void resetTemporaryHandler(DocumentBloc bloc, [bool force = false]) {
    if (state.temporaryHandler == null) {
      return;
    }
    if (!force && state.temporaryState != TemporaryState.removeAfterClick) {
      if (state.temporaryState == TemporaryState.allowClick) {
        emit(state.copyWith(temporaryState: TemporaryState.removeAfterClick));
      }
      return;
    }
    state.temporaryHandler?.dispose(bloc);
    _disposeTemporaryForegrounds();
    emit(
      state.copyWith(
        temporaryHandler: null,
        temporaryIndex: null,
        temporaryForegrounds: null,
        temporaryToolbar: null,
        temporaryCursor: null,
        temporaryRendererStates: null,
      ),
    );
  }

  List<Renderer<PadElement>> get renderers =>
      List.from(state.cameraViewport.bakedElements)
        ..addAll(state.cameraViewport.unbakedElements);

  Renderer? getRenderer(PadElement element) =>
      renderers.firstWhereOrNull((renderer) => renderer.element == element);

  Rect getViewportRect({Size? viewportSize}) {
    var size = viewportSize ?? state.cameraViewport.toSize();

    final transform = state.transformCubit.state;
    final resolution = state.settingsCubit.state.renderResolution;

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
    rect = resolution.getRect(rect);
    return rect;
  }

  final _bakeLock = Lock();

  Future<void> bake(
    DocumentLoaded blocState, {
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool resetAllLayers = false,
  }) => _bakeLock.synchronized(() async {
    if (isClosed) return;
    var cameraViewport = state.cameraViewport;
    final resolution = state.settingsCubit.state.renderResolution;
    var size = viewportSize ?? cameraViewport.toSize();
    final ratio = pixelRatio ?? cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    if (viewportSize == null) {
      size /= resolution.multiplier;
    }
    var transform = state.transformCubit.state;
    var renderers = List<Renderer<PadElement>>.from(this.renderers);
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
    var allRendererStates = state.allRendererStates;
    final rendererStatesChanged = !mapEquals(
      allRendererStates,
      cameraViewport.rendererStates,
    );
    if (!rendererStatesChanged) {
      allRendererStates = cameraViewport.rendererStates;
    }
    final invisibleLayers = blocState.invisibleLayers;
    final viewChanged =
        cameraViewport.width != size.width.ceil() ||
        cameraViewport.height != size.height.ceil() ||
        cameraViewport.x != renderTransform.position.dx ||
        cameraViewport.y != renderTransform.position.dy ||
        cameraViewport.scale != transform.size ||
        rendererStatesChanged ||
        !setEquals(cameraViewport.invisibleLayers, invisibleLayers);
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

    // call onVisible for any newly visible elements (skip if empty)
    final newlyVisible = visibleElements
        .where((element) => !oldVisibleSet.contains(element))
        .toList();
    if (newlyVisible.isNotEmpty) {
      await Future.wait(
        newlyVisible.map(
          (element) async =>
              await element.onVisible(this, blocState, renderTransform, size),
        ),
      );
    }

    final newlyHidden = oldVisible
        .where((element) => !visibleElementsSet.contains(element))
        .toList();
    if (newlyHidden.isNotEmpty) {
      await Future.wait(
        newlyHidden.map(
          (element) async =>
              await element.onHidden(this, blocState, renderTransform, size),
        ),
      );
    }

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
      final belowLayers = [], aboveLayers = [];
      bool above = false;
      for (final layer in page.layers) {
        if (layer.id == currentLayer) {
          above = true;
          continue;
        }
        if (above) {
          aboveLayers.add(layer.id);
        } else {
          belowLayers.add(layer.id);
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
              .where((e) => belowLayers.contains(e.layer))
              .toList(),
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
              .where((e) => aboveLayers.contains(e.layer))
              .toList(),
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
        (reset ? this.renderers : state.cameraViewport.unbakedElements)
            .where(
              (element) =>
                  !bakedElementsSet.contains(element.element) &&
                  !unbakedElementsSet.contains(element.element),
            )
            .toList();
    for (final u in newlyUnbaked) {
      if (!visibleElementsSet.contains(u)) visibleElements.add(u);
    }

    if (isClosed) return;

    emit(
      state.copyWith(
        cameraViewport: cameraViewport.bake(
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
          belowLayerImage: belowLayerImage,
          aboveLayerImage: aboveLayerImage,
          rendererStates: allRendererStates,
          invisibleLayers: invisibleLayers,
        ),
      ),
    );
  });

  Future<ui.Image?> renderImage(
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options, {
    CameraViewport? cameraViewport,
    Set<String>? invisibleLayers,
  }) async {
    final realWidth = options.width.ceil();
    final realHeight = options.height.ceil();
    final realZoom = options.scale;
    if (realWidth <= 0 || realHeight <= 0) {
      return null;
    }
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = ViewPainter(
      document,
      page,
      info,
      renderBackground: options.renderBackground,
      invisibleLayers: invisibleLayers,
      cameraViewport:
          cameraViewport ??
          state.cameraViewport.unbake(unbakedElements: renderers),
      transform: CameraTransform(
        options.quality,
        Offset(options.x, options.y),
        realZoom,
      ),
    );
    painter.paint(canvas, Size(realWidth.toDouble(), realHeight.toDouble()));
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
  }) async {
    final image = await renderImage(
      document,
      page,
      info,
      options,
      cameraViewport: cameraViewport,
      invisibleLayers: invisibleLayers,
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
      for (final e in state.cameraViewport.backgrounds) {
        e.buildSvg(xml, document, page, rect);
      }
    }
    for (var e in renderers) {
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
    final newViewport = state.cameraViewport.unbake(
      unbakedElements: unbakedElements,
      visibleElements: unbakedElements
          ?.where((e) => e.isVisible(getViewportRect()))
          .toList(),
      backgrounds: backgrounds,
    );
    await _updateOnVisible(newViewport, blocState);
    emit(state.copyWith(cameraViewport: newViewport));
  }

  Future<void> loadElements(
    DocumentState docState, {
    bool reset = false,
  }) async {
    if (docState is! DocumentLoaded) return;
    final document = docState.data;
    final assetService = docState.assetService;
    final page = docState.page;
    var existing = renderers;
    if (reset) {
      for (var e in existing) {
        e.dispose();
      }
      existing = [];
    }
    final elements = page.layers
        .where((e) => !docState.invisibleLayers.contains(e.id))
        .expand((l) => l.content.map((e) => (e, l.id)))
        .toList();
    final reusable = existing
        .where(
          (e) => elements.any((el) => el.$1 == e.element && el.$2 == e.layer),
        )
        .toList();
    final newRenderers = elements
        .where(
          (e) => !reusable.any((r) => r.element == e.$1 && r.layer == e.$2),
        )
        .map((e) => Renderer.fromInstance(e.$1, e.$2))
        .toList();
    await Future.wait(
      newRenderers.map(
        (e) async =>
            await e.setup(state.transformCubit, document, assetService, page),
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
            await e.setup(state.transformCubit, document, assetService, page),
      ),
    );
    final newViewport = state.cameraViewport.unbake(
      unbakedElements: combined,
      visibleElements: [],
      backgrounds: backgrounds,
    );
    emit(
      state.copyWith(
        location: state.embedding?.location ?? state.location,
        cameraViewport: newViewport,
      ),
    );
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
    final newViewport = state.cameraViewport.withUnbaked(
      [...state.cameraViewport.unbakedElements, ...unbakedElements],
      [...state.cameraViewport.visibleElements, ...visibleElements],
    );
    await _updateOnVisible(newViewport, blocState);
    emit(state.copyWith(cameraViewport: newViewport));
  }

  void setSaveState({
    AssetLocation? location,
    SaveState? saved,
    bool absolute = false,
    bool? isCreating,
    bool keepRead = false,
  }) => emit(
    state.copyWith(
      location: location ?? state.location,
      isCreating: isCreating ?? state.isCreating,
      saved: (absolute || (keepRead && state.absolute))
          ? SaveState.absoluteRead
          : saved ?? state.saved,
    ),
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
        cameraViewport: currentOpened
            ? null
            : await CameraViewport.build(
                docState.transformCubit,
                document,
                docState.assetService,
                page,
              ),
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
        width: imgImage.width.toDouble(),
        height: imgImage.height.toDouble(),
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
    final index = info.tools.indexOf(state.handler.data);
    if (index < 0) {
      changeTool(bloc, index: state.index ?? 0);
    }
    if (index == state.index) {
      return;
    }
    changeIndex(index);
    final selection = state.selection;
    if (selection?.selected.contains(state.handler.data) ?? false) {
      resetSelection();
    }
  }

  void insertSelection(dynamic selected, [bool toggle = true]) {
    final selection = state.selection;
    if (selection == null) {
      emit(state.copyWith(selection: Selection.from(selected)));
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
    emit(state.copyWith(selection: next));
  }

  void changeSelection(dynamic selected, [bool toggle = true]) {
    Selection? selection;
    if (selected is Selection?) {
      selection = selected;
    } else if (!toggle ||
        !(state.selection?.selected.contains(selected) ?? false)) {
      selection = Selection.from(selected);
    }
    emit(state.copyWith(selection: selection));
  }

  void removeSelection(List selected) {
    Selection? selection = state.selection;
    if (selection == null) {
      return;
    }
    for (final s in selected) {
      selection = selection?.remove(s);
    }
    emit(state.copyWith(selection: selection));
  }

  void resetSelection({bool force = false}) {
    if (force || !state.pinned) {
      emit(state.copyWith(selection: null));
    }
  }

  void setButtons(int buttons) {
    emit(state.copyWith(buttons: buttons));
  }

  void removeButtons() {
    emit(state.copyWith(buttons: null));
  }

  Future<void> resetInput(DocumentBloc bloc) async {
    await state.handler.resetInput(bloc);
    emit(state.copyWith(buttons: null, pointers: []));
  }

  void changeTemporaryHandlerMove() {
    emit(
      state.copyWith(
        temporaryHandler: HandHandler(),
        temporaryIndex: null,
        temporaryCursor: null,
        temporaryRendererStates: null,
        temporaryForegrounds: null,
        temporaryToolbar: null,
      ),
    );
  }

  Future<void> updateUtilities({
    UtilitiesState? utilities,
    ViewOption? view,
  }) async {
    var state = this.state;
    state = state.copyWith(
      utilities: utilities ?? state.utilities,
      viewOption: view ?? state.viewOption,
    );
    emit(state);
    if (utilities != null) {
      return state.settingsCubit.changeUtilities(utilities);
    }
  }

  void togglePin() => emit(state.copyWith(pinned: !state.pinned));

  void move(Offset delta, [bool force = false]) {
    final utilitiesState = state.utilities;
    if (utilitiesState.lockHorizontal && !force) {
      delta = Offset(0, delta.dy);
    }
    if (utilitiesState.lockVertical && !force) {
      delta = Offset(delta.dx, 0);
    }
    if (delta.dx == 0 && delta.dy == 0) {
      return;
    }
    state.transformCubit.move(delta);
  }

  void zoom(double delta, [Offset cursor = Offset.zero, bool force = false]) {
    final utilitiesState = state.utilities;
    if (utilitiesState.lockZoom && !force) {
      delta = 1;
    }
    if (delta == 1) {
      return;
    }
    state.transformCubit.zoom(delta, cursor);
  }

  void slide(
    Offset positionVelocity,
    double sizeVelocity, [
    bool force = false,
  ]) {
    if (!state.settingsCubit.state.hasFlag('smoothNavigation')) return;
    final utilitiesState = state.utilities;
    if (utilitiesState.lockHorizontal && !force) {
      positionVelocity = Offset(0, positionVelocity.dy);
    }
    if (utilitiesState.lockVertical && !force) {
      positionVelocity = Offset(positionVelocity.dx, 0);
    }
    if (utilitiesState.lockZoom && !force) {
      sizeVelocity = 0;
    }
    if (positionVelocity.dx == 0 &&
        positionVelocity.dy == 0 &&
        sizeVelocity == 0) {
      return;
    }
    state.transformCubit.slide(positionVelocity, sizeVelocity);
  }

  void toggleKeyboardHideUI() => emit(
    state.copyWith(
      hideUi: state.hideUi == HideState.visible
          ? HideState.keyboard
          : HideState.visible,
    ),
  );

  void enterTouchHideUI() => emit(state.copyWith(hideUi: HideState.touch));

  void exitHideUI() => emit(state.copyWith(hideUi: HideState.visible));

  ExternalStorage? getRemoteStorage() => state.location.remote.isEmpty
      ? null
      : state.settingsCubit.state.getRemote(state.location.remote);

  final _savingLock = Lock();

  Future<AssetLocation> save(
    DocumentBloc bloc, {
    AssetLocation? location,
    bool force = false,
    bool isAutosave = false,
  }) async {
    final absolute = state.absolute;
    if (!force &&
        (state.saved == SaveState.saved ||
            state.saved == SaveState.absoluteRead)) {
      return state.location;
    }
    if (state.networkingService.isClient) {
      return AssetLocation.empty;
    }
    if (state.isSaveDelayed && isAutosave) {
      return state.location;
    }
    final storage = getRemoteStorage();
    final fileSystem = bloc.state.fileSystem.buildDocumentSystem(storage);
    final isDelayed = state.settingsCubit.state.delayedAutosave;
    if (isDelayed && isAutosave) {
      final seconds = max(0, state.settingsCubit.state.autosaveDelaySeconds);
      emit(state.copyWith(isSaveDelayed: true));
      await Future.delayed(Duration(seconds: seconds));
      if (!state.isSaveDelayed) {
        return state.location;
      }
    }
    return _savingLock.synchronized(() async {
      var current = location ?? state.location;
      emit(
        state.copyWith(
          saved: SaveState.saving,
          location: current,
          isSaveDelayed: false,
        ),
      );
      final blocState = bloc.state;
      final currentData = await blocState.saveData();
      if (currentData == null || blocState.embedding != null) {
        emit(state.copyWith(saved: SaveState.saved));
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
              ? state.location.path
              : state.location.parent,
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
      state.settingsCubit.addRecentHistory(current);
      emit(
        state.copyWith(
          saved: state.saved == SaveState.saving
              ? SaveState.saved
              : state.saved,
          location: current,
        ),
      );
      return current;
    });
  }

  @override
  Future<void> close() async {
    _transformSubscription?.cancel();
    _transformDebounceTimer?.cancel();
    _networkingDebounceTimer?.cancel();
    if (!state.networkingService.isClosed) {
      await state.networkingService.close();
    }
    return super.close();
  }

  Rect getPageRect({Set<String>? invisibleLayers}) {
    Rect? rect;
    for (final renderer in renderers) {
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
    List<Renderer<PadElement>> addedElements = const [],
    List<Renderer<PadElement>>? replacedElements,
    List<Renderer<Background>>? backgrounds,
    bool reset = false,
    bool unbake = false,
    bool Function()? shouldRefresh,
    bool updateIndex = false,
  }) async {
    for (var renderer in {
      ...?backgrounds,
      ...?replacedElements,
      ...addedElements,
    }) {
      await renderer.setup(
        state.transformCubit,
        current.data,
        current.assetService,
        current.page,
      );
    }
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;

    if (replacedElements != null || unbake) {
      await current.currentIndexCubit.unbake(
        blocState,
        unbakedElements: replacedElements == null
            ? null
            : [...replacedElements, ...addedElements],
        backgrounds: backgrounds,
      );
    } else if (backgrounds != null) {
      await this.unbake(blocState, backgrounds: backgrounds);
    } else {
      await addUnbaked(blocState, addedElements);
    }

    setSaveState(saved: SaveState.unsaved);
    if (current.embedding != null) {
      return;
    }
    if (reset) {
      reload(bloc, current);
    } else if (shouldRefresh?.call() == true) {
      await refresh(current);
    }
    if (updateIndex) {
      this.updateIndex(bloc);
    }
    if (current.hasAutosave()) {
      save(bloc, isAutosave: true);
    }
  }

  void setAreaNavigatorCreate(bool value) =>
      emit(state.copyWith(areaNavigatorCreate: value));

  void setAreaNavigatorExact(bool value) =>
      emit(state.copyWith(areaNavigatorExact: value));

  void setAreaNavigatorAsk(bool value) =>
      emit(state.copyWith(areaNavigatorAsk: value));

  Future<void> updateTogglingTools(DocumentBloc bloc, List<Tool> tools) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final newHandlers = Map<int, Handler<Tool>>.from(state.toggleableHandlers);
    final newForegrounds = Map<int, List<Renderer>>.from(
      state.toggleableForegrounds,
    );
    final currentTools = blocState.info.tools;
    for (final tool in tools) {
      final index = currentTools.indexWhere((element) => element.id == tool.id);
      if (index == -1) continue;
      final old = state.toggleableHandlers[index];
      if (old == null) continue;
      if (old.data == tool) continue;
      old.dispose(bloc);
      for (final r in state.toggleableForegrounds[index] ?? []) {
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
              state.transformCubit,
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
    emit(
      state.copyWith(
        toggleableHandlers: newHandlers,
        toggleableForegrounds: newForegrounds,
      ),
    );
  }

  void setNavigatorEnabled(bool value) {
    emit(state.copyWith(navigatorEnabled: value));
  }

  void setNavigatorPage(NavigatorPage page) {
    emit(state.copyWith(navigatorPage: page));
  }

  var _bakeDelayed = false;

  Future<void> delayedBake(
    DocumentLoaded blocState, {
    ui.Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool testTransform = false,
  }) async {
    if (_bakeDelayed) return;
    final transformCubit = state.transformCubit;
    final oldTransform = transformCubit.state;
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      final newTransform = transformCubit.state;
      final viewport = state.cameraViewport;
      if (testTransform &&
          (oldTransform.size != newTransform.size ||
              oldTransform.position != newTransform.position ||
              (oldTransform.size == viewport.scale &&
                  oldTransform.position == viewport.toOffset()))) {
        return;
      }
    } finally {
      _bakeDelayed = false;
    }
    await bake(
      blocState,
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      reset: reset,
    );
  }

  void setUserName(String name) {
    emit(state.copyWith(userName: name));
  }

  Future<void> reloadTool(
    DocumentBloc bloc, [
    DocumentLoaded? blocState,
  ]) async {
    final current = blocState ?? bloc.state;
    if (current is! DocumentLoaded) return;
    // If tool is not the same, change tool
    final tools = current.info.tools;
    final toolIndex = state.index ?? 0;
    final newTool = tools.elementAtOrNull(toolIndex);
    if (newTool?.isAction() ?? true) {
      await changeTool(bloc, index: 0, allowBake: false);
    } else if (newTool != state.handler.data) {
      await changeTool(bloc, index: toolIndex, allowBake: false);
    }
  }

  Future<void> reload(DocumentBloc bloc, [DocumentLoaded? blocState]) async {
    final current = blocState ?? bloc.state;
    if (current is! DocumentLoaded) return;
    await reloadTool(bloc, current);
    await loadElements(current);
    await refresh(current, allowBake: false);
    await delayedBake(current);
  }
}

Future<NoteFile> _toFile((NoteData, bool) args) async {
  return args.$1.toFile(isTextBased: args.$2);
}
