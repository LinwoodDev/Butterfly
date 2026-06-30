import 'dart:async';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/repositories/document_state.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorSessionCubit extends Cubit<PersistedDocumentState> {
  EditorSessionCubit({
    required this.repository,
    required TransformCubit transformCubit,
    required PersistedDocumentState initialState,
    required this.pathKey,
    required this.contentHash,
    this.persist = true,
  }) : _transformCubit = transformCubit,
       super(initialState.touch(pathKey: pathKey, contentHash: contentHash)) {
    _transformSubscription = transformCubit.stream.listen(_onTransformChanged);
  }

  final DocumentStateRepository repository;
  final TransformCubit _transformCubit;
  final String? pathKey;
  final String? contentHash;
  final bool persist;
  StreamSubscription<CameraTransform>? _transformSubscription;
  Timer? _saveDebounce;

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
    final camera = PersistedCameraState(
      positionX: transform.position.dx,
      positionY: transform.position.dy,
      zoom: transform.size,
    );
    if (state.camera == camera) return;
    emit(state.copyWith(camera: camera));
    scheduleSave();
  }

  void updatePage(String pageName) {
    if (state.pageName == pageName) return;
    emit(state.copyWith(pageName: pageName));
    unawaited(saveNow());
  }

  void updateLocks(PersistentLockState locks) {
    if (state.locks == locks) return;
    emit(state.copyWith(locks: locks));
    unawaited(saveNow());
  }

  void updateSelectedTool(Tool? tool, int? index) {
    final selection = PersistedToolSelection(
      toolId: tool?.id,
      toolIndex: index,
    );
    if (state.selectedTool == selection) return;
    emit(state.copyWith(selectedTool: selection));
    unawaited(saveNow());
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
    unawaited(saveNow());
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
    unawaited(saveNow());
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
    unawaited(saveNow());
  }

  void scheduleSave() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 250), () {
      unawaited(saveNow());
    });
  }

  Future<void> saveNow() async {
    if (!persist) return;
    _saveDebounce?.cancel();
    _saveDebounce = null;
    final next = state.touch(pathKey: pathKey, contentHash: contentHash);
    emit(next);
    await repository.save(next, contentHash: contentHash, pathKey: pathKey);
  }

  @override
  Future<void> close() async {
    _saveDebounce?.cancel();
    _saveDebounce = null;
    if (persist) await saveNow();
    await _transformSubscription?.cancel();
    return super.close();
  }
}
