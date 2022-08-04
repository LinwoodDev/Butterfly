part of 'document_bloc.dart';

enum StorageType {
  local,
  cloud,
}

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final StorageType storageType;
  final String currentLayer;
  final int currentAreaIndex;
  final List<String> invisibleLayers;
  final SettingsCubit settingsCubit;
  final CurrentIndexCubit currentIndexCubit;

  DocumentLoadSuccess(this.document,
      {AssetLocation? location,
      this.storageType = StorageType.local,
      required this.settingsCubit,
      required this.currentIndexCubit,
      this.currentAreaIndex = -1,
      this.currentLayer = '',
      this.invisibleLayers = const []}) {
    if (location != null) {
      currentIndexCubit.setSaveState(location: location);
    }
  }

  @override
  List<Object?> get props => [
        invisibleLayers,
        document,
        currentLayer,
        currentAreaIndex,
        settingsCubit,
        currentIndexCubit,
      ];

  Area? get currentArea {
    if (currentAreaIndex < 0 || currentAreaIndex >= document.areas.length) {
      return null;
    }
    return document.areas[currentAreaIndex];
  }

  CameraViewport get cameraViewport => currentIndexCubit.state.cameraViewport;

  List<Renderer<PadElement>> get renderers => currentIndexCubit.renderers;

  AssetLocation get location => currentIndexCubit.state.location;
  bool get saved => currentIndexCubit.state.saved;

  Future<void> load() async {
    currentIndexCubit.setSaveState(saved: true);
    final background = Renderer.fromInstance(document.background);
    await background.setup(document);
    final renderers =
        document.content.map((e) => Renderer.fromInstance(e)).toList();
    await Future.wait(renderers.map((e) async => await e.setup(document)));
    currentIndexCubit.unbake(
        background: background, unbakedElements: renderers);
  }

  Embedding? get embedding => currentIndexCubit.state.embedding;

  DocumentLoadSuccess copyWith({
    AppDocument? document,
    bool? editMode,
    String? currentLayer,
    int? currentAreaIndex,
    List<String>? invisibleLayers,
  }) =>
      DocumentLoadSuccess(
        document ?? this.document,
        invisibleLayers: invisibleLayers ?? this.invisibleLayers,
        currentLayer: currentLayer ?? this.currentLayer,
        currentAreaIndex: currentAreaIndex ?? this.currentAreaIndex,
        settingsCubit: settingsCubit,
        currentIndexCubit: currentIndexCubit,
        location: location,
      );

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  bool hasAutosave() =>
      !(embedding?.save ?? true) ||
      (!kIsWeb &&
          (location.remote.isEmpty ||
              (settingsCubit.state
                      .getRemote(location.remote)
                      ?.hasDocumentCached(location.path) ??
                  false)));

  Future<AssetLocation> save() {
    final storage = getRemoteStorage();
    if (embedding != null) return Future.value(AssetLocation.local(''));
    if (location.path == '') {
      return DocumentFileSystem.fromPlatform(remote: storage)
          .importDocument(document)
          .then((value) => value.location)
        ..then(settingsCubit.addRecentHistory);
    }
    return DocumentFileSystem.fromPlatform(remote: storage)
        .updateDocument(location.path, document)
        .then((value) => value.location)
      ..then(settingsCubit.addRecentHistory);
  }

  RemoteStorage? getRemoteStorage() => location.remote.isEmpty
      ? null
      : settingsCubit.state.getRemote(location.remote);

  Future<void> bake(
          {Size? viewportSize, double? pixelRatio, bool reset = false}) =>
      currentIndexCubit.bake(document,
          viewportSize: viewportSize, pixelRatio: pixelRatio, reset: reset);
}

class DocumentLoadFailure extends DocumentState {}
