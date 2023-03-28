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
  AppDocument get document;

  const DocumentLoaded();

  List<String> get invisibleLayers => [];

  Area? get currentArea => null;

  CurrentIndexCubit get currentIndexCubit;
  SettingsCubit get settingsCubit;

  TransformCubit get transformCubit => currentIndexCubit.state.transformCubit;
}

class DocumentLoadSuccess extends DocumentLoaded {
  @override
  final AppDocument document;
  final StorageType storageType;
  final String currentLayer;
  final String currentAreaName;
  @override
  final List<String> invisibleLayers;
  @override
  final SettingsCubit settingsCubit;
  @override
  final CurrentIndexCubit currentIndexCubit;

  DocumentLoadSuccess(this.document,
      {AssetLocation? location,
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
        document,
        currentLayer,
        currentAreaName,
        settingsCubit,
        currentIndexCubit,
      ];

  @override
  Area? get currentArea {
    return document.getAreaByName(currentAreaName);
  }

  CameraViewport get cameraViewport => currentIndexCubit.state.cameraViewport;

  List<Renderer<PadElement>> get renderers => currentIndexCubit.renderers;

  AssetLocation get location => currentIndexCubit.state.location;
  bool get saved => !location.absolute && currentIndexCubit.state.saved;

  Embedding? get embedding => currentIndexCubit.state.embedding;

  DocumentLoadSuccess copyWith({
    AppDocument? document,
    bool? editMode,
    String? currentLayer,
    String? currentAreaName,
    List<String>? invisibleLayers,
  }) =>
      DocumentLoadSuccess(
        document ?? this.document,
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
    final storage = getRemoteStorage();
    if (embedding != null) return Future.value(AssetLocation.local(''));
    final newDocument = document.copyWith(updatedAt: DateTime.now());
    if (!location.path.endsWith('.bfly') ||
        location.absolute ||
        location.fileType != AssetFileType.note) {
      return DocumentFileSystem.fromPlatform(remote: storage)
          .importDocument(newDocument, path: location.pathWithLeadingSlash)
          .then((value) => value.location)
        ..then(settingsCubit.addRecentHistory);
    }
    return DocumentFileSystem.fromPlatform(remote: storage)
        .updateDocument(location.path, newDocument)
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
      [this.frame = 0])
      : handler = PresentationStateHandler(track, bloc);

  const DocumentPresentationState.withHandler(
      this.handler, this.oldState, this.track, this.fullScreen,
      [this.frame = 0]);

  @override
  List<Object?> get props => [oldState, frame, track];

  @override
  AppDocument get document => oldState.document;

  DocumentPresentationState copyWith({
    int? frame,
  }) =>
      DocumentPresentationState.withHandler(
          handler, oldState, track, fullScreen, frame ?? this.frame);

  @override
  CurrentIndexCubit get currentIndexCubit => oldState.currentIndexCubit;

  @override
  SettingsCubit get settingsCubit => oldState.settingsCubit;
}
