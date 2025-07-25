import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/xml.dart';
import 'package:butterfly/renderers/cursors/user.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:networker/networker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
    @Default(UtilitiesState()) UtilitiesState utilities,
    Handler<Tool>? temporaryHandler,
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
    ...(temporaryForegrounds ?? foregrounds),
    ...toggleableForegrounds.values.expand((e) => e),
    if (networking) ...networkingForegrounds,
  ];
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit(
    SettingsCubit settingsCubit,
    TransformCubit transformCubit,
    CameraViewport viewport, [
    Embedding? embedding,
    NetworkingService? networkingService,
  ]) : super(
         CurrentIndex(
           null,
           HandHandler(),
           viewport,
           settingsCubit,
           transformCubit,
           networkingService ?? NetworkingService(),
           embedding: embedding,
         ),
       );

  void init(DocumentBloc bloc) {
    changeTool(bloc, index: state.index ?? 0);
    state.networkingService.setup(bloc);
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
  }) async {
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
      selectState = handler.onSelected(context);
    }
    if (selectState != SelectState.none) {
      state.handler.dispose(bloc);
      state.temporaryHandler?.dispose(bloc);
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
            (e) async =>
                await e.setup(document, blocState.assetService, blocState.page),
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
            toolbar: handler.getToolbar(bloc),
            rendererStates: handler.rendererStates,
            temporaryForegrounds: null,
            temporaryHandler: null,
            temporaryToolbar: null,
            temporaryCursor: null,
            temporaryRendererStates: null,
          ),
        );
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

  @override
  void onChange(Change<CurrentIndex> change) {
    super.onChange(change);
    if (change.currentState.cameraViewport.image !=
        change.nextState.cameraViewport.image) {
      change.currentState.cameraViewport.image?.dispose();
    }
    if (change.nextState.foregrounds != change.currentState.foregrounds ||
        change.nextState.temporaryForegrounds !=
            change.currentState.temporaryForegrounds ||
        change.nextState.lastPosition != change.currentState.lastPosition ||
        change.nextState.userName != change.currentState.userName) {
      _sendNetworkingState();
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
          blocState.data,
          blocState.assetService,
          blocState.page,
        ),
      ),
    );
    foregrounds.addAll(added);
    emit(state.copyWith(networkingForegrounds: foregrounds));
  }

  void updateLastPosition(Offset position) =>
      emit(state.copyWith(lastPosition: position));

  void updateHandler(DocumentBloc bloc, Handler handler) => emit(
    state.copyWith(
      handler: handler,
      cursor: handler.cursor ?? MouseCursor.defer,
      toolbar: handler.getToolbar(bloc),
      rendererStates: handler.rendererStates,
    ),
  );

  Future<void> updateTool(DocumentBloc bloc, Tool tool) async {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.handler.dispose(bloc);
    final handler = Handler.fromTool(tool);
    state.handler.dispose(bloc);
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
        toolbar: handler.getToolbar(bloc),
        rendererStates: handler.rendererStates,
        cursor: handler.cursor ?? MouseCursor.defer,
      ),
    );
  }

  Future<void> updateTemporaryTool(DocumentBloc bloc, Tool tool) async {
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
        temporaryToolbar: handler.getToolbar(bloc),
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

  Future<void> refresh(DocumentLoaded blocState) async {
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
            (e) async => await e.setup(document, assetService, page),
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
            (e) async => await e.setup(document, assetService, page),
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
              (e) async => await e.setup(document, assetService, page),
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
      if (shouldBake) {
        return bake(blocState, reset: true);
      }
    }
  }

  Future<void> refreshToolbar(DocumentBloc bloc) async {
    if (!isClosed) {
      final toolbar = state.handler.getToolbar(bloc);
      final temporaryToolbar = state.temporaryHandler?.getToolbar(bloc);
      emit(
        state.copyWith(toolbar: toolbar, temporaryToolbar: temporaryToolbar),
      );
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

  void toggleHandler(DocumentBloc bloc, int index) {
    if (state.toggleableHandlers.containsKey(index)) {
      disableHandler(bloc, index);
    } else {
      enableHandler(bloc, index);
    }
  }

  Handler? enableHandler(DocumentBloc bloc, int index) {
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
      Future.wait(
        foregrounds.map(
          (e) async => await e.setup(document, blocState.assetService, page),
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
    emit(
      state.copyWith(
        index: null,
        handler: HandHandler(),
        cursor: MouseCursor.defer,
        foregrounds: [],
        temporaryHandler: null,
        temporaryForegrounds: null,
        temporaryCursor: null,
        temporaryRendererStates: null,
        cameraViewport: CameraViewport.unbaked(),
      ),
    );
  }

  void changeIndex(int i) {
    emit(state.copyWith(index: i));
  }

  void addPointer(int pointer) {
    emit(
      state.copyWith(pointers: (state.pointers.toSet()..add(pointer)).toList()),
    );
  }

  void removePointer(int pointer) {
    emit(state.copyWith(pointers: state.pointers.toList()..remove(pointer)));
  }

  Future<Handler?> changeTemporaryHandlerIndex(
    BuildContext context,
    int index, {
    DocumentBloc? bloc,
    TemporaryState temporaryState = TemporaryState.allowClick,
  }) async {
    bloc ??= context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (index < 0 || index >= blocState.info.tools.length) {
      return null;
    }
    final tool = blocState.info.tools[index];
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
    final selectState = handler.onSelected(context);

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
            (e) async => await e.setup(document, blocState.assetService, page),
          ),
        );
      }
      emit(
        state.copyWith(
          temporaryHandler: handler,
          temporaryForegrounds: temporaryForegrounds,
          temporaryToolbar: handler.getToolbar(bloc),
          temporaryCursor: handler.cursor,
          temporaryRendererStates: handler.rendererStates,
          temporaryState: temporaryState,
        ),
      );
    } else if (selectState == SelectState.toggle && index != null) {
      toggleHandler(bloc, index);
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

  bool _isBaking = false;
  Function? _queuedBake;
  Future<void> bake(
    DocumentLoaded blocState, {
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool resetAllLayers = false,
  }) async {
    if (_isBaking) {
      _queuedBake = () {
        bake(
          blocState,
          viewportSize: viewportSize,
          pixelRatio: pixelRatio,
          reset: reset,
          resetAllLayers: resetAllLayers,
        );
      };
      return;
    }
    _queuedBake = null;
    var cameraViewport = state.cameraViewport;
    final resolution = state.settingsCubit.state.renderResolution;
    var size = viewportSize ?? cameraViewport.toSize();
    final ratio = pixelRatio ?? cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    if (viewportSize != null) {
      size *= resolution.multiplier;
    }
    var transform = state.transformCubit.state;
    final realWidth = size.width / transform.size;
    final realHeight = size.height / transform.size;
    var rect = Rect.fromLTWH(
      transform.position.dx,
      transform.position.dy,
      realWidth / resolution.multiplier,
      realHeight / resolution.multiplier,
    );
    var renderers = List<Renderer<PadElement>>.from(
      cameraViewport.unbakedElements,
    );
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final friction = transform.friction;
    if (friction != null) {
      final topLeft = Offset(
        min(transform.position.dx, friction.beginPosition.dx),
        min(transform.position.dy, friction.beginPosition.dy),
      );
      final bottomRight = Offset(
        max(transform.position.dx, friction.beginPosition.dx),
        max(transform.position.dy, friction.beginPosition.dy),
      ).translate(size.width, size.height);
      transform = transform.withPosition(topLeft);
      rect = Rect.fromPoints(topLeft, bottomRight);
      size =
          Size(bottomRight.dx - topLeft.dx, bottomRight.dy - topLeft.dy) *
          transform.size;
    }
    final renderTransform = transform.improve(resolution, rect.size);
    rect = resolution.getRect(rect);
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final imageWidth = (size.width * ratio).ceil();
    final imageHeight = (size.height * ratio).ceil();
    final viewChanged =
        cameraViewport.width != size.width.ceil() ||
        cameraViewport.height != size.height.ceil() ||
        cameraViewport.x != renderTransform.position.dx ||
        cameraViewport.y != renderTransform.position.dy ||
        cameraViewport.scale != transform.size;
    reset = reset || viewChanged;
    resetAllLayers = resetAllLayers || viewChanged;
    if (renderers.isEmpty && !reset) return;
    final currentLayer = blocState.currentLayer;
    List<Renderer<PadElement>> visibleElements;
    if (reset) {
      renderers = List<Renderer<PadElement>>.from(this.renderers);
      visibleElements = renderers
          .where((renderer) => renderer.expandedRect?.overlaps(rect) ?? true)
          .toList();
    } else {
      visibleElements = List.from(cameraViewport.visibleElements)
        ..addAll(renderers);
    }
    canvas.scale(ratio);

    _isBaking = true;

    // Wait one frame
    await Future.delayed(const Duration(milliseconds: 1));

    ViewPainter(
      document,
      page,
      info,
      transform: renderTransform,
      states: state.allRendererStates,
      cameraViewport: reset
          ? cameraViewport.unbake(
              unbakedElements: visibleElements
                  .where((e) => currentLayer == e.layer)
                  .toList(),
              visibleElements: visibleElements,
            )
          : cameraViewport,
      renderBackground: false,
      renderBaked: !reset,
      renderBakedLayers: false,
    ).paint(canvas, size);

    var picture = recorder.endRecording();

    final newImage = await picture.toImage(imageWidth, imageHeight);

    var currentRenderers = state.cameraViewport.unbakedElements;
    if (reset) {
      currentRenderers = this.renderers;
    } else {
      renderers.insertAll(0, state.cameraViewport.bakedElements);
    }
    currentRenderers = currentRenderers
        .whereNot((element) => renderers.contains(element))
        .toList();
    visibleElements.addAll(currentRenderers);

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
        states: state.allRendererStates,
        cameraViewport: cameraViewport.unbake(
          unbakedElements: visibleElements
              .where((e) => belowLayers.contains(e.layer))
              .toList(),
        ),
        renderBackground: false,
        renderBaked: false,
      ).paint(belowLayerCanvas, size);
      ViewPainter(
        document,
        page,
        info,
        transform: renderTransform,
        states: state.allRendererStates,
        cameraViewport: cameraViewport.unbake(
          unbakedElements: visibleElements
              .where((e) => aboveLayers.contains(e.layer))
              .toList(),
        ),
        renderBackground: false,
        renderBaked: false,
      ).paint(aboveLayerCanvas, size);

      final result = await Future.wait([
        belowLayerRecorder.endRecording().toImage(imageWidth, imageHeight),
        aboveLayerRecorder.endRecording().toImage(imageWidth, imageHeight),
      ]);
      belowLayerImage = result[0];
      aboveLayerImage = result[1];
    }

    emit(
      state.copyWith(
        cameraViewport: cameraViewport.bake(
          height: size.height.ceil(),
          width: size.width.ceil(),
          pixelRatio: ratio,
          resolution: resolution,
          scale: transform.size,
          x: renderTransform.position.dx,
          y: renderTransform.position.dy,
          image: newImage,
          bakedElements: renderers,
          unbakedElements: currentRenderers,
          visibleElements: visibleElements,
          belowLayerImage: belowLayerImage,
          aboveLayerImage: aboveLayerImage,
        ),
      ),
    );
    _isBaking = false;
    _queuedBake?.call();
  }

  Future<ByteData?> render(
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options,
  ) async {
    final realWidth = (options.width * options.quality).ceil();
    final realHeight = (options.height * options.quality).ceil();
    final realZoom = options.scale * options.quality;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = ViewPainter(
      document,
      page,
      info,
      renderBackground: options.renderBackground,
      cameraViewport: state.cameraViewport.unbake(unbakedElements: renderers),
      transform: CameraTransform(Offset(options.x, options.y), realZoom),
    );
    painter.paint(canvas, Size(realWidth.toDouble(), realHeight.toDouble()));
    final picture = recorder.endRecording();
    final image = await picture.toImage(realWidth, realHeight);
    return await image.toByteData(format: ui.ImageByteFormat.png);
  }

  XmlDocument renderSVG(
    NoteData document,
    DocumentPage page,
    SvgExportOptions options,
  ) {
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
    for (var e in [
      ...state.cameraViewport.visibleElements,
      ...state.cameraViewport.unbakedElements,
    ]) {
      e.buildSvg(xml, document, page, rect);
    }
    return xml;
  }

  void unbake({
    List<Renderer<Background>>? backgrounds,
    List<Renderer<PadElement>>? unbakedElements,
  }) {
    emit(
      state.copyWith(
        cameraViewport: state.cameraViewport.unbake(
          unbakedElements: unbakedElements,
          backgrounds: backgrounds,
        ),
      ),
    );
  }

  Future<void> loadElements(DocumentState docState) async {
    if (docState is! DocumentLoaded) return;
    final document = docState.data;
    final assetService = docState.assetService;
    final page = docState.page;
    for (var e in state.cameraViewport.unbakedElements) {
      e.dispose();
    }
    for (var e in state.cameraViewport.bakedElements) {
      e.dispose();
    }
    final renderers = page.layers
        .where((e) => !docState.invisibleLayers.contains(e.id))
        .expand((e) => e.content.map((c) => Renderer.fromInstance(c, e.id)))
        .toList();
    await Future.wait(
      renderers.map((e) async => await e.setup(document, assetService, page)),
    );
    final backgrounds = page.backgrounds.map(Renderer.fromInstance).toList();
    await Future.wait(
      backgrounds.map((e) async => await e.setup(document, assetService, page)),
    );
    emit(
      state.copyWith(
        location: state.embedding?.location ?? state.location,
        cameraViewport: state.cameraViewport.unbake(
          unbakedElements: renderers,
          backgrounds: backgrounds,
        ),
      ),
    );
  }

  void withUnbaked(List<Renderer<PadElement>> unbakedElements) {
    emit(
      state.copyWith(
        cameraViewport: state.cameraViewport.withUnbaked(unbakedElements),
      ),
    );
  }

  void setSaveState({
    AssetLocation? location,
    SaveState? saved,
    bool absolute = false,
    bool? isCreating,
  }) => emit(
    state.copyWith(
      location: location ?? state.location,
      isCreating: isCreating ?? state.isCreating,
      saved: absolute ? SaveState.absoluteRead : saved ?? state.saved,
    ),
  );

  Future<pw.Document> renderPDF(
    NoteData document,
    DocumentInfo info, {
    DocumentState? state,
    required List<AreaPreset> areas,
    bool renderBackground = true,
  }) async {
    final pdf = pw.Document();
    for (final preset in areas) {
      final areaName = preset.name;
      final quality = preset.quality;
      final page = state?.pageName == preset.page
          ? state?.page
          : document.getPage(preset.page);
      final area = preset.area ?? page?.getAreaByName(areaName);
      if (area == null || page == null) {
        continue;
      }
      final pageFormat = PdfPageFormat(
        area.width * quality,
        area.height * quality,
      );
      final image = await render(
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
      );
      if (image == null) continue;
      pdf.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (context) {
            return pw.Image(pw.MemoryImage(image.buffer.asUint8List()));
          },
        ),
      );
    }
    return pdf;
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
      state.copyWith(temporaryHandler: HandHandler(), temporaryCursor: null),
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

  bool _currentlySaving = false;

  Future<AssetLocation> save(
    DocumentState blocState, {
    AssetLocation? location,
    bool force = false,
  }) async {
    if (!force && state.saved == SaveState.saved) {
      return state.location;
    }
    if (state.networkingService.isClient) {
      return AssetLocation.empty;
    }
    final storage = getRemoteStorage();
    final fileSystem = blocState.fileSystem.buildDocumentSystem(storage);
    while (_currentlySaving) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _currentlySaving = true;
    emit(
      state.copyWith(
        saved: SaveState.saving,
        location: location ?? state.location,
      ),
    );
    location ??= state.location;
    final currentData = await blocState.saveData();
    if (currentData == null || blocState.embedding != null) {
      emit(state.copyWith(saved: SaveState.saved));
      _currentlySaving = false;
      return AssetLocation.empty;
    }
    if (state.absolute || !(location.fileType?.isNote() ?? false)) {
      final document = await fileSystem.createFileWithName(
        name: currentData.name,
        suffix: '.bfly',
        directory: location.fileExtension.isEmpty
            ? state.location.path
            : state.location.parent,
        currentData.toFile(),
      );
      location = document.location;
    } else {
      await fileSystem.updateFile(
        location.path,
        currentData.toFile(
          isTextBased: location.fileType == AssetFileType.textNote,
        ),
      );
    }
    state.settingsCubit.addRecentHistory(location);
    emit(state.copyWith(location: location, saved: SaveState.saved));
    _currentlySaving = false;
    return location;
  }

  void dispose() {
    state.networkingService.closeNetworking();
  }

  Rect getPageRect() {
    Rect? rect;
    for (final renderer in renderers) {
      final rendererRect = renderer.rect;
      if (rendererRect == null) continue;
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
    final cameraViewport = current.cameraViewport;
    final elements = List<Renderer<PadElement>>.from(
      cameraViewport.unbakedElements,
    );
    for (var renderer in {
      ...?backgrounds,
      ...?replacedElements,
      ...addedElements,
    }) {
      await renderer.setup(current.data, current.assetService, current.page);
    }
    elements.addAll(addedElements);

    if (replacedElements != null || unbake) {
      current.currentIndexCubit.unbake(
        unbakedElements: replacedElements == null
            ? null
            : [...replacedElements, ...addedElements],
        backgrounds: backgrounds,
      );
    } else if (backgrounds != null) {
      this.unbake(backgrounds: backgrounds);
    } else {
      withUnbaked(elements);
    }

    setSaveState(saved: SaveState.unsaved);
    if (current.embedding != null) {
      return;
    }
    if (reset) {
      loadElements(current);
    }
    if (reset || shouldRefresh?.call() == true) {
      refresh(current);
    }
    if (updateIndex) {
      this.updateIndex(bloc);
    }
    AssetLocation? path = current.location;
    if (current.hasAutosave()) {
      path = await current.save(location: path);
    }
  }

  void slide(ui.Offset positionVelocity, double scaleVelocity) {
    if (!state.settingsCubit.state.hasFlag('smoothNavigation')) return;
    state.transformCubit.slide(positionVelocity, scaleVelocity);
  }

  void setAreaNavigatorCreate(bool value) =>
      emit(state.copyWith(areaNavigatorCreate: value));

  void setAreaNavigatorExact(bool value) =>
      emit(state.copyWith(areaNavigatorExact: value));

  void setAreaNavigatorAsk(bool value) =>
      emit(state.copyWith(areaNavigatorAsk: value));

  void updateTogglingTools(DocumentBloc bloc, Map<int, Tool> tools) {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final newHandlers = Map<int, Handler<Tool>>.from(state.toggleableHandlers);
    final newForegrounds = Map<int, List<Renderer>>.from(
      state.toggleableForegrounds,
    );
    for (final entry in tools.entries) {
      final index = entry.key;
      final tool = entry.value;
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
        Future.wait(
          foregrounds.map(
            (e) async => await e.setup(document, blocState.assetService, page),
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

  Future<void> delayedBake(
    DocumentLoaded blocState, {
    ui.Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool testTransform = false,
  }) {
    final transformCubit = state.transformCubit;
    final oldTransform = transformCubit.state;
    return Future.delayed(const Duration(milliseconds: 100), () {
      final newTransform = transformCubit.state;
      final viewport = state.cameraViewport;
      if (testTransform &&
          (oldTransform.size != newTransform.size ||
              oldTransform.position != newTransform.position ||
              (oldTransform.size == viewport.scale &&
                  oldTransform.position == viewport.toOffset()))) {
        return Future.value();
      }
      return bake(
        blocState,
        viewportSize: viewportSize,
        pixelRatio: pixelRatio,
        reset: reset,
      );
    });
  }

  void setUserName(String name) {
    emit(state.copyWith(userName: name));
  }
}
