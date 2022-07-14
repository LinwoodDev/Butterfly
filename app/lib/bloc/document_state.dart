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
  final AssetLocation location;
  final StorageType storageType;
  final String currentLayer;
  final int currentAreaIndex;
  final List<String> invisibleLayers;
  final SettingsCubit settingsCubit;
  final CurrentIndexCubit currentIndexCubit;
  final Embedding? embedding;
  final bool saved;

  DocumentLoadSuccess(this.document,
      {required this.location,
      this.storageType = StorageType.local,
      this.saved = true,
      required this.settingsCubit,
      required this.currentIndexCubit,
      this.currentAreaIndex = -1,
      this.currentLayer = '',
      this.embedding,
      this.invisibleLayers = const []});

  @override
  List<Object?> get props => [
        invisibleLayers,
        document,
        location,
        currentLayer,
        currentAreaIndex,
        settingsCubit,
        currentIndexCubit,
        embedding,
        saved
      ];

  Area? get currentArea {
    if (currentAreaIndex < 0 || currentAreaIndex >= document.areas.length) {
      return null;
    }
    return document.areas[currentAreaIndex];
  }

  Future<void> load() async {
    final document = document;
    final background = Renderer.fromInstance(document.background);
    await background.setup(document);
    final renderers =
        document.content.map((e) => Renderer.fromInstance(e)).toList();
    await Future.wait(renderers.map((e) async => await e.setup(document)));
    currentIndexCubit.unbaked(background, renderers);
  }

  DocumentLoadSuccess copyWith({
    AppDocument? document,
    bool? editMode,
    AssetLocation? location,
    String? currentLayer,
    int? currentAreaIndex,
    bool? saved,
    List<String>? invisibleLayers,
  }) =>
      DocumentLoadSuccess(
        document ?? this.document,
        location: location ?? this.location,
        invisibleLayers: invisibleLayers ?? this.invisibleLayers,
        currentLayer: currentLayer ?? this.currentLayer,
        currentAreaIndex: currentAreaIndex ?? this.currentAreaIndex,
        saved: saved ?? this.saved,
        settingsCubit: settingsCubit,
        embedding: embedding,
        currentIndexCubit: currentIndexCubit,
      );

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  bool hasAutosave() =>
      (embedding?.save ?? false) ||
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
}

class DocumentLoadFailure extends DocumentState {}
