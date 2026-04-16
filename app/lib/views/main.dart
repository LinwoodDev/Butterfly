import 'dart:async';
import 'dart:ui';

import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/api/close.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/helpers/tool_defaults.dart';
import 'package:butterfly/models/defaults.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../actions/color_palette.dart';
import '../helpers/pdf_direct.dart';
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
  final String? sourceUri;

  const ProjectPage({
    super.key,
    this.location,
    this.embedding,
    this.type = '',
    this.data,
    this.uri,
    this.sourceUri,
    this.absolute = false,
  });

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  DocumentBloc? _bloc;
  TransformCubit? _transformCubit;
  CurrentIndexCubit? _currentIndexCubit;
  ImportService? _importService;
  ExportService? _exportService;
  final SearchController _searchController = SearchController();
  late final CloseSubscription _closeSubscription;
  final GlobalKey _viewportKey = GlobalKey();
  bool _allowNextPop = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
    _closeSubscription = onPreventClose(context, _preventClose);
  }

  @override
  void didUpdateWidget(ProjectPage oldWidget) {
    if (oldWidget.location != widget.location) {
      _bloc?.close();
      _bloc = null;
      _load();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _load() async {
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
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    try {
      final globalImportService = ImportService(context);
      final fileType = AssetFileTypeHelper.fromFileExtension(
        location?.fileExtension,
      )?.name;
      final directPdfEnabled = settingsCubit.state.pdfDirectEditEnabled;
      NoteData? document;
      var data = widget.data;
      final uri = Uri.tryParse(widget.uri ?? '');
      var type = widget.type.isEmpty ? (fileType ?? widget.type) : widget.type;
      final sourceUri = widget.sourceUri;
      bool isDirectPdfRequested(String value) {
        final normalized = value.toLowerCase();
        return directPdfEnabled &&
            (normalized == AssetFileType.pdf.name ||
                AssetFileType.pdf.isMimeType(normalized) ||
                AssetFileType.pdf.getFileExtensions().contains(normalized));
      }

      Uint8List? readRawBytes(Object? source) {
        if (source is Uint8List) return source;
        if (source is FileSystemFile<NoteFile>) {
          return source.data?.data;
        }
        if (source is FileSystemFile<NoteData>) {
          return source.data?.exportAsBytes();
        }
        if (source is NoteFile) return source.data;
        if (source is List) return Uint8List.fromList(List<int>.from(source));
        return null;
      }

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
        defaultDocument = settingsCubit.state.applyGlobalToolDefaultsToDocument(
          template.createDocument(name: name, createdAt: DateTime.now()),
        );
      }
      defaultDocument ??= settingsCubit.state.applyGlobalToolDefaultsToDocument(
        DocumentDefaults.createDocument(name: name),
      );
      bool failedToLoad = false;
      if (data != null) {
        if (isDirectPdfRequested(type)) {
          final bytes = readRawBytes(data);
          if (bytes != null) {
            document = await globalImportService
                .importPdfDirect(
                  bytes,
                  name: name,
                  sourceAbsolute: absolute,
                  sourceUri: sourceUri,
                )
                .then((e) => e?.export());
          }
        } else {
          document ??= await globalImportService
              .load(type: type, data: data, document: defaultDocument)
              .then((e) => e?.export());
        }
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
          if (!mounted) return;
          if (asset is FileSystemFile<NoteFile>) {
            final requestedType = widget.type.isEmpty
                ? (fileType ?? widget.type)
                : widget.type;
            final NoteData? noteData = isDirectPdfRequested(requestedType)
                ? await globalImportService
                      .importPdfDirect(
                        asset.data?.data ?? Uint8List(0),
                        name: name,
                        sourceAbsolute: false,
                        sourceUri: sourceUri,
                      )
                      .then((e) => e?.export())
                : await globalImportService
                      .load(
                        document: defaultDocument,
                        type: requestedType,
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
            final requestedType = widget.type.isEmpty
                ? (fileType ?? widget.type)
                : widget.type;
            document = isDirectPdfRequested(requestedType)
                ? await globalImportService
                      .importPdfDirect(data, name: name, sourceAbsolute: true)
                      .then(
                        (e) => e?.export(),
                      )
                : await globalImportService
                      .load(
                        document: defaultDocument,
                        type: requestedType,
                        data: data,
                      )
                      .then((e) => e?.export());
            if (document == null) {
              failedToLoad = true;
            }
          }
        }
      }
      if (!mounted) return;
      if (failedToLoad) {
        setState(() {
          _transformCubit = TransformCubit(pixelRatio);
          _currentIndexCubit = CurrentIndexCubit(
            settingsCubit,
            _transformCubit!,
            CameraViewport.unbaked(),
            networkingService: networkingService,
          );
          _bloc = DocumentBloc.error(
            fileSystem,
            windowCubit,
            AppLocalizations.of(context).errorWhileImportingContent,
          );
          _importService = ImportService(context, bloc: _bloc);
          _exportService = ExportService(context, _bloc);
        });
        return;
      }
      var documentOpened = document != null;
      if (!documentOpened && !absolute) {
        location = null;
      }
      if (documentOpened) {
        document = settingsCubit.state.applyGlobalToolDefaultsToDocument(
          document,
        );
      }
      if (!mounted) {
        return;
      }
      if (document == null) {
        final template =
            await fileSystem
                .buildTemplateSystem(remote)
                .getDefaultFile(defaultTemplate) ??
            await DocumentDefaults.createTemplate();
        document = settingsCubit.state.applyGlobalToolDefaultsToDocument(
          template.createDocument(name: name, createdAt: DateTime.now()),
        );
      }
      final pageName = document.getPages(true).firstOrNull;
      final page =
          document.getPage(pageName ?? '') ?? DocumentDefaults.createPage();
      final renderers = page.content
          .map((e) => Renderer.fromInstance(e))
          .toList();
      final assetService = AssetService();
      final transformCubit = TransformCubit(pixelRatio);
      final isDirectPdfSession =
          document.getInfo()?.extra[kPdfDirectEditSessionKey] == true;
      await Future.wait(
        renderers.map(
          (e) async =>
              await e.setup(transformCubit, document!, assetService, page),
        ),
      );
      final backgrounds = page.backgrounds.map(Renderer.fromInstance).toList();
      await Future.wait(
        backgrounds.map(
          (e) async => e.setup(transformCubit, document!, assetService, page),
        ),
      );
      location ??= AssetLocation(
        path: widget.location?.path ?? '',
        remote: remote?.identifier ?? '',
      );
      final initialArea = page.areas.where((area) => area.isInitial).firstOrNull;
      setState(() {
        _transformCubit = transformCubit;
        if (isDirectPdfSession && initialArea != null) {
          _transformCubit?.centerToArea(
            initialArea,
            MediaQuery.sizeOf(context),
            1,
          );
        } else {
          _transformCubit?.teleportToWaypoint(page.getOriginWaypoint());
        }
        _currentIndexCubit = CurrentIndexCubit(
          settingsCubit,
          _transformCubit!,
          CameraViewport.unbaked(backgrounds: backgrounds),
          embedding: embedding,
          networkingService: networkingService,
          absolute: absolute && !isDirectPdfSession,
        );
        _bloc = DocumentBloc(
          fileSystem,
          _currentIndexCubit!,
          windowCubit,
          document!,
          location!,
          renderers,
          assetService,
          page,
          pageName,
        );
        networkingService.setup(_bloc!);
        _importService = ImportService(context, bloc: _bloc);
        _exportService = ExportService(context, _bloc);
      });
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
      }
      if (!mounted) return;
      setState(() {
        _transformCubit = TransformCubit(pixelRatio);
        _currentIndexCubit = CurrentIndexCubit(
          settingsCubit,
          _transformCubit!,
          CameraViewport.unbaked(),
          networkingService: networkingService,
        );
        _bloc = DocumentBloc.error(
          fileSystem,
          windowCubit,
          e.toString(),
          stackTrace,
        );
      });
    }
    WidgetsBinding.instance.scheduleFrameCallback((_) async {
      _bloc?.load();
    });
  }

  @override
  void dispose() {
    widget.embedding?.handler?.unregister();
    _closeSubscription.dispose();
    _bloc?.close();
    _transformCubit?.close();
    _currentIndexCubit?.close();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _saveDirectPdfOnExitIfNeeded() async {
    final bloc = _bloc;
    final state = bloc?.state;
    if (bloc == null || state is! DocumentLoadSuccess) return;
    if (shouldForceDirectPdfSaveOnExit(state)) {
      await bloc.save(force: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }
    final padding = MediaQuery.paddingOf(context);
    return PopScope<Object?>(
      canPop: _allowNextPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop || _allowNextPop) return;
        await _saveDirectPdfOnExitIfNeeded();
        if (!mounted) return;
        final navigator = Navigator.of(context);
        if (navigator.canPop()) {
          setState(() {
            _allowNextPop = true;
          });
          await Future<void>.delayed(Duration.zero);
          if (mounted) {
            navigator.pop(result);
          }
          return;
        }
        if (widget.sourceUri != null) {
          await SystemNavigator.pop();
          return;
        }
        GoRouter.of(context).go('/');
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _bloc!),
          BlocProvider.value(value: _transformCubit!),
          BlocProvider.value(value: _currentIndexCubit!),
        ],
        child: BlocBuilder<DocumentBloc, DocumentState>(
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType ||
              previous.embedding?.editable != current.embedding?.editable,
          builder: (context, state) {
            if (state is DocumentLoadFailure) {
              return ErrorPage(
                message: state.message,
                stackTrace: state.stackTrace,
              );
            }
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider.value(value: _importService!),
                RepositoryProvider.value(value: _exportService!),
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
                      BlocBuilder<CurrentIndexCubit, CurrentIndex>(
                        buildWhen: (previous, current) =>
                            previous.hideUi != current.hideUi,
                        builder: (context, currentIndex) =>
                            BlocBuilder<SettingsCubit, ButterflySettings>(
                              buildWhen: (previous, current) =>
                                  previous.toolbarSize != current.toolbarSize ||
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
                                            state
                                                    is DocumentPresentationState ||
                                                windowState.fullScreen ||
                                                currentIndex.hideUi !=
                                                    HideState.visible
                                            ? null
                                            : PadAppBar(
                                                viewportKey: _viewportKey,
                                                size: settings.toolbarSize,
                                                searchController:
                                                    _searchController,
                                                padding: padding,
                                                direction: Directionality.of(
                                                  context,
                                                ),
                                                inView:
                                                    state
                                                        .embedding
                                                        ?.isInternal ??
                                                    false,
                                                showTools:
                                                    settings.isInline &&
                                                    state.embedding?.editable !=
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
            );
          },
        ),
      ),
    );
  }

  String? _preventClose() {
    final currentIndex = _currentIndexCubit?.state;
    return currentIndex?.saved == SaveState.saved
        ? null
        : AppLocalizations.of(context).thereAreUnsavedChanges;
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
      builder: (context, state) => BlocBuilder<CurrentIndexCubit, CurrentIndex>(
        buildWhen: (previous, current) =>
            previous.pinned != current.pinned ||
            previous.selection != current.selection ||
            previous.hideUi != current.hideUi,
        builder: (context, currentIndex) =>
            BlocBuilder<WindowCubit, WindowState>(
              builder: (context, windowState) =>
                  BlocBuilder<SettingsCubit, ButterflySettings>(
                    buildWhen: (previous, current) =>
                        previous.toolbarPosition != current.toolbarPosition ||
                        previous.toolbarSize != current.toolbarSize ||
                        previous.toolbarRows != current.toolbarRows ||
                        previous.navigationRail != current.navigationRail ||
                        previous.navigatorPosition !=
                            current.navigatorPosition ||
                        previous.optionsPanelPosition !=
                            current.optionsPanelPosition ||
                        previous.zoomPosition != current.zoomPosition,
                    builder: (context, settings) {
                      return LayoutBuilder(
                        builder: (context, constraints) => _buildLayout(
                          context,
                          constraints,
                          state,
                          currentIndex,
                          windowState,
                          settings,
                        ),
                      );
                    },
                  ),
            ),
      ),
    );
  }

  Widget _buildLayout(
    BuildContext context,
    BoxConstraints constraints,
    DocumentState state,
    CurrentIndex currentIndex,
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
    final showNavigator =
        isLarge &&
        settings.navigationRail &&
        !windowState.fullScreen &&
        state is DocumentLoadSuccess &&
        currentIndex.hideUi == HideState.visible;

    return Stack(
      children: [
        const MainViewViewport(),
        _buildSelectionListener(context, currentIndex),
        SafeArea(
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              if (showNavigator &&
                  settings.navigatorPosition == NavigatorPosition.left)
                const NavigatorView(),
              if (settings.toolbarPosition == ToolbarPosition.left &&
                  !isMobile &&
                  currentIndex.hideUi == HideState.visible)
                toolbar,
              _buildCenterColumn(
                context,
                settings,
                windowState,
                currentIndex,
                isMobile,
                toolbar,
              ),
              if (settings.toolbarPosition == ToolbarPosition.right &&
                  currentIndex.hideUi == HideState.visible)
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
    CurrentIndex currentIndex,
  ) {
    return Listener(
      behavior: currentIndex.pinned || currentIndex.selection == null
          ? HitTestBehavior.translucent
          : HitTestBehavior.opaque,
      onPointerUp: (details) {
        if (currentIndex.pinned) return;
        context.read<CurrentIndexCubit>().resetSelection();
      },
    );
  }

  Widget _buildCenterColumn(
    BuildContext context,
    ButterflySettings settings,
    WindowState windowState,
    CurrentIndex currentIndex,
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
        currentIndex.hideUi == HideState.visible;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showToolbar) toolbar,
          if (optPos == OptionsPanelPosition.top &&
              currentIndex.hideUi == HideState.visible)
            const ToolbarView(),
          Expanded(
            child: Stack(
              children: [
                _buildZoomAndTools(context, settings, isMobile, currentIndex),
                const Align(
                  alignment: Alignment.topRight,
                  child: PropertyView(),
                ),
              ],
            ),
          ),
          if (optPos == OptionsPanelPosition.bottom &&
              currentIndex.hideUi == HideState.visible)
            const ToolbarView(),
          if ((isMobile || pos == ToolbarPosition.bottom) &&
              currentIndex.hideUi == HideState.visible)
            toolbar,
        ],
      ),
    );
  }

  Widget _buildZoomAndTools(
    BuildContext context,
    ButterflySettings settings,
    bool isMobile,
    CurrentIndex currentIndex,
  ) {
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
              Builder(
                builder: (context) {
                  final isLeft =
                      settings.zoomPosition == ZoomPosition.topLeft ||
                      settings.zoomPosition == ZoomPosition.bottomLeft;
                  final children = [
                    const PenOnlyToggle(),
                    Flexible(child: ZoomView(isMobile: isMobile)),
                  ];
                  return Row(
                    mainAxisAlignment: isLeft
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    spacing: 8,
                    children: isLeft ? children.reversed.toList() : children,
                  );
                },
              ),
              if (currentIndex.hideUi == HideState.touch)
                FloatingActionButton.small(
                  tooltip: AppLocalizations.of(context).exit,
                  child: const Icon(PhosphorIconsLight.door),
                  onPressed: () {
                    context.read<CurrentIndexCubit>().exitHideUI();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
