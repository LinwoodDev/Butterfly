import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/async.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/selections/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:synchronized/synchronized.dart';

part 'editor_runtime.freezed.dart';

enum SaveState { saved, saving, unsaved, absoluteRead }

enum HideState { visible, keyboard, touch }

enum RendererState { visible, temporary, hidden }

enum TemporaryState { allowClick, removeAfterClick, removeAfterRelease }

@Freezed(equal: false)
sealed class RendererRuntimeState with _$RendererRuntimeState {
  const RendererRuntimeState._();

  const factory RendererRuntimeState({
    @Default(CameraViewport.unbaked()) CameraViewport cameraViewport,
    @Default({}) Map<String, RendererState> rendererStates,
    @Default({}) Map<String, RendererState>? temporaryRendererStates,
  }) = _RendererRuntimeState;

  Map<String, RendererState> get allRendererStates => {
    ...rendererStates,
    ...?temporaryRendererStates,
  };
}

class RendererCubit extends Cubit<RendererRuntimeState> {
  RendererCubit(
    this.settingsCubit, [
    super.initial = const RendererRuntimeState(),
  ]);

  final SettingsCubit settingsCubit;

  final initializedElements = <Renderer<PadElement>>{};
  final bakeLock = Lock();
  final delayedBakeRunner = CoalescedAsyncRunner(
    delay: const Duration(milliseconds: 100),
  );

  void replace(RendererRuntimeState state) => emit(state);

  void setViewport(CameraViewport cameraViewport) =>
      emit(state.copyWith(cameraViewport: cameraViewport));

  void setRendererStates({
    Map<String, RendererState>? rendererStates,
    Map<String, RendererState>? temporaryRendererStates,
  }) => emit(
    state.copyWith(
      rendererStates: rendererStates ?? state.rendererStates,
      temporaryRendererStates:
          temporaryRendererStates ?? state.temporaryRendererStates,
    ),
  );

  List<Renderer<PadElement>> get renderers =>
      List<Renderer<PadElement>>.from(state.cameraViewport.bakedElements)
        ..addAll(state.cameraViewport.unbakedElements);

  Renderer? getRenderer(PadElement element) =>
      renderers.firstWhereOrNull((renderer) => renderer.element == element);

  Future<void> disposeRuntime() async {
    delayedBakeRunner.cancel();
    await delayedBakeRunner.disposeAndWait();
    initializedElements.clear();
    state.cameraViewport.disposeImages();
    for (final renderer in renderers) {
      renderer.dispose();
    }
  }
}

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
    } else if (!toggle || !(state.selection?.selected.contains(selected) ?? false)) {
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
    if (index == null || info.tools.isEmpty || index < 0 || index >= info.tools.length) {
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
  }
}

@freezed
sealed class EditorInputState with _$EditorInputState {
  const factory EditorInputState({
    Offset? lastPosition,
    @Default([]) List<int> pointers,
    int? buttons,
    @Default(false) bool penDetected,
    @Default(false) bool sessionPenOnlyInput,
    @Default(HideState.visible) HideState hideUi,
  }) = _EditorInputState;
}

class EditorInputCubit extends Cubit<EditorInputState> {
  EditorInputCubit(
    this.settingsCubit, [
    super.initial = const EditorInputState(),
  ]);

  final SettingsCubit settingsCubit;

  void replace(EditorInputState state) => emit(state);

  void setPenDetected(bool detected, {bool enableSessionPenOnly = false}) {
    if (state.penDetected == detected &&
        (!enableSessionPenOnly || state.sessionPenOnlyInput)) {
      return;
    }
    emit(
      state.copyWith(
        penDetected: detected,
        sessionPenOnlyInput: enableSessionPenOnly
            ? true
            : state.sessionPenOnlyInput,
      ),
    );
  }

  bool get effectivePenOnlyInput {
    final setting = settingsCubit.state.penOnlyInput;
    if (setting != null) return setting;
    return state.sessionPenOnlyInput;
  }

  bool get moveEnabled =>
      (settingsCubit.state.inputGestures && state.pointers.length > 1) &&
      settingsCubit.state.moveOnGesture;

  void detectPen(bool detected) {
    if (state.penDetected == detected) return;
    setPenDetected(
      detected,
      enableSessionPenOnly:
          detected &&
          settingsCubit.state.penOnlyInput == null &&
          !state.sessionPenOnlyInput,
    );
  }

  void setSessionPenOnlyInput(bool value) {
    if (state.sessionPenOnlyInput != value) {
      emit(state.copyWith(sessionPenOnlyInput: value));
    }
  }

  void updateLastPosition(Offset position) {
    final lastPos = state.lastPosition;
    if (lastPos != null) {
      final dx = (position.dx - lastPos.dx).abs();
      final dy = (position.dy - lastPos.dy).abs();
      if (dx < 1 && dy < 1) return;
    }
    emit(state.copyWith(lastPosition: position));
  }

  void addPointer(int pointer) {
    if (!state.pointers.contains(pointer)) {
      emit(state.copyWith(pointers: [...state.pointers, pointer]));
    }
  }

  void removePointer(int pointer) {
    if (state.pointers.contains(pointer)) {
      emit(
        state.copyWith(
          pointers: state.pointers.where((p) => p != pointer).toList(),
        ),
      );
    }
  }

  void setButtons(int buttons) => emit(state.copyWith(buttons: buttons));

  void removeButtons() => emit(state.copyWith(buttons: null));

  void resetInputState() => emit(state.copyWith(buttons: null, pointers: []));

  void toggleKeyboardHideUI() => emit(
    state.copyWith(
      hideUi: state.hideUi == HideState.visible
          ? HideState.keyboard
          : HideState.visible,
    ),
  );

  void enterTouchHideUI() => emit(state.copyWith(hideUi: HideState.touch));

  void exitHideUI() => emit(state.copyWith(hideUi: HideState.visible));
}

@freezed
sealed class DocumentSaveState with _$DocumentSaveState {
  const DocumentSaveState._();

  const factory DocumentSaveState({
    @Default(false) bool isSaveDelayed,
    @Default(AssetLocation(path: '')) AssetLocation location,
    Embedding? embedding,
    @Default(SaveState.saved) SaveState saved,
    @Default(false) bool isCreating,
  }) = _DocumentSaveState;

  bool get absolute => saved == SaveState.absoluteRead;
}

class DocumentSaveCubit extends Cubit<DocumentSaveState> {
  DocumentSaveCubit(
    this.settingsCubit, [
    super.initial = const DocumentSaveState(),
  ]);

  final SettingsCubit settingsCubit;

  final savingLock = Lock();

  void replace(DocumentSaveState state) => emit(state);

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

  void setDelayed(bool delayed) => emit(state.copyWith(isSaveDelayed: delayed));
}

@freezed
sealed class EditorViewState with _$EditorViewState {
  const factory EditorViewState({
    @Default(UtilitiesState()) UtilitiesState utilities,
    @Default(ViewOption()) ViewOption viewOption,
    @Default(true) bool areaNavigatorCreate,
    @Default(true) bool areaNavigatorExact,
    @Default(false) bool areaNavigatorAsk,
    @Default(false) bool navigatorEnabled,
    @Default(NavigatorPage.waypoints) NavigatorPage navigatorPage,
    @Default('') String userName,
  }) = _EditorViewState;
}

class EditorViewCubit extends Cubit<EditorViewState> {
  EditorViewCubit({this.editorSessionCubit, EditorViewState? initial})
    : super(initial ?? const EditorViewState());

  final EditorSessionCubit? editorSessionCubit;

  void replace(EditorViewState state) => emit(state);

  void updateUtilities({UtilitiesState? utilities, ViewOption? view}) {
    emit(
      state.copyWith(
        utilities: utilities ?? state.utilities,
        viewOption: view ?? state.viewOption,
      ),
    );
    if (utilities != null) {
      editorSessionCubit?.updateUtilities(utilities);
    }
  }

  void setAreaNavigator({bool? create, bool? exact, bool? ask}) {
    emit(
      state.copyWith(
        areaNavigatorCreate: create ?? state.areaNavigatorCreate,
        areaNavigatorExact: exact ?? state.areaNavigatorExact,
        areaNavigatorAsk: ask ?? state.areaNavigatorAsk,
      ),
    );
    editorSessionCubit?.updateAreaNavigator(
      create: create,
      exact: exact,
      ask: ask,
    );
  }

  void setNavigator({bool? enabled, NavigatorPage? page}) {
    emit(
      state.copyWith(
        navigatorEnabled: enabled ?? state.navigatorEnabled,
        navigatorPage: page ?? state.navigatorPage,
      ),
    );
    editorSessionCubit?.updateNavigator(enabled: enabled, page: page);
  }

  void setUserName(String name) => emit(state.copyWith(userName: name));
}
