part of 'document_bloc.dart';

enum StorageType {
  local,
  cloud,
}

abstract class DocumentState extends Equatable {
  final WindowCubit windowCubit;
  final ButterflyFileSystem fileSystem;

  const DocumentState({
    required this.windowCubit,
    required this.fileSystem,
  });

  @override
  List<Object?> get props => [];

  NoteData? get data => null;
  DocumentPage? get page => null;
  DocumentInfo? get info => null;
  String? get pageName => null;
  FileMetadata? get metadata => null;
  AssetService? get assetService => null;
  CurrentIndexCubit? get currentIndexCubit => null;
  NetworkingService? get networkingService =>
      currentIndexCubit?.state.networkingService;
  Embedding? get embedding => currentIndexCubit?.state.embedding;
  SettingsCubit get settingsCubit => fileSystem.settingsCubit;
  Area? get currentArea => null;

  NoteData? saveData([NoteData? current]) => data;
  List<int>? saveBytes([NoteData? current]) => saveData()?.save();
}

class DocumentLoadInProgress extends DocumentState {
  const DocumentLoadInProgress(
      {required super.fileSystem, required super.windowCubit});
}

class DocumentLoadFailure extends DocumentState {
  final String message;
  final StackTrace? stackTrace;

  const DocumentLoadFailure({
    required super.fileSystem,
    required super.windowCubit,
    required this.message,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, stackTrace];
}

abstract class DocumentLoaded extends DocumentState {
  @override
  final NoteData data;
  @override
  final DocumentPage page;
  @override
  final DocumentInfo info;
  @override
  final String pageName;
  @override
  final FileMetadata metadata;
  @override
  final AssetService assetService;

  NoteData _updatePage(NoteData current) => current.setPage(page, pageName);
  NoteData _updateMetadata(NoteData current) =>
      current.setMetadata(metadata.copyWith(
        updatedAt: DateTime.now().toUtc(),
      ));
  NoteData _updateInfo(NoteData current) =>
      current.setInfo(info.copyWith(view: currentIndexCubit.state.viewOption));

  DocumentLoaded(this.data,
      {DocumentPage? page,
      required super.fileSystem,
      required super.windowCubit,
      required this.pageName,
      AssetService? assetService,
      FileMetadata? metadata,
      DocumentInfo? info})
      : page = page ?? data.getPage(pageName) ?? DocumentDefaults.createPage(),
        assetService = assetService ?? AssetService(data),
        metadata =
            metadata ?? data.getMetadata() ?? DocumentDefaults.createMetadata(),
        info = info ?? data.getInfo() ?? DocumentDefaults.createInfo();

  List<String> get invisibleCollections => [];

  @override
  Area? get currentArea => null;

  AssetLocation get location => currentIndexCubit.state.location;
  bool get absolute => currentIndexCubit.state.absolute;
  SaveState get saved =>
      absolute ? SaveState.unsaved : currentIndexCubit.state.saved;

  @override
  CurrentIndexCubit get currentIndexCubit;
  @override
  NetworkingService get networkingService =>
      currentIndexCubit.state.networkingService;

  TransformCubit get transformCubit => currentIndexCubit.state.transformCubit;

  @override
  NoteData saveData([NoteData? current]) {
    current ??= data;
    current = _updatePage(current);
    current = _updateMetadata(current);
    current = _updateInfo(current);
    return current;
  }

  Future<void> bake(
          {Size? viewportSize, double? pixelRatio, bool reset = false}) =>
      currentIndexCubit.bake(data, page, info,
          viewportSize: viewportSize, pixelRatio: pixelRatio, reset: reset);
}

class DocumentLoadSuccess extends DocumentLoaded {
  final StorageType storageType;
  final String currentCollection, currentAreaName;
  final int currentLayer;
  @override
  final List<String> invisibleCollections;
  @override
  final CurrentIndexCubit currentIndexCubit;

  DocumentLoadSuccess(super.data,
      {super.page,
      required super.fileSystem,
      required super.windowCubit,
      super.assetService,
      required super.pageName,
      super.metadata,
      super.info,
      AssetLocation? location,
      bool absolute = false,
      this.storageType = StorageType.local,
      required this.currentIndexCubit,
      this.currentAreaName = '',
      this.currentCollection = '',
      this.currentLayer = 0,
      this.invisibleCollections = const []}) {
    if (location != null) {
      currentIndexCubit.setSaveState(location: location, absolute: absolute);
    }
  }

  @override
  List<Object?> get props => [
        invisibleCollections,
        data,
        info,
        page,
        pageName,
        metadata,
        currentCollection,
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

  DocumentLoadSuccess copyWith({
    NoteData? data,
    DocumentPage? page,
    String? pageName,
    FileMetadata? metadata,
    DocumentInfo? info,
    bool? editMode,
    String? currentCollection,
    String? currentAreaName,
    List<String>? invisibleCollections,
  }) =>
      DocumentLoadSuccess(
        data ?? this.data,
        assetService: assetService,
        page: page ?? this.page,
        pageName: pageName ?? this.pageName,
        metadata: metadata ?? this.metadata,
        info: info ?? this.info,
        invisibleCollections: invisibleCollections ?? this.invisibleCollections,
        currentCollection: currentCollection ?? this.currentCollection,
        currentAreaName: currentAreaName ?? this.currentAreaName,
        fileSystem: fileSystem,
        windowCubit: windowCubit,
        currentIndexCubit: currentIndexCubit,
        location: location,
        absolute: absolute,
      );

  bool isLayerVisible(String layer) => !invisibleCollections.contains(layer);

  bool hasAutosave() =>
      settingsCubit.state.autosave &&
      (networkingService.isActive ||
          !(embedding?.save ?? true) ||
          (!kIsWeb &&
              !absolute &&
              (location.fileType == AssetFileType.note ||
                  location.fileType == null) &&
              (location.remote.isEmpty ||
                  (settingsCubit.state
                          .getRemote(location.remote)
                          ?.hasDocumentCached(location.path) ??
                      false))));

  Future<AssetLocation> save([AssetLocation? location]) =>
      currentIndexCubit.save(this, location);

  ExternalStorage? getRemoteStorage() => currentIndexCubit.getRemoteStorage();

  Tool? get tool => currentIndexCubit.state.handler.data;

  AreaPreset get areaPreset => AreaPreset(
        name: pageName,
        area: cameraViewport.toArea(),
        page: pageName,
        quality: settingsCubit.state.pdfQuality,
      );

  DocumentPage mapLayer(DocumentLayer Function(DocumentLayer) mapper) {
    final layers = List<DocumentLayer>.from(page.layers);
    if (layers.isEmpty) {
      layers.add(const DocumentLayer());
    }
    final layerIndex = currentLayer.clamp(0, layers.length - 1);
    final newLayer = mapper(layers[layerIndex]);
    layers[layerIndex] = newLayer;
    final newPage = page.copyWith(layers: layers);
    return newPage;
  }
}

class DocumentPresentationState extends DocumentLoaded {
  final DocumentLoadSuccess oldState;
  final int frame;
  final AnimationTrack track;
  final PresentationStateHandler handler;
  final bool fullScreen;

  DocumentPresentationState(
      DocumentBloc bloc, this.oldState, this.track, this.fullScreen,
      {this.frame = 0,
      super.metadata,
      super.page,
      required super.fileSystem,
      required super.windowCubit,
      required super.pageName,
      required super.assetService})
      : handler = PresentationStateHandler(track, bloc),
        super(oldState.data);

  DocumentPresentationState.withHandler(
      this.handler, this.oldState, this.track, this.fullScreen,
      {this.frame = 0,
      super.metadata,
      super.page,
      required super.fileSystem,
      required super.windowCubit,
      required super.pageName,
      required super.assetService})
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
        assetService: assetService,
        frame: frame ?? this.frame,
        metadata: metadata,
        page: page,
        pageName: pageName,
        fileSystem: fileSystem,
        windowCubit: windowCubit,
      );

  @override
  CurrentIndexCubit get currentIndexCubit => oldState.currentIndexCubit;

  @override
  SettingsCubit get settingsCubit => oldState.settingsCubit;
}
