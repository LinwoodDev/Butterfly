part of 'document_bloc.dart';

enum StorageType { local, cloud }

abstract class DocumentState extends Equatable {
  final WindowCubit windowCubit;
  final ButterflyFileSystem fileSystem;

  const DocumentState({required this.windowCubit, required this.fileSystem});

  @override
  List<Object?> get props => [];

  NoteData? get data => null;
  DocumentPage? get page => null;
  DocumentInfo? get info => null;
  String? get pageName => null;
  FileMetadata? get metadata => null;
  AssetService? get assetService => null;
  NetworkingService? get networkingService => null;
  Embedding? get embedding => null;
  SettingsCubit get settingsCubit => fileSystem.settingsCubit;
  Area? get currentArea => null;
  String? get currentCollection => null;

  String? get currentLayer => null;

  Future<NoteData?> saveData([NoteData? current]) => Future.value(data);
  Future<Uint8List?> saveBytes([NoteData? current]) =>
      saveData().then((e) => e?.exportAsBytes());
}

class DocumentLoadInProgress extends DocumentState {
  const DocumentLoadInProgress({
    required super.fileSystem,
    required super.windowCubit,
  });
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

Uint8List _encodePage(DocumentPage page) =>
    utf8.encode(jsonEncode(page.toJson()));

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
  @override
  final NetworkingService networkingService;
  @override
  final Embedding? embedding;
  final AssetLocation location;
  final bool absolute;
  final SaveState saved;
  final CameraViewport cameraViewport;
  final ViewOption viewOption;

  List<Renderer<PadElement>> get renderers => [
    ...cameraViewport.bakedElements,
    ...cameraViewport.unbakedElements,
  ];

  Future<NoteData> _updatePage(NoteData current) async =>
      current.setRawPage(await compute(_encodePage, page), pageName).$1;
  NoteData _updateMetadata(NoteData current) =>
      current.setMetadata(metadata.copyWith(updatedAt: DateTime.now().toUtc()));
  NoteData _updateInfo(NoteData current) =>
      current.setInfo(info.copyWith(view: viewOption));

  DocumentLoaded(
    this.data, {
    DocumentPage? page,
    required super.fileSystem,
    required super.windowCubit,
    required this.pageName,
    AssetService? assetService,
    FileMetadata? metadata,
    DocumentInfo? info,
    required this.networkingService,
    this.embedding,
    required this.location,
    required this.absolute,
    required this.saved,
    required this.cameraViewport,
    required this.viewOption,
  }) : page = page ?? data.getPage(pageName) ?? DocumentDefaults.createPage(),
       assetService = assetService ?? AssetService(),
       metadata =
           metadata ?? data.getMetadata() ?? DocumentDefaults.createMetadata(),
       info = info ?? data.getInfo() ?? DocumentDefaults.createInfo();

  Set<String> get invisibleLayers => {};

  @override
  Area? get currentArea => null;

  @override
  Future<NoteData> saveData([NoteData? current]) async {
    current ??= data;
    current = await _updatePage(current);
    current = _updateMetadata(current);
    current = _updateInfo(current);
    return current;
  }

  @override
  Future<Uint8List> saveBytes([NoteData? current]) =>
      saveData().then((e) => e.exportAsBytes());
}

class DocumentLoadSuccess extends DocumentLoaded {
  final StorageType storageType;
  @override
  final String currentCollection;
  final String currentAreaName;
  @override
  final String currentLayer;
  @override
  final Set<String> invisibleLayers;
  DocumentLoadSuccess(
    super.data, {
    super.page,
    required super.fileSystem,
    required super.windowCubit,
    super.assetService,
    required super.pageName,
    super.metadata,
    super.info,
    AssetLocation? location,
    super.absolute = false,
    this.storageType = StorageType.local,
    required super.networkingService,
    super.embedding,
    required super.cameraViewport,
    required super.viewOption,
    required super.saved,
    String? currentAreaName,
    this.currentCollection = '',
    String? currentLayer,
    this.invisibleLayers = const {},
  }) : currentAreaName =
           currentAreaName ??
           (page ?? data.getPage(pageName))?.areas
               .firstWhereOrNull((e) => e.isInitial)
               ?.name ??
           '',
       currentLayer =
           currentLayer ??
           (page ?? data.getPage(pageName))?.layers.lastOrNull?.id ??
           createUniqueId(),
       super(location: location ?? const AssetLocation(path: ''));

  @override
  List<Object?> get props => [
    invisibleLayers,
    data,
    info,
    page,
    pageName,
    metadata,
    currentCollection,
    currentAreaName,
    settingsCubit,
    currentLayer,
  ];

  @override
  Area? get currentArea {
    return page.getAreaByName(currentAreaName);
  }

  DocumentLoadSuccess copyWith({
    NoteData? data,
    DocumentPage? page,
    String? pageName,
    FileMetadata? metadata,
    DocumentInfo? info,
    bool? editMode,
    String? currentLayer,
    String? currentCollection,
    String? currentAreaName,
    Set<String>? invisibleLayers,
  }) => DocumentLoadSuccess(
    data ?? this.data,
    assetService: assetService,
    page: page ?? this.page,
    pageName: pageName ?? this.pageName,
    metadata: metadata ?? this.metadata,
    info: info ?? this.info,
    invisibleLayers: invisibleLayers ?? this.invisibleLayers,
    currentLayer: currentLayer ?? this.currentLayer,
    currentCollection: currentCollection ?? this.currentCollection,
    currentAreaName: currentAreaName ?? this.currentAreaName,
    fileSystem: fileSystem,
    windowCubit: windowCubit,
    location: location,
    absolute: absolute,
    saved: saved,
    networkingService: networkingService,
    embedding: embedding,
    cameraViewport: cameraViewport,
    viewOption: viewOption,
  );

  bool isLayerVisible(String? layer) => !invisibleLayers.contains(layer);

  bool hasAutosave() =>
      settingsCubit.state.autosave &&
      (networkingService.isActive ||
          !(embedding?.save ?? true) ||
          (!kIsWeb &&
              !absolute &&
              (location.isEmpty || (location.fileType?.isNote() ?? false)) &&
              (location.remote.isEmpty ||
                  (settingsCubit
                          .getRemote(location.remote)
                          ?.hasDocumentCached(location.path) ??
                      false))));

  AreaPreset get areaPreset =>
      AreaPreset(name: pageName, area: cameraViewport.toArea(), page: pageName);

  DocumentLayer getLayer() => page.getLayer(currentLayer);

  DocumentPage mapLayer(DocumentLayer Function(DocumentLayer) mapper) =>
      page.mapLayer(currentLayer, mapper);
}

class DocumentPresentationState extends DocumentLoaded {
  final DocumentLoadSuccess oldState;
  final int frame;
  final AnimationTrack track;
  final PresentationStateHandler handler;
  final bool fullScreen;

  DocumentPresentationState(
    DocumentBloc bloc,
    this.oldState,
    this.track,
    this.fullScreen, {
    this.frame = 0,
    super.metadata,
    super.page,
    required super.fileSystem,
    required super.windowCubit,
    required super.pageName,
    required super.assetService,
    required super.networkingService,
    super.embedding,
    required super.location,
    required super.absolute,
    required super.saved,
    required super.cameraViewport,
    required super.viewOption,
  }) : handler = PresentationStateHandler(track, bloc),
       super(oldState.data);

  DocumentPresentationState.withHandler(
    this.handler,
    this.oldState,
    this.track,
    this.fullScreen, {
    this.frame = 0,
    super.metadata,
    super.page,
    required super.fileSystem,
    required super.windowCubit,
    required super.pageName,
    required super.assetService,
    required super.networkingService,
    super.embedding,
    required super.location,
    required super.absolute,
    required super.saved,
    required super.cameraViewport,
    required super.viewOption,
  }) : super(oldState.data);

  @override
  List<Object?> get props => [oldState, frame, track];

  @override
  NoteData get data => oldState.data;

  DocumentPresentationState copyWith({int? frame}) =>
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
        networkingService: networkingService,
        embedding: embedding,
        location: location,
        absolute: absolute,
        saved: saved,
        cameraViewport: cameraViewport,
        viewOption: viewOption,
      );
}
