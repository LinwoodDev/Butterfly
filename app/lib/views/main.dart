import 'dart:async';
import 'dart:ui';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/api/close.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/export.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/views/app_bar.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/views/toolbar/view.dart';
import 'package:butterfly/views/edit.dart';
import 'package:butterfly/views/error.dart';
import 'package:butterfly/views/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../actions/color_palette.dart';
import '../models/viewport.dart';
import '../services/asset.dart';
import '../api/changes.dart';
import 'pen_only_toggle.dart';
import 'view.dart';
import 'zoom.dart';

class ProjectPage extends StatefulWidget {
  final bool absolute;
  final AssetLocation? location;
  final Embedding? embedding;
  final String type;
  final Object? data;
  final String? uri;

  const ProjectPage({
    super.key,
    this.location,
    this.embedding,
    this.type = '',
    this.data,
    this.uri,
    this.absolute = false,
  });

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectDocumentRuntime {
  final DocumentBloc bloc;
  final TransformCubit transformCubit;
  final EditorSessionCubit? editorSessionCubit;
  final EditorController editorController;
  final ImportService? importService;
  final ExportService? exportService;
  final Embedding? embedding;
  var _closed = false;

  _ProjectDocumentRuntime({
    required this.bloc,
    required this.transformCubit,
    this.editorSessionCubit,
    required this.editorController,
    this.importService,
    this.exportService,
    this.embedding,
  });

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    embedding?.handler?.unregister();
    if (!bloc.isClosed) {
      await bloc.close();
    }
    if (editorSessionCubit != null && !editorSessionCubit!.isClosed) {
      await editorSessionCubit!.close();
    }
  }
}

class _ProjectPageState extends State<ProjectPage> {
  _ProjectDocumentRuntime? _runtime;
  final SearchController _searchController = SearchController();
  late final CloseSubscription _closeSubscription;
  final GlobalKey _viewportKey = GlobalKey();
  int _loadGeneration = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    _closeSubscription = onPreventClose(context, _preventClose);
  }

  @override
  void didUpdateWidget(ProjectPage oldWidget) {
    if (oldWidget.location != widget.location ||
        oldWidget.absolute != widget.absolute ||
        oldWidget.type != widget.type ||
        !identical(oldWidget.data, widget.data) ||
        oldWidget.uri != widget.uri) {
      unawaited(_reloadDocumentState());
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _reloadDocumentState() async {
    await _disposeDocumentState();
    if (mounted) {
      unawaited(_load());
    }
  }

  Future<void> _disposeDocumentState() async {
    _loadGeneration++;
    final runtime = _runtime;
    _runtime = null;
    await runtime?.close();
  }

  Future<void> _load() async {
    final loadGeneration = ++_loadGeneration;
    bool isCurrentLoad() => mounted && loadGeneration == _loadGeneration;
    final settingsCubit = context.read<SettingsCubit>();
    final windowCubit = context.read<WindowCubit>();
    final fileSystem = context.read<ButterflyFileSystem>();
    var location = widget.location;
    final absolute = widget.absolute;
    final remote = settingsCubit.getRemote(location?.remote);
    final documentSystem = fileSystem.buildDocumentSystem(remote);
    final embedding = widget.embedding;

    if (embedding != null) {
      var language = embedding.language;
      if (language == 'system') {
        language = '';
      }
      if (language != 'user') {
        settingsCubit.changeLocaleTemporarily(language);
      }
    }
    final networkingService = NetworkingService();
    final pendingRenderers = <Renderer>[];
    final pendingBackgrounds = <Renderer>[];
    AssetService? pendingAssetService;
    TransformCubit? pendingTransformCubit;
    var runtimeCommitted = false;

    Future<void> disposePendingRuntime({
      bool closeNetworkingService = true,
    }) async {
      if (runtimeCommitted) {
        return;
      }
      final transformCubit = pendingTransformCubit;
      if (transformCubit != null && !transformCubit.isClosed) {
        await transformCubit.close();
      }
      pendingTransformCubit = null;
      final assetService = pendingAssetService;
      pendingAssetService = null;
      if (assetService != null) {
        await assetService.dispose();
      }
      for (final renderer in pendingRenderers) {
        renderer.dispose();
      }
      pendingRenderers.clear();
      for (final renderer in pendingBackgrounds) {
        renderer.dispose();
      }
      pendingBackgrounds.clear();
      if (closeNetworkingService && !networkingService.isClosed) {
        await networkingService.close();
      }
    }

    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    try {
      final globalImportService = ImportService(context);
      final fileType = AssetFileTypeHelper.fromFileExtension(
        location?.fileExtension,
      )?.name;
      NoteData? document;
      var data = widget.data;
      Uint8List? loadedDocumentBytes;
      final uri = Uri.tryParse(widget.uri ?? '');
      var type = widget.type.isEmpty ? (fileType ?? widget.type) : widget.type;
      if (widget.uri != null && uri != null) {
        final connectionTechnology = ConnectionTechnology.values.byNameOrNull(
          type,
        );
        data = await networkingService.createClient(uri, connectionTechnology);
        type = '';
      }
      final name = absolute ? location!.fileNameWithoutExtension : '';
      NoteData? defaultDocument;
      final defaultTemplate = settingsCubit.state.defaultTemplate;
      final template = await fileSystem.buildTemplateSystem().getDefaultFile(
        defaultTemplate,
      );
      if (template != null && mounted) {
        defaultDocument = template.createDocument(
          name: name,
          createdAt: DateTime.now(),
        );
      }
      defaultDocument ??= DocumentDefaults.createDocument(name: name);
      bool failedToLoad = false;
      if (data != null) {
        if (data is Uint8List) {
          loadedDocumentBytes = data;
        } else if (data is NoteFile) {
          loadedDocumentBytes = data.data;
        }
        document ??= await globalImportService
            .load(type: type, data: data, document: defaultDocument)
            .then((e) => e?.export());
        if (document == null) {
          failedToLoad = true;
        }
      }
      if (location != null &&
          location.path.isNotEmpty &&
          document == null &&
          !failedToLoad) {
        if (!absolute) {
          final asset = await documentSystem.getAsset(location.path);
          if (!isCurrentLoad()) {
            await disposePendingRuntime();
            return;
          }
          if (asset is FileSystemFile<NoteFile>) {
            loadedDocumentBytes = asset.data?.data;
            final NoteData? noteData = await globalImportService
                .load(
                  document: defaultDocument,
                  type: widget.type.isEmpty
                      ? (fileType ?? widget.type)
                      : widget.type,
                  data: asset.data,
                )
                .then((e) => e?.export());
            if (noteData != null) {
              document = await checkFileChanges(context, noteData);
            } else {
              failedToLoad = true;
            }
          }
        } else {
          final data = await documentSystem.loadAbsolute(location.path);
          if (data != null) {
            loadedDocumentBytes = data;
            document = await globalImportService
                .load(
                  document: defaultDocument,
                  type: widget.type.isEmpty
                      ? (fileType ?? widget.type)
                      : widget.type,
                  data: data,
                )
                .then((e) => e?.export());
            if (document == null) {
              failedToLoad = true;
            }
          }
        }
      }
      if (!isCurrentLoad()) {
        await disposePendingRuntime();
        return;
      }
      if (failedToLoad) {
        final transformCubit = TransformCubit(pixelRatio);
        final editorController = EditorController(
          settingsCubit,
          transformCubit,
          CameraViewport.unbaked(),
          networkingService: networkingService,
        );
        final bloc = DocumentBloc.error(
          fileSystem,
          editorController,
          windowCubit,
          AppLocalizations.of(context).errorWhileImportingContent,
        );
        setState(() {
          _runtime = _ProjectDocumentRuntime(
            bloc: bloc,
            transformCubit: transformCubit,
            editorController: editorController,
            importService: ImportService(context, bloc: bloc),
            exportService: ExportService(context, bloc),
            embedding: embedding,
          );
        });
        runtimeCommitted = true;
        return;
      }
      var documentOpened = document != null;
      if (!documentOpened && !absolute) {
        location = null;
      }
      if (!isCurrentLoad()) {
        await disposePendingRuntime();
        return;
      }
      if (document == null) {
        final template =
            await fileSystem
                .buildTemplateSystem(remote)
                .getDefaultFile(defaultTemplate) ??
            await DocumentDefaults.createTemplate();
        document = template.createDocument(
          name: name,
          createdAt: DateTime.now(),
        );
      }
      location ??= AssetLocation(
        path: widget.location?.path ?? '',
        remote: remote?.identifier ?? '',
      );
      final pathKey = documentStatePathKeyOrNull(location);
      final contentHash = loadedDocumentBytes == null
          ? null
          : documentStateContentHash(loadedDocumentBytes);
      final documentStateSystem = fileSystem.buildDocumentStateSystem(remote);
      final restoredSession = await EditorSessionCubit.load(
        fileSystem: documentStateSystem,
        contentHash: contentHash,
        pathKey: pathKey,
        allowContentHash: loadedDocumentBytes != null,
      );
      final fallbackPageName = document.getPages(true).firstOrNull;
      final restoredPageName = restoredSession?.pageName;
      final pageName =
          restoredPageName != null &&
              document.getPages(true).contains(restoredPageName)
          ? restoredPageName
          : fallbackPageName;
      final page =
          document.getPage(pageName ?? '') ?? DocumentDefaults.createPage();
      final initialSession = EditorSessionCubit.buildInitial(
        restored: restoredSession,
        document: document,
        page: page,
        fallbackPageName: pageName,
        fallbackUtilities: settingsCubit.state.utilities,
        pathKey: pathKey,
        contentHash: contentHash,
      );
      final renderers = page.layers
          .expand(
            (layer) => layer.content.map(
              (element) => Renderer.fromInstance(element, layer.id),
            ),
          )
          .toList();
      final assetService = AssetService();
      final transformCubit = TransformCubit(pixelRatio);
      transformCubit.teleport(
        Offset(
          initialSession.camera.positionX,
          initialSession.camera.positionY,
        ),
        initialSession.camera.zoom,
      );
      final editorSessionCubit = EditorSessionCubit(
        fileSystem: documentStateSystem,
        transformCubit: transformCubit,
        initialState: initialSession,
        pathKey: pathKey,
        contentHash: contentHash,
      );
      pendingAssetService = assetService;
      pendingTransformCubit = transformCubit;
      pendingRenderers.addAll(renderers);
      await Future.wait(
        renderers.map(
          (e) async =>
              await e.setup(transformCubit, document!, assetService, page),
        ),
      );
      if (!isCurrentLoad()) {
        await disposePendingRuntime();
        return;
      }
      final backgrounds = page.backgrounds.map(Renderer.fromInstance).toList();
      pendingBackgrounds.addAll(backgrounds);
      await Future.wait(
        backgrounds.map(
          (e) async => e.setup(transformCubit, document!, assetService, page),
        ),
      );
      if (!isCurrentLoad()) {
        await disposePendingRuntime();
        return;
      }
      if (restoredSession == null) {
        transformCubit.teleportToWaypoint(page.getOriginWaypoint());
      }
      final editorController = EditorController(
        settingsCubit,
        transformCubit,
        CameraViewport.unbaked(
          backgrounds: backgrounds,
          unbakedElements: renderers,
          visibleElements: renderers,
          visibleUnbakedElements: renderers,
        ),
        embedding: embedding,
        networkingService: networkingService,
        editorSessionCubit: editorSessionCubit,
        absolute: absolute,
      );
      final bloc = DocumentBloc(
        fileSystem,
        editorController,
        windowCubit,
        document,
        location,
        assetService,
        page,
        pageName,
        false,
        initialSession.currentLayer.isEmpty
            ? null
            : initialSession.currentLayer,
        initialSession.currentCollection,
        initialSession.invisibleLayers,
      );
      final isImportedDocument =
          documentOpened && !(location.fileType?.isNote() ?? false);
      if (!absolute && isImportedDocument) {
        currentIndexCubit.setSaveState(saved: SaveState.unsaved);
      }
      networkingService.setup(bloc);
      setState(() {
        _runtime = _ProjectDocumentRuntime(
          bloc: bloc,
          transformCubit: transformCubit,
          editorSessionCubit: editorSessionCubit,
          editorController: editorController,
          importService: ImportService(context, bloc: bloc),
          exportService: ExportService(context, bloc),
          embedding: embedding,
        );
      });
      embedding?.handler?.register(context, bloc);
      runtimeCommitted = true;
      pendingAssetService = null;
      pendingTransformCubit = null;
      pendingRenderers.clear();
      pendingBackgrounds.clear();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      if (!isCurrentLoad()) {
        await disposePendingRuntime();
        return;
      }
      await disposePendingRuntime(closeNetworkingService: false);
      final transformCubit = TransformCubit(pixelRatio);
      final editorController = EditorController(
        settingsCubit,
        transformCubit,
        CameraViewport.unbaked(),
        networkingService: networkingService,
      );
      final bloc = DocumentBloc.error(
        fileSystem,
        editorController,
        windowCubit,
        e.toString(),
        stackTrace,
      );
      setState(() {
        _runtime = _ProjectDocumentRuntime(
          bloc: bloc,
          transformCubit: transformCubit,
          editorSessionCubit: null,
          editorController: editorController,
          embedding: embedding,
        );
      });
      runtimeCommitted = true;
    }
    WidgetsBinding.instance.scheduleFrameCallback((_) async {
      if (!isCurrentLoad()) return;
      _runtime?.bloc.load();
    });
  }

  @override
  void dispose() {
    _closeSubscription.dispose();
    unawaited(_disposeDocumentState());
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final runtime = _runtime;
    if (runtime == null) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }
    final padding = MediaQuery.paddingOf(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: runtime.bloc),
        BlocProvider.value(value: runtime.transformCubit),
        if (runtime.editorSessionCubit != null)
          BlocProvider.value(value: runtime.editorSessionCubit!),
        BlocProvider.value(value: runtime.editorController.rendererCubit),
        BlocProvider.value(value: runtime.editorController.toolCubit),
        BlocProvider.value(value: runtime.editorController.inputCubit),
        BlocProvider.value(value: runtime.editorController.saveCubit),
        BlocProvider.value(value: runtime.editorController.viewCubit),
      ],
      child: BlocBuilder<DocumentBloc, DocumentState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if (state is DocumentLoadFailure) {
            return ErrorPage(
              message: state.message,
              stackTrace: state.stackTrace,
            );
          }
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: runtime.editorController),
              RepositoryProvider.value(value: runtime.importService!),
              RepositoryProvider.value(value: runtime.exportService!),
            ],
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: BlocBuilder<WindowCubit, WindowState>(
                builder: (context, windowState) =>
                    BlocBuilder<EditorInputCubit, EditorInputState>(
                      buildWhen: (previous, current) =>
                          previous.hideUi != current.hideUi,
                      builder: (context, inputState) =>
                          BlocBuilder<DocumentSaveCubit, DocumentSaveState>(
                            buildWhen: (previous, current) =>
                                previous.embedding?.editable !=
                                    current.embedding?.editable ||
                                previous.embedding?.isInternal !=
                                    current.embedding?.isInternal,
                            builder: (context, saveState) =>
                                BlocBuilder<SettingsCubit, ButterflySettings>(
                                  buildWhen: (previous, current) =>
                                      previous.toolbarSize !=
                                          current.toolbarSize ||
                                      previous.isInline != current.isInline,
                                  builder: (context, settings) {
                                    final actions = _buildActions(context);

                                    return ListenableBuilder(
                                      listenable: keybinder,
                                      builder: (context, child) {
                                        final shortcuts = _buildShortcuts();
                                        return Actions(
                                          actions: actions,
                                          child: Shortcuts(
                                            shortcuts: shortcuts,
                                            child: child!,
                                          ),
                                        );
                                      },
                                      child: ClipRect(
                                        child: Focus(
                                          autofocus: true,
                                          skipTraversal: true,
                                          onFocusChange: (_) => false,
                                          child: Scaffold(
                                            appBar:
                                                state is DocumentPresentationState ||
                                                    windowState.fullScreen ||
                                                    inputState.hideUi !=
                                                        HideState.visible
                                                ? null
                                                : PadAppBar(
                                                    viewportKey: _viewportKey,
                                                    size: settings.toolbarSize,
                                                    searchController:
                                                        _searchController,
                                                    padding: padding,
                                                    direction:
                                                        Directionality.of(
                                                          context,
                                                        ),
                                                    inView:
                                                        saveState
                                                            .embedding
                                                            ?.isInternal ??
                                                        false,
                                                    showTools:
                                                        settings.isInline &&
                                                        saveState
                                                                .embedding
                                                                ?.editable !=
                                                            false,
                                                  ),
                                            body: const _MainBody(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  CloseRequest? _preventClose() {
    final saveState = _runtime?.editorController.saveCubit.state;
    return saveState?.saved == SaveState.saved
        ? null
        : CloseRequest(
            message: AppLocalizations.of(context).thereAreUnsavedChanges,
            onSave: _saveBeforeClose,
          );
  }

  Future<bool> _saveBeforeClose() async {
    final bloc = _runtime?.bloc;
    if (bloc == null || bloc.isClosed) return false;
    await bloc.save(force: true);
    return bloc.editorController.saveCubit.state.saved == SaveState.saved;
  }

  Map<Type, Action<Intent>> _buildActions(BuildContext context) {
    return <Type, Action<Intent>>{
      UndoIntent: UndoAction(context),
      RedoIntent: RedoAction(context),
      NewIntent: NewAction(context),
      SvgExportIntent: SvgExportAction(context),
      ImageExportIntent: ImageExportAction(context),
      PdfExportIntent: PdfExportAction(context),
      ExportIntent: ExportAction(context),
      SettingsIntent: SettingsAction(context),
      ColorPaletteIntent: ColorPaletteAction(context),
      BackgroundIntent: BackgroundAction(context),
      ChangePathIntent: ChangePathAction(context),
      SaveIntent: SaveAction(context),
      ChangeToolIntent: ChangeToolAction(context),
      PacksIntent: PacksAction(context),
      ExitIntent: ExitAction(context),
      FullScreenIntent: FullScreenAction(context),
      HideUIIntent: HideUIAction(context),
      NextIntent: NextAction(context),
      PreviousIntent: PreviousAction(context),
      NextPageIntent: NextPageAction(context),
      PreviousPageIntent: PreviousPageAction(context),
      TogglePresentationIntent: TogglePresentationAction(context),
      PasteIntent: PasteAction(context),
      SelectAllIntent: SelectAllAction(context),
      ZoomIntent: ZoomAction(context),
      SearchIntent: CallbackAction<SearchIntent>(
        onInvoke: (_) {
          if (_searchController.isOpen) {
            _searchController.closeView(null);
            return null;
          }
          _searchController.openView();
          return null;
        },
      ),
    };
  }

  Map<ShortcutActivator, Intent> _buildShortcuts() {
    var shortcuts = keybinder.getShortcuts();
    if (widget.embedding != null) {
      shortcuts = Map.from(shortcuts)
        ..removeWhere((key, intent) {
          return intent is ExportIntent ||
              intent is ImageExportIntent ||
              intent is PdfExportIntent ||
              intent is SvgExportIntent ||
              intent is SettingsIntent ||
              intent is ChangePathIntent ||
              intent is SaveIntent ||
              intent is PacksIntent ||
              intent is ZoomIntent ||
              intent is ChangeToolIntent;
        });
    }
    return shortcuts;
  }
}

class _MainBody extends StatelessWidget {
  const _MainBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          (previous is DocumentLoadSuccess &&
              current is! DocumentLoadSuccess) ||
          (previous is! DocumentLoadSuccess && current is DocumentLoadSuccess),
      builder: (context, state) => BlocBuilder<ToolCubit, ToolRuntimeState>(
        buildWhen: (previous, current) =>
            previous.pinned != current.pinned ||
            previous.selection != current.selection,
        builder: (context, toolState) =>
            BlocBuilder<EditorInputCubit, EditorInputState>(
              buildWhen: (previous, current) =>
                  previous.hideUi != current.hideUi,
              builder: (context, inputState) =>
                  BlocBuilder<DocumentSaveCubit, DocumentSaveState>(
                    buildWhen: (previous, current) =>
                        previous.embedding != current.embedding,
                    builder: (context, saveState) =>
                        BlocBuilder<WindowCubit, WindowState>(
                          builder: (context, windowState) =>
                              BlocBuilder<SettingsCubit, ButterflySettings>(
                                buildWhen: (previous, current) =>
                                    previous.toolbarPosition !=
                                        current.toolbarPosition ||
                                    previous.toolbarSize !=
                                        current.toolbarSize ||
                                    previous.toolbarRows !=
                                        current.toolbarRows ||
                                    previous.navigationRail !=
                                        current.navigationRail ||
                                    previous.navigatorPosition !=
                                        current.navigatorPosition ||
                                    previous.optionsPanelPosition !=
                                        current.optionsPanelPosition ||
                                    previous.zoomPosition !=
                                        current.zoomPosition ||
                                    previous.propertyPosition !=
                                        current.propertyPosition,
                                builder: (context, settings) {
                                  return LayoutBuilder(
                                    builder: (context, constraints) =>
                                        _buildLayout(
                                          context,
                                          constraints,
                                          state,
                                          toolState,
                                          inputState,
                                          saveState,
                                          windowState,
                                          settings,
                                        ),
                                  );
                                },
                              ),
                        ),
                  ),
            ),
      ),
    );
  }

  Widget _buildLayout(
    BuildContext context,
    BoxConstraints constraints,
    DocumentState state,
    ToolRuntimeState toolState,
    EditorInputState inputState,
    DocumentSaveState saveState,
    WindowState windowState,
    ButterflySettings settings,
  ) {
    // Use PlatformDispatcher as a workaround for MediaQuery.viewInsets not updating fast enough. See: https://stackoverflow.com/a/64473806
    final Iterable<FlutterView> windowViews = PlatformDispatcher.instance.views;
    final double bottomInset = windowViews.isEmpty
        ? 0
        : windowViews.first.viewInsets.bottom /
              windowViews.first.devicePixelRatio;
    final bool isMobile = constraints.maxWidth < LeapBreakpoints.compact;
    final bool isLarge =
        constraints.maxWidth >= LeapBreakpoints.expanded &&
        (constraints.maxHeight + bottomInset) >= 400;

    final toolbar = EditToolbar(
      isMobile: isMobile,
      centered: true,
      direction: settings.toolbarPosition.axis,
    );
    final navigatorRailEnabled =
        settings.navigationRail || saveState.embedding != null;
    final showNavigator =
        isLarge &&
        navigatorRailEnabled &&
        !windowState.fullScreen &&
        state is DocumentLoadSuccess &&
        inputState.hideUi == HideState.visible;

    return Stack(
      children: [
        const MainViewViewport(),
        _buildSelectionListener(context, toolState),
        SafeArea(
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              if (showNavigator &&
                  settings.navigatorPosition == NavigatorPosition.left)
                const NavigatorView(),
              if (settings.toolbarPosition == ToolbarPosition.left &&
                  !isMobile &&
                  inputState.hideUi == HideState.visible)
                toolbar,
              _buildCenterColumn(
                context,
                settings,
                windowState,
                inputState,
                isMobile,
                toolbar,
              ),
              if (settings.toolbarPosition == ToolbarPosition.right &&
                  inputState.hideUi == HideState.visible)
                toolbar,
              if (showNavigator &&
                  settings.navigatorPosition == NavigatorPosition.right)
                const NavigatorView(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionListener(
    BuildContext context,
    ToolRuntimeState toolState,
  ) {
    return Listener(
      behavior: toolState.pinned || toolState.selection == null
          ? HitTestBehavior.translucent
          : HitTestBehavior.opaque,
      onPointerUp: (details) {
        if (toolState.pinned) return;
        context.read<ToolCubit>().resetSelection();
      },
    );
  }

  Widget _buildCenterColumn(
    BuildContext context,
    ButterflySettings settings,
    WindowState windowState,
    EditorInputState inputState,
    bool isMobile,
    Widget toolbar,
  ) {
    final pos = settings.toolbarPosition;
    final optPos = settings.optionsPanelPosition;
    final showToolbar =
        (((windowState.fullScreen || settings.toolbarRows > 1) &&
                    pos == ToolbarPosition.inline ||
                pos == ToolbarPosition.top) &&
            !isMobile) &&
        inputState.hideUi == HideState.visible;
    final shareToolbarAndZoomEdge =
        !isMobile &&
        inputState.hideUi == HideState.visible &&
        _toolbarAndZoomShareVerticalEdge(settings);
    final combineTopToolbarAndZoom = showToolbar && shareToolbarAndZoomEdge;
    final combineBottomToolbarAndZoom =
        pos == ToolbarPosition.bottom && shareToolbarAndZoomEdge;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showToolbar)
            combineTopToolbarAndZoom
                ? _buildCombinedToolbarAndZoom(settings, toolbar)
                : toolbar,
          if (optPos == OptionsPanelPosition.top &&
              inputState.hideUi == HideState.visible)
            const ToolbarView(),
          Expanded(
            child: Stack(
              children: [
                _buildZoomAndTools(
                  context,
                  settings,
                  isMobile,
                  inputState,
                  hideZoomTools:
                      combineTopToolbarAndZoom || combineBottomToolbarAndZoom,
                ),
                Align(
                  alignment: switch (settings.propertyPosition) {
                    ZoomPosition.topRight => Alignment.topRight,
                    ZoomPosition.topLeft => Alignment.topLeft,
                    ZoomPosition.bottomRight => Alignment.bottomRight,
                    ZoomPosition.bottomLeft => Alignment.bottomLeft,
                  },
                  child: PropertyView(position: settings.propertyPosition),
                ),
              ],
            ),
          ),
          if (optPos == OptionsPanelPosition.bottom &&
              inputState.hideUi == HideState.visible)
            const ToolbarView(),
          if ((isMobile || pos == ToolbarPosition.bottom) &&
              inputState.hideUi == HideState.visible)
            combineBottomToolbarAndZoom
                ? _buildCombinedToolbarAndZoom(settings, toolbar)
                : toolbar,
        ],
      ),
    );
  }

  bool _toolbarAndZoomShareVerticalEdge(ButterflySettings settings) =>
      switch (settings.toolbarPosition) {
        ToolbarPosition.top =>
          settings.zoomPosition == ZoomPosition.topLeft ||
              settings.zoomPosition == ZoomPosition.topRight,
        ToolbarPosition.bottom =>
          settings.zoomPosition == ZoomPosition.bottomLeft ||
              settings.zoomPosition == ZoomPosition.bottomRight,
        _ => false,
      };

  Widget _buildCombinedToolbarAndZoom(
    ButterflySettings settings,
    Widget toolbar,
  ) {
    final isLeft =
        settings.zoomPosition == ZoomPosition.topLeft ||
        settings.zoomPosition == ZoomPosition.bottomLeft;
    final zoomTools = SizedBox(
      width: 400,
      child: _buildZoomToolsRow(settings, false),
    );
    final children = <Widget>[
      zoomTools,
      Expanded(child: Align(child: toolbar)),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        spacing: 8,
        children: isLeft ? children : children.reversed.toList(),
      ),
    );
  }

  Widget _buildZoomAndTools(
    BuildContext context,
    ButterflySettings settings,
    bool isMobile,
    EditorInputState inputState, {
    bool hideZoomTools = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: switch (settings.zoomPosition) {
          ZoomPosition.topRight => Alignment.topRight,
          ZoomPosition.topLeft => Alignment.topLeft,
          ZoomPosition.bottomRight => Alignment.bottomRight,
          ZoomPosition.bottomLeft => Alignment.bottomLeft,
        },
        child: SizedBox(
          width: isMobile ? 100 : 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: switch (settings.zoomPosition) {
              ZoomPosition.topRight ||
              ZoomPosition.bottomRight => CrossAxisAlignment.end,
              ZoomPosition.topLeft ||
              ZoomPosition.bottomLeft => CrossAxisAlignment.start,
            },
            children: [
              if (!hideZoomTools) _buildZoomToolsRow(settings, isMobile),
              if (inputState.hideUi == HideState.touch)
                FloatingActionButton.small(
                  tooltip: AppLocalizations.of(context).exit,
                  child: const Icon(PhosphorIconsLight.door),
                  onPressed: () {
                    context.read<EditorInputCubit>().exitHideUI();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZoomToolsRow(ButterflySettings settings, bool isMobile) {
    final isLeft =
        settings.zoomPosition == ZoomPosition.topLeft ||
        settings.zoomPosition == ZoomPosition.bottomLeft;
    final children = [
      const PenOnlyToggle(),
      if (settings.zoomEnabled) Flexible(child: ZoomView(isMobile: isMobile)),
    ];
    return Row(
      mainAxisAlignment: isLeft
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      spacing: 8,
      children: isLeft ? children.reversed.toList() : children,
    );
  }
}
