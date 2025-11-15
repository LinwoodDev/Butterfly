import 'dart:async';
import 'dart:ui';

import 'package:butterfly/api/close.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/embed/embedding.dart';
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
import 'package:butterfly/widgets/search.dart';
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

import '../actions/background.dart';
import '../actions/change_tool.dart';
import '../actions/change_path.dart';
import '../actions/color_palette.dart';
import '../actions/exit.dart';
import '../actions/export.dart';
import '../actions/full_screen.dart';
import '../actions/hide_ui.dart';
import '../actions/image_export.dart';
import '../actions/new.dart';
import '../actions/next.dart';
import '../actions/packs.dart';
import '../actions/paste.dart';
import '../actions/pdf_export.dart';
import '../actions/previous.dart';
import '../actions/redo.dart';
import '../actions/save.dart';
import '../actions/select.dart';
import '../actions/settings.dart';
import '../actions/svg_export.dart';
import '../actions/undo.dart';
import '../actions/zoom.dart';
import '../models/viewport.dart';
import '../services/asset.dart';
import '../api/changes.dart';
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

class _ProjectPageState extends State<ProjectPage> {
  DocumentBloc? _bloc;
  TransformCubit? _transformCubit;
  CurrentIndexCubit? _currentIndexCubit;
  ExternalStorage? _remote;
  ImportService? _importService;
  ExportService? _exportService;
  final SearchController _searchController = SearchController();
  late final CloseSubscription _closeSubscription;
  final GlobalKey _viewportKey = GlobalKey();
  final _actions = <Type, Action<Intent>>{
    UndoIntent: UndoAction(),
    RedoIntent: RedoAction(),
    NewIntent: NewAction(),
    SvgExportIntent: SvgExportAction(),
    ImageExportIntent: ImageExportAction(),
    PdfExportIntent: PdfExportAction(),
    ExportIntent: ExportAction(),
    SettingsIntent: SettingsAction(),
    ColorPaletteIntent: ColorPaletteAction(),
    BackgroundIntent: BackgroundAction(),
    ChangePathIntent: ChangePathAction(),
    SaveIntent: SaveAction(),
    ChangeToolIntent: ChangeToolAction(),
    PacksIntent: PacksAction(),
    ExitIntent: ExitAction(),
    FullScreenIntent: FullScreenAction(),
    HideUIIntent: HideUIAction(),
    NextIntent: NextAction(),
    PreviousIntent: PreviousAction(),
    PasteIntent: PasteAction(),
    SelectAllIntent: SelectAllAction(),
    ZoomIntent: ZoomAction(),
  };

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
    final documentSystem = fileSystem.buildDocumentSystem(_remote);
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
      var location = widget.location;
      final absolute = widget.absolute;
      _remote = location != null
          ? settingsCubit.state.getRemote(location.remote)
          : settingsCubit.state.getDefaultRemote();
      final fileType = AssetFileTypeHelper.fromFileExtension(
        location?.fileExtension,
      )?.name;
      NoteData? document;
      var data = widget.data;
      final uri = Uri.tryParse(widget.uri ?? '');
      var type = widget.type.isEmpty ? (fileType ?? widget.type) : widget.type;
      if (widget.uri != null && uri != null) {
        final connectionTechnology = ConnectionTechnology.values.byNameOrNull(
          type,
        );
        data = await networkingService.createClient(uri, connectionTechnology);
        type = '';
      }
      if (data != null) {
        document ??= await globalImportService
            .load(type: type, data: data)
            .then((e) => e?.export());
        if (document == null) {
          GoRouter.of(context).pop();
        }
      }
      final name = absolute ? location!.fileNameWithoutExtension : '';
      NoteData? defaultDocument;
      final defaultTemplate = settingsCubit.state.defaultTemplate;
      if (document == null) {
        var template = await fileSystem
            .buildTemplateSystem(_remote)
            .getDefaultFile(defaultTemplate);
        if (template != null && mounted) {
          defaultDocument = template.createDocument(
            name: name,
            createdAt: DateTime.now(),
            disablePages: true,
          );
        }
      }
      defaultDocument ??= DocumentDefaults.createDocument(name: name);
      if (location != null && location.path.isNotEmpty && document == null) {
        if (!absolute) {
          final asset = await documentSystem.getAsset(location.path);
          if (!mounted) return;
          if (asset is FileSystemFile<NoteFile> &&
              location.fileType == AssetFileType.note) {
            final NoteData? noteData = await globalImportService
                .load(
                  type: widget.type.isEmpty
                      ? (fileType ?? widget.type)
                      : widget.type,
                  data: asset.data,
                )
                .then((e) => e?.export());
            if (noteData != null) {
              document = await checkFileChanges(context, noteData);
            }
          }
        } else {
          final data = await documentSystem.loadAbsolute(location.path);
          if (data != null) {
            document = await globalImportService
                .load(
                  document: defaultDocument,
                  type: widget.type.isEmpty
                      ? (fileType ?? widget.type)
                      : widget.type,
                  data: data,
                )
                .then((e) => e?.export());
          }
        }
      }
      if (!mounted) return;
      var documentOpened = document != null;
      if (!documentOpened && !absolute) {
        location = null;
      }
      if (!mounted) {
        return;
      }
      if (document == null) {
        final template =
            await fileSystem
                .buildTemplateSystem(_remote)
                .getDefaultFile(defaultTemplate) ??
            await DocumentDefaults.createTemplate();
        document = template.createDocument(
          name: name,
          createdAt: DateTime.now(),
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
        remote: _remote?.identifier ?? '',
      );
      setState(() {
        _transformCubit = transformCubit;
        _transformCubit?.teleportToWaypoint(page.getOriginWaypoint());
        _currentIndexCubit = CurrentIndexCubit(
          settingsCubit,
          _transformCubit!,
          CameraViewport.unbaked(backgrounds: backgrounds),
          embedding: embedding,
          networkingService: networkingService,
          absolute: absolute,
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

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }
    final padding = MediaQuery.paddingOf(context);
    return MultiBlocProvider(
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
                              return Actions(
                                actions: {
                                  ..._actions,
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
                                },
                                child: Shortcuts(
                                  shortcuts: {
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyZ,
                                    ): UndoIntent(
                                      context,
                                    ),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyY,
                                    ): RedoIntent(
                                      context,
                                    ),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyN,
                                    ): NewIntent(
                                      context,
                                      fromTemplate: false,
                                    ),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.shift,
                                      LogicalKeyboardKey.keyN,
                                    ): NewIntent(
                                      context,
                                      fromTemplate: true,
                                    ),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyB,
                                    ): BackgroundIntent(
                                      context,
                                    ),
                                    LogicalKeySet(LogicalKeyboardKey.escape):
                                        ExitIntent(context),
                                    LogicalKeySet(LogicalKeyboardKey.f11):
                                        FullScreenIntent(context),
                                    LogicalKeySet(LogicalKeyboardKey.f12):
                                        HideUIIntent(context),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.arrowRight,
                                    ): NextIntent(
                                      context,
                                    ),
                                    LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                                        PreviousIntent(context),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyA,
                                    ): SelectAllIntent(
                                      context,
                                    ),
                                    LogicalKeySet(
                                      LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyK,
                                    ): SearchIntent(),
                                    if (widget.embedding == null) ...{
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.keyE,
                                      ): ExportIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.shift,
                                        LogicalKeyboardKey.keyE,
                                      ): ExportIntent(
                                        context,
                                        isText: true,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.alt,
                                        LogicalKeyboardKey.shift,
                                        LogicalKeyboardKey.keyE,
                                      ): ImageExportIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.shift,
                                        LogicalKeyboardKey.keyP,
                                      ): PdfExportIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.alt,
                                        LogicalKeyboardKey.keyE,
                                      ): SvgExportIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.alt,
                                        LogicalKeyboardKey.keyS,
                                      ): SettingsIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.alt,
                                        LogicalKeyboardKey.keyS,
                                      ): ChangePathIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.keyS,
                                      ): SaveIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.alt,
                                        LogicalKeyboardKey.keyP,
                                      ): PacksIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.add,
                                      ): ZoomIntent(
                                        context,
                                      ),
                                      LogicalKeySet(
                                        LogicalKeyboardKey.control,
                                        LogicalKeyboardKey.minus,
                                      ): ZoomIntent(
                                        context,
                                        true,
                                      ),
                                      ...[
                                        LogicalKeyboardKey.digit1,
                                        LogicalKeyboardKey.digit2,
                                        LogicalKeyboardKey.digit3,
                                        LogicalKeyboardKey.digit4,
                                        LogicalKeyboardKey.digit5,
                                        LogicalKeyboardKey.digit6,
                                        LogicalKeyboardKey.digit7,
                                        LogicalKeyboardKey.digit8,
                                        LogicalKeyboardKey.digit9,
                                        LogicalKeyboardKey.digit0,
                                      ].asMap().map(
                                        (k, v) => MapEntry(
                                          LogicalKeySet(
                                            LogicalKeyboardKey.control,
                                            v,
                                          ),
                                          ChangeToolIntent(context, k),
                                        ),
                                      ),
                                    },
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
                                        body: Actions(
                                          actions: _actions,
                                          child: const _MainBody(),
                                        ),
                                      ),
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
    );
  }

  String? _preventClose() {
    final currentIndex = _currentIndexCubit?.state;
    return currentIndex?.saved == SaveState.saved
        ? null
        : AppLocalizations.of(context).thereAreUnsavedChanges;
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
        builder: (context, currentIndex) => BlocBuilder<WindowCubit, WindowState>(
          builder: (context, windowState) =>
              BlocBuilder<SettingsCubit, ButterflySettings>(
                buildWhen: (previous, current) =>
                    previous.toolbarPosition != current.toolbarPosition ||
                    previous.toolbarSize != current.toolbarSize ||
                    previous.toolbarRows != current.toolbarRows ||
                    previous.navigationRail != current.navigationRail ||
                    previous.navigatorPosition != current.navigatorPosition ||
                    previous.optionsPanelPosition !=
                        current.optionsPanelPosition,
                builder: (context, settings) {
                  final pos = settings.toolbarPosition;
                  final optPos = settings.optionsPanelPosition;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // Use PlatformDispatcher as a workaround for MediaQuery.viewInsets not updating fast enough. See: https://stackoverflow.com/a/64473806
                      final Iterable<FlutterView> windowViews =
                          PlatformDispatcher.instance.views;
                      final double bottomInset = windowViews.isEmpty
                          ? 0
                          : windowViews.first.viewInsets.bottom /
                                windowViews.first.devicePixelRatio;
                      final bool isMobile =
                          constraints.maxWidth < LeapBreakpoints.compact;
                      final bool isLarge =
                          constraints.maxWidth >= LeapBreakpoints.expanded &&
                          (constraints.maxHeight + bottomInset) >= 400;
                      final toolbar = EditToolbar(
                        isMobile: isMobile,
                        centered: true,
                        direction: pos.axis,
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
                          Listener(
                            behavior:
                                currentIndex.pinned ||
                                    currentIndex.selection == null
                                ? HitTestBehavior.translucent
                                : HitTestBehavior.opaque,
                            onPointerUp: (details) {
                              if (currentIndex.pinned) return;
                              context
                                  .read<CurrentIndexCubit>()
                                  .resetSelection();
                            },
                          ),
                          Row(
                            children: [
                              if (showNavigator &&
                                  settings.navigatorPosition ==
                                      NavigatorPosition.left)
                                const NavigatorView(),
                              if (pos == ToolbarPosition.left &&
                                  !isMobile &&
                                  currentIndex.hideUi == HideState.visible)
                                toolbar,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if ((((windowState.fullScreen ||
                                                        settings.toolbarRows >
                                                            1) &&
                                                    pos ==
                                                        ToolbarPosition
                                                            .inline ||
                                                pos == ToolbarPosition.top) &&
                                            !isMobile) &&
                                        currentIndex.hideUi ==
                                            HideState.visible)
                                      toolbar,
                                    if (optPos == OptionsPanelPosition.top &&
                                        currentIndex.hideUi ==
                                            HideState.visible)
                                      const ToolbarView(),
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: PropertyView(),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          width: isMobile ? 100 : 400,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              ZoomView(isMobile: isMobile),
                                              if (currentIndex.hideUi ==
                                                  HideState.touch)
                                                FloatingActionButton.small(
                                                  tooltip: AppLocalizations.of(
                                                    context,
                                                  ).exit,
                                                  child: const Icon(
                                                    PhosphorIconsLight.door,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                          CurrentIndexCubit
                                                        >()
                                                        .exitHideUI();
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (optPos == OptionsPanelPosition.bottom &&
                                        currentIndex.hideUi ==
                                            HideState.visible)
                                      const ToolbarView(),
                                    if ((isMobile ||
                                            pos == ToolbarPosition.bottom) &&
                                        currentIndex.hideUi ==
                                            HideState.visible)
                                      toolbar,
                                  ],
                                ),
                              ),
                              if (pos == ToolbarPosition.right &&
                                  currentIndex.hideUi == HideState.visible)
                                toolbar,
                              if (showNavigator &&
                                  settings.navigatorPosition ==
                                      NavigatorPosition.right)
                                const NavigatorView(),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
        ),
      ),
    );
  }
}
