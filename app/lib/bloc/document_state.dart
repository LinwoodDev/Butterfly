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

class DocumentLoadFailure extends DocumentState {
  final String message;

  const DocumentLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class DocumentLoaded extends DocumentState {
  final NoteData data;
  final DocumentPage page;
  final String pageName;
  final FileMetadata metadata;

  set page(DocumentPage page) => data.setPage(page);
  set metadata(FileMetadata metadata) => data.setMetadata(metadata);

  DocumentLoaded(this.data,
      {DocumentPage? page, required this.pageName, FileMetadata? metadata})
      : page = page ?? data.getPage(pageName)!,
        metadata = metadata ?? data.getMetadata()!;

  List<String> get invisibleLayers => [];

  Area? get currentArea => null;

  AssetLocation get location => currentIndexCubit.state.location;
  bool get saved => !location.absolute && currentIndexCubit.state.saved;

  CurrentIndexCubit get currentIndexCubit;
  SettingsCubit get settingsCubit;

  TransformCubit get transformCubit => currentIndexCubit.state.transformCubit;

  NoteData saveData() {
    data.setPage(page, pageName);
    data.setMetadata(metadata);
    return data;
  }
}

class DocumentLoadSuccess extends DocumentLoaded {
  final StorageType storageType;
  final String currentLayer;
  final String currentAreaName;
  @override
  final List<String> invisibleLayers;
  @override
  final SettingsCubit settingsCubit;
  @override
  final CurrentIndexCubit currentIndexCubit;

  DocumentLoadSuccess(super.data,
      {super.page,
      required super.pageName,
      super.metadata,
      AssetLocation? location,
      this.storageType = StorageType.local,
      required this.settingsCubit,
      required this.currentIndexCubit,
      this.currentAreaName = '',
      this.currentLayer = '',
      this.invisibleLayers = const []}) {
    if (location != null) {
      currentIndexCubit.setSaveState(location: location);
    }
  }

  @override
  List<Object?> get props => [
        invisibleLayers,
        data,
        page,
        pageName,
        metadata,
        currentLayer,
        currentAreaName,
        settingsCubit,
        currentIndexCubit,
      ];

  @override
  Area? get currentArea {
    return page.getAreaByName(currentAreaName);
  }

  CameraViewport get cameraViewport => currentIndexCubit.state.cameraViewport;

  List<Renderer<PadElement>> get renderers => currentIndexCubit.renderers;

  Embedding? get embedding => currentIndexCubit.state.embedding;

  DocumentLoadSuccess copyWith({
    DocumentPage? page,
    String? pageName,
    FileMetadata? metadata,
    bool? editMode,
    String? currentLayer,
    String? currentAreaName,
    List<String>? invisibleLayers,
  }) =>
      DocumentLoadSuccess(
        data,
        page: page ?? this.page,
        pageName: pageName ?? this.pageName,
        metadata: metadata ?? this.metadata,
        invisibleLayers: invisibleLayers ?? this.invisibleLayers,
        currentLayer: currentLayer ?? this.currentLayer,
        currentAreaName: currentAreaName ?? this.currentAreaName,
        settingsCubit: settingsCubit,
        currentIndexCubit: currentIndexCubit,
        location: location,
      );

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  bool hasAutosave() =>
      !(embedding?.save ?? true) ||
      (!kIsWeb &&
          !location.absolute &&
          (location.remote.isEmpty ||
              (settingsCubit.state
                      .getRemote(location.remote)
                      ?.hasDocumentCached(location.path) ??
                  false)));

  Future<AssetLocation> save() {
    final newMeta = metadata.copyWith(updatedAt: DateTime.now().toUtc());
    data.setMetadata(newMeta);
    final storage = getRemoteStorage();
    if (embedding != null) return Future.value(AssetLocation.local(''));
    if (!location.path.endsWith('.bfly') ||
        location.absolute ||
        location.fileType != AssetFileType.note) {
      return DocumentFileSystem.fromPlatform(remote: storage)
          .importDocument(saveData(), path: location.pathWithLeadingSlash)
          .then((value) => value.location)
        ..then(settingsCubit.addRecentHistory);
    }
    return DocumentFileSystem.fromPlatform(remote: storage)
        .updateDocument(location.path, saveData())
        .then((value) => value.location)
      ..then(settingsCubit.addRecentHistory);
  }

  RemoteStorage? getRemoteStorage() => location.remote.isEmpty
      ? null
      : settingsCubit.state.getRemote(location.remote);

  Future<void> bake(
          {Size? viewportSize, double? pixelRatio, bool reset = false}) =>
      currentIndexCubit.bake(data, page,
          viewportSize: viewportSize, pixelRatio: pixelRatio, reset: reset);

  Painter? get painter => currentIndexCubit.state.handler.data;
}

class DocumentPresentationState extends DocumentLoaded {
  final DocumentLoadSuccess oldState;
  final int frame;
  final AnimationTrack track;
  final PresentationStateHandler handler;
  final bool fullScreen;

  DocumentPresentationState(
      DocumentBloc bloc, this.oldState, this.track, this.fullScreen,
      {this.frame = 0, super.metadata, super.page, required super.pageName})
      : handler = PresentationStateHandler(track, bloc),
        super(oldState.data);

  DocumentPresentationState.withHandler(
      this.handler, this.oldState, this.track, this.fullScreen,
      {this.frame = 0, super.metadata, super.page, required super.pageName})
      : super(oldState.data);

  @override
  List<Object?> get props => [oldState, frame, track];

  @override
  NoteData get data => oldState.data;

  DocumentPresentationState copyWith({
    int? frame,
  }) =>
      DocumentPresentationState.withHandler(
        handler,
        oldState,
        track,
        fullScreen,
        frame: frame ?? this.frame,
        metadata: metadata,
        page: page,
        pageName: pageName,
      );

  @override
  CurrentIndexCubit get currentIndexCubit => oldState.currentIndexCubit;

  @override
  SettingsCubit get settingsCubit => oldState.settingsCubit;
}
