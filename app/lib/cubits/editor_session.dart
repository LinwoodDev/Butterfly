import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditorSessionCubit extends Cubit<PersistedDocumentState> {
  EditorSessionCubit({
    required this.fileSystem,
    required TransformCubit transformCubit,
    required PersistedDocumentState initialState,
    required this.pathKey,
    required this.contentHash,
    this.persist = true,
  }) : _transformCubit = transformCubit,
       super(initialState.touch(pathKey: pathKey, contentHash: contentHash)) {
    _transformSubscription = transformCubit.stream.listen(_onTransformChanged);
  }

  final DocumentStateFileSystem fileSystem;
  final TransformCubit _transformCubit;
  final String? pathKey;
  final String? contentHash;
  final bool persist;
  StreamSubscription<CameraTransform>? _transformSubscription;
  Timer? _saveDebounce;

  static Future<PersistedDocumentState?> load({
    required DocumentStateFileSystem fileSystem,
    String? contentHash,
    String? pathKey,
    bool allowContentHash = true,
  }) async {
    await fileSystem.initialize();
    if (allowContentHash && contentHash != null) {
      final byContent = await fileSystem.getFile(
        documentStateContentKey(contentHash),
      );
      if (byContent != null) return byContent;
    }
    if (pathKey != null) {
      return fileSystem.getFile(pathKey);
    }
    return null;
  }

  static PersistedDocumentState buildInitial({
    PersistedDocumentState? restored,
    required NoteData document,
    required DocumentPage page,
    required String? fallbackPageName,
    required UtilitiesState fallbackUtilities,
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
        restored?.currentLayer != null &&
            restored!.currentLayer.isNotEmpty &&
            layers.contains(restored.currentLayer)
        ? restored.currentLayer
        : page.layers.lastOrNull?.id ?? '';
    final invisibleLayers =
        restored?.invisibleLayers.where(layers.contains).toSet() ??
        const <String>{};
    return (restored ?? PersistedDocumentState(utilities: fallbackUtilities))
        .copyWith(
          pathKey: pathKey,
          contentHash: contentHash,
          pageName: pageName,
          currentLayer: currentLayer,
          invisibleLayers: invisibleLayers,
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
        (e) => e.name == state.navigatorPage,
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

  void updateUtilities(UtilitiesState utilities) {
    if (state.utilities == utilities) return;
    emit(state.copyWith(utilities: utilities));
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
      navigatorEnabled: enabled ?? state.navigatorEnabled,
      navigatorPage: page?.name ?? state.navigatorPage,
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
      currentLayer: currentLayer ?? state.currentLayer,
      currentCollection: currentCollection ?? state.currentCollection,
      invisibleLayers: invisibleLayers ?? state.invisibleLayers,
    );
    if (next == state) return;
    emit(next);
    unawaited(saveNow());
  }

  void updateAreaNavigator({bool? create, bool? exact, bool? ask}) {
    final next = state.copyWith(
      areaNavigatorCreate: create ?? state.areaNavigatorCreate,
      areaNavigatorExact: exact ?? state.areaNavigatorExact,
      areaNavigatorAsk: ask ?? state.areaNavigatorAsk,
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
    await fileSystem.initialize();
    if (contentHash != null) {
      final key = documentStateContentKey(contentHash!);
      if (await fileSystem.hasKey(key)) {
        await fileSystem.updateFile(key, next);
      } else {
        await fileSystem.createFile(key, next);
      }
    }
    if (pathKey != null) {
      if (await fileSystem.hasKey(pathKey!)) {
        await fileSystem.updateFile(pathKey!, next);
      } else {
        await fileSystem.createFile(pathKey!, next);
      }
    }
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
