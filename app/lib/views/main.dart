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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
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
          if (asset is FileSystemFile<NoteFile>) {
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
                              final actions = <Type, Action<Intent>>{
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

                              return ListenableBuilder(
                                listenable: keybinder,
                                builder: (context, child) {
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
                                                  state.embedding?.isInternal ??
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
          builder: (context, windowState) => BlocBuilder<SettingsCubit, ButterflySettings>(
            buildWhen: (previous, current) =>
                previous.toolbarPosition != current.toolbarPosition ||
                previous.toolbarSize != current.toolbarSize ||
                previous.toolbarRows != current.toolbarRows ||
                previous.navigationRail != current.navigationRail ||
                previous.navigatorPosition != current.navigatorPosition ||
                previous.optionsPanelPosition != current.optionsPanelPosition ||
                previous.zoomPosition != current.zoomPosition,
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
                          context.read<CurrentIndexCubit>().resetSelection();
                        },
                      ),
                      Row(
                        textDirection: TextDirection.ltr,
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
                                                    settings.toolbarRows > 1) &&
                                                pos == ToolbarPosition.inline ||
                                            pos == ToolbarPosition.top) &&
                                        !isMobile) &&
                                    currentIndex.hideUi == HideState.visible)
                                  toolbar,
                                if (optPos == OptionsPanelPosition.top &&
                                    currentIndex.hideUi == HideState.visible)
                                  const ToolbarView(),
                                Expanded(
                                  child: Stack(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topRight,
                                        child: PropertyView(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment:
                                              switch (settings.zoomPosition) {
                                                ZoomPosition.topRight =>
                                                  Alignment.topRight,
                                                ZoomPosition.topLeft =>
                                                  Alignment.topLeft,
                                                ZoomPosition.bottomRight =>
                                                  Alignment.bottomRight,
                                                ZoomPosition.bottomLeft =>
                                                  Alignment.bottomLeft,
                                              },
                                          child: SizedBox(
                                            width: isMobile ? 100 : 400,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  switch (settings
                                                      .zoomPosition) {
                                                    ZoomPosition.topRight ||
                                                    ZoomPosition.bottomRight =>
                                                      CrossAxisAlignment.end,
                                                    ZoomPosition.topLeft ||
                                                    ZoomPosition.bottomLeft =>
                                                      CrossAxisAlignment.start,
                                                  },
                                              children: [
                                                Builder(
                                                  builder: (context) {
                                                    final isLeft =
                                                        settings.zoomPosition ==
                                                            ZoomPosition
                                                                .topLeft ||
                                                        settings.zoomPosition ==
                                                            ZoomPosition
                                                                .bottomLeft;
                                                    final children = [
                                                      const PenOnlyToggle(),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: ZoomView(
                                                          isMobile: isMobile,
                                                        ),
                                                      ),
                                                    ];
                                                    return Row(
                                                      mainAxisAlignment: isLeft
                                                          ? MainAxisAlignment
                                                                .start
                                                          : MainAxisAlignment
                                                                .end,
                                                      children: isLeft
                                                          ? children.reversed
                                                                .toList()
                                                          : children,
                                                    );
                                                  },
                                                ),
                                                if (currentIndex.hideUi ==
                                                    HideState.touch)
                                                  FloatingActionButton.small(
                                                    tooltip:
                                                        AppLocalizations.of(
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
                                    ],
                                  ),
                                ),

                                if (optPos == OptionsPanelPosition.bottom &&
                                    currentIndex.hideUi == HideState.visible)
                                  const ToolbarView(),
                                if ((isMobile ||
                                        pos == ToolbarPosition.bottom) &&
                                    currentIndex.hideUi == HideState.visible)
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
