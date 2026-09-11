import 'dart:async';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly/services/document_state.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorSessionCubit extends Cubit<PersistedDocumentState> {
  new({
    required this.service,
    required this._transformCubit,
    required PersistedDocumentState initialState,
    String? pathKey,
    String? contentHash,
  }) : super(
         initialState.copyWith(
           pathKey: pathKey ?? initialState.pathKey,
           contentHash: contentHash ?? initialState.contentHash,
         ),
       ) {
    _transformSubscription = _transformCubit.stream.listen(_onTransformChanged);
  }

  final DocumentStateService service;
  final TransformCubit _transformCubit;
  StreamSubscription<CameraTransform>? _transformSubscription;
  Timer? _saveDebounce;
  Future<void>? _saveFuture;
  ({
    PersistedDocumentState state,
    bool persistentChanged,
    PersistedDocumentState? previousState,
  })?
  _pendingSave;
  var _dirty = false;

  bool get isDirty => _dirty || _pendingSave != null || _saveDebounce != null;

  static PersistedDocumentState buildInitial({
    PersistedDocumentState? restored,
    required NoteData document,
    required DocumentPage page,
    required String? fallbackPageName,
    required PersistentLockState fallbackLocks,
    String? pathKey,
    String? contentHash,
  }) {
    final pages = document.getPages(true).toSet();
    final pageName =
        restored?.pageName != null && pages.contains(restored!.pageName)
        ? restored.pageName
        : fallbackPageName;
    final layers = page.layers.map((e) => e.id).nonNulls.toSet();
    final currentLayer =
        restored?.layers.currentLayer != null &&
            restored!.layers.currentLayer.isNotEmpty &&
            layers.contains(restored.layers.currentLayer)
        ? restored.layers.currentLayer
        : page.layers.lastOrNull?.id ?? '';
    final invisibleLayers =
        restored?.layers.invisibleLayers.where(layers.contains).toSet() ??
        const <String>{};
    return (restored ?? PersistedDocumentState(locks: fallbackLocks)).copyWith(
      pathKey: pathKey,
      contentHash: contentHash,
      pageName: pageName,
      camera:
          restored?.pageCameras[pageName] ??
          (restored?.pageName == pageName ? restored?.camera : null) ??
          const PersistedCameraState(),
      pageCameras: {
        if (restored?.pageName != null && pages.contains(restored!.pageName))
          restored.pageName!: restored.camera,
        ...Map.fromEntries(
          restored?.pageCameras.entries.where(
                (entry) => pages.contains(entry.key),
              ) ??
              const <MapEntry<String, PersistedCameraState>>[],
        ),
      },
      layers: (restored?.layers ?? const PersistedLayerState()).copyWith(
        currentLayer: currentLayer,
        invisibleLayers: invisibleLayers,
      ),
      updatedAt: restored?.updatedAt,
    );
  }

  CameraTransform get cameraTransform => CameraTransform(
    _transformCubit.state.pixelRatio,
    Offset(state.camera.positionX, state.camera.positionY),
    state.camera.zoom,
    state.camera.rotation,
  );

  int resolveToolIndex(DocumentInfo info) {
    final toolId = state.selectedTool.toolId;
    if (toolId != null) {
      final index = info.tools.indexWhere((tool) => tool.id == toolId);
      if (index >= 0) return index;
    }
    final index = state.selectedTool.toolIndex;
    if (index != null && index >= 0 && index < info.tools.length) {
      return index;
    }
    return 0;
  }

  NavigatorPage get navigatorPage =>
      NavigatorPage.values.firstWhereOrNull(
        (e) => e.name == state.navigator.page,
      ) ??
      NavigatorPage.waypoints;

  void _onTransformChanged(CameraTransform transform) {
    // Ignore events queued before the current camera was restored.
    if (transform != _transformCubit.state) return;
    final camera = PersistedCameraState(
      positionX: transform.position.dx,
      positionY: transform.position.dy,
      zoom: transform.size,
      rotation: transform.rotation,
    );
    if (state.camera == camera) return;
    emit(
      state.copyWith(
        camera: camera,
        pageCameras: {
          ...state.pageCameras,
          if (state.pageName != null) state.pageName!: camera,
        },
      ),
    );
    _dirty = true;
  }

  void updatePage(String pageName) {
    if (state.pageName == pageName) return;
    _onTransformChanged(_transformCubit.state);
    final camera = service.persistCamera
        ? state.pageCameras[pageName] ?? const PersistedCameraState()
        : const PersistedCameraState();
    emit(
      state.copyWith(
        pageName: pageName,
        camera: camera,
        pageCameras: {
          ...state.pageCameras,
          if (state.pageName != null) state.pageName!: state.camera,
        },
      ),
    );
    _transformCubit.teleport(
      Offset(camera.positionX, camera.positionY),
      camera.zoom,
      camera.rotation,
    );
    _dirty = true;
  }

  void renamePages(Map<String, String> names) {
    _onTransformChanged(_transformCubit.state);
    emit(
      state.copyWith(
        pageName: names[state.pageName] ?? state.pageName,
        pageCameras: {
          for (final entry in state.pageCameras.entries)
            names[entry.key] ?? entry.key: entry.value,
        },
      ),
    );
    _dirty = true;
  }

  void removePage(String pageName) {
    emit(state.copyWith(pageCameras: {...state.pageCameras}..remove(pageName)));
    _dirty = true;
  }

  void updateLocks(PersistentLockState locks) {
    if (state.locks == locks) return;
    emit(state.copyWith(locks: locks));
    _dirty = true;
  }

  void updateSelectedTool(Tool? tool, int? index) {
    final selection = PersistedToolSelection(
      toolId: tool?.id,
      toolIndex: index,
    );
    if (state.selectedTool == selection) return;
    emit(state.copyWith(selectedTool: selection));
    _dirty = true;
  }

  void updateNavigator({bool? enabled, NavigatorPage? page}) {
    final next = state.copyWith(
      navigator: state.navigator.copyWith(
        enabled: enabled ?? state.navigator.enabled,
        page: page?.name ?? state.navigator.page,
      ),
    );
    if (next == state) return;
    emit(next);
    _dirty = true;
  }

  void updateLayer({
    String? currentLayer,
    String? currentCollection,
    Set<String>? invisibleLayers,
  }) {
    final next = state.copyWith(
      layers: state.layers.copyWith(
        currentLayer: currentLayer ?? state.layers.currentLayer,
        currentCollection: currentCollection ?? state.layers.currentCollection,
        invisibleLayers: invisibleLayers ?? state.layers.invisibleLayers,
      ),
    );
    if (next == state) return;
    emit(next);
    _dirty = true;
  }

  void updateAreaNavigator({bool? create, bool? exact, bool? ask}) {
    final next = state.copyWith(
      areaNavigator: state.areaNavigator.copyWith(
        create: create ?? state.areaNavigator.create,
        exact: exact ?? state.areaNavigator.exact,
        ask: ask ?? state.areaNavigator.ask,
      ),
    );
    if (next == state) return;
    emit(next);
    _dirty = true;
  }

  void scheduleSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 250), () {
      unawaited(saveNow());
    });
  }

  Future<void> saveNow({String? pathKey, String? contentHash}) async {
    _onTransformChanged(_transformCubit.state);
    final persistentChanged = _dirty;
    _saveDebounce?.cancel();
    _saveDebounce = null;
    final pathChanged = pathKey != null && pathKey != state.pathKey;
    final contentChanged =
        contentHash != null && contentHash != state.contentHash;
    if (!pathChanged && !contentChanged && !persistentChanged) {
      return;
    }

    final next = state.copyWith(
      pathKey: pathKey ?? state.pathKey,
      contentHash: contentHash ?? state.contentHash,
      updatedAt: DateTime.now().toUtc(),
    );
    final previousState = state;
    _dirty = false;
    emit(next);
    _pendingSave = (
      state: next,
      previousState: previousState,
      persistentChanged:
          persistentChanged || (_pendingSave?.persistentChanged ?? false),
    );
    _saveFuture ??= _drainSaves();
    await _saveFuture;
  }

  Future<void> _drainSaves() async {
    try {
      while (_pendingSave != null) {
        final pending = _pendingSave!;
        final next = pending.state;
        final previousState = pending.previousState;
        _pendingSave = null;

        try {
          await service.save(
            next,
            contentKey: next.contentHash == null
                ? null
                : documentStateContentKey(next.contentHash!),
            pathKey: next.pathKey,
            previousContentKey: previousState?.contentHash == null
                ? null
                : documentStateContentKey(previousState!.contentHash!),
            previousPathKey: previousState?.pathKey,
            persistentChanged: pending.persistentChanged,
          );
        } catch (e, stackTrace) {
          debugPrintStack(
            label: 'Error saving document state',
            stackTrace: stackTrace,
          );
          rethrow;
        }
      }
    } finally {
      _saveFuture = null;
    }
  }

  @override
  Future<void> close() async {
    _saveDebounce?.cancel();
    _saveDebounce = null;
    if (_dirty || _pendingSave != null) {
      await saveNow();
    } else {
      await _saveFuture;
    }
    await _transformSubscription?.cancel();
    return super.close();
  }
}
