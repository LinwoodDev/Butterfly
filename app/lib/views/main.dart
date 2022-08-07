import 'dart:io';

import 'package:butterfly/actions/areas.dart';
import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/change_path.dart';
import 'package:butterfly/actions/color_palette.dart';
import 'package:butterfly/actions/edit_mode.dart';
import 'package:butterfly/actions/export.dart';
import 'package:butterfly/actions/image_export.dart';
import 'package:butterfly/actions/import.dart';
import 'package:butterfly/actions/insert.dart';
import 'package:butterfly/actions/layers.dart';
import 'package:butterfly/actions/new.dart';
import 'package:butterfly/actions/open.dart';
import 'package:butterfly/actions/pdf_export.dart';
import 'package:butterfly/actions/project.dart';
import 'package:butterfly/actions/redo.dart';
import 'package:butterfly/actions/save.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/actions/svg_export.dart';
import 'package:butterfly/actions/undo.dart';
import 'package:butterfly/actions/waypoints.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/introduction/app.dart';
import 'package:butterfly/dialogs/introduction/start.dart';
import 'package:butterfly/dialogs/introduction/update.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/views/app_bar.dart';
import 'package:butterfly/views/color.dart';
import 'package:butterfly/views/edit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import '../models/background.dart';
import 'view.dart';

bool isWindow() =>
    !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

class ProjectPage extends StatefulWidget {
  final AssetLocation? location;
  final Embedding? embedding;

  const ProjectPage({super.key, this.location, this.embedding});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: closeSinks
  DocumentBloc? _bloc;
  late CurrentIndexCubit _currentIndexCubit;
  TransformCubit? _transformCubit;
  final GlobalKey _viewportKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void didUpdateWidget(ProjectPage oldWidget) {
    if (oldWidget.location != widget.location) {
      _bloc?.close();
      _bloc = null;
      load();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> load() async {
    final settingsCubit = context.read<SettingsCubit>();
    final embedding = widget.embedding;
    if (embedding != null) {
      final document = AppDocument(createdAt: DateTime.now(), name: '');
      var language = embedding.language;
      if (language == 'system') {
        language = '';
      }
      if (language != 'user') {
        settingsCubit.changeLocaleTemporarily(language);
      }
      setState(() {
        _transformCubit = TransformCubit();
        _currentIndexCubit = CurrentIndexCubit(
            document, settingsCubit, _transformCubit!, embedding);
        _bloc = DocumentBloc(
          _currentIndexCubit,
          settingsCubit,
          document,
          widget.location ?? const AssetLocation(path: ''),
          BoxBackgroundRenderer(const BoxBackground()),
          [],
        );
        _bloc?.load();
        embedding.handler.register(_bloc!);
      });
      return;
    }
    RemoteStorage? remote;
    remote = widget.location != null
        ? settingsCubit.state.getRemote(widget.location!.remote)
        : settingsCubit.state.getDefaultRemote();
    final fileSystem = DocumentFileSystem.fromPlatform(remote: remote);
    final prefs = await SharedPreferences.getInstance();
    var documentOpened = false;
    AppDocument? document;
    if (widget.location != null) {
      documentOpened = true;
      await fileSystem.getAsset(widget.location!.path).then(
          (value) => document = value is AppDocumentFile ? value.load() : null);
    }
    if (document == null && prefs.containsKey('default_template')) {
      var template = await TemplateFileSystem.fromPlatform(remote: remote)
          .getTemplate(prefs.getString('default_template')!);
      if (template != null && mounted) {
        document = template.document.copyWith(
          name: await formatCurrentDateTime(
              context.read<SettingsCubit>().state.locale),
          createdAt: DateTime.now(),
        );
      }
    }
    if (mounted) {
      document ??= AppDocument(
          name: await formatCurrentDateTime(
              context.read<SettingsCubit>().state.locale),
          createdAt: DateTime.now(),
          palettes: ColorPalette.getMaterialPalette(context));
    }
    if (document != null) {
      final renderers =
          document!.content.map((e) => Renderer.fromInstance(e)).toList();
      await Future.wait(renderers.map((e) async => await e.setup(document!)));
      final background = Renderer.fromInstance(document!.background);
      await background.setup(document!);
      setState(() {
        _transformCubit = TransformCubit();
        _currentIndexCubit =
            CurrentIndexCubit(document!, settingsCubit, _transformCubit!, null);
        _bloc = DocumentBloc(
            _currentIndexCubit,
            settingsCubit,
            document!,
            widget.location ??
                AssetLocation(path: '', remote: remote?.identifier ?? ''),
            background,
            renderers);
        _bloc?.load();
      });
    }
    _showIntroduction(documentOpened);
  }

  Future<void> _showIntroduction([bool documentOpened = false]) async {
    final settingsCubit = context.read<SettingsCubit>();
    if (settingsCubit.isFirstStart()) {
      await showDialog(
        context: context,
        builder: (context) => const AppIntroductionDialog(),
      );
      await settingsCubit.updateLastVersion();
      await settingsCubit.save();
    } else if (await settingsCubit.hasNewerVersion()) {
      await showDialog(
          context: context,
          builder: (context) => const UpdateIntroductionDialog());
      await settingsCubit.updateLastVersion();
      await settingsCubit.save();
    }
    if (!documentOpened && settingsCubit.state.startEnabled) {
      await showDialog(
          context: context,
          builder: (context) => MultiBlocProvider(providers: [
                if (_bloc != null)
                  BlocProvider<DocumentBloc>.value(
                    value: _bloc!,
                  ),
                BlocProvider<TransformCubit>.value(
                  value: _transformCubit!,
                ),
                BlocProvider<SettingsCubit>.value(
                  value: settingsCubit,
                ),
                BlocProvider<CurrentIndexCubit>.value(
                  value: _currentIndexCubit,
                ),
              ], child: const StartIntroductionDialog()));
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.embedding?.handler.unregister();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) {
      return const Material(child: Center(child: CircularProgressIndicator()));
    }
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => _bloc!),
            BlocProvider(create: (_) => _transformCubit!),
            BlocProvider(create: (_) => _currentIndexCubit),
          ],
          child: Builder(builder: (context) {
            return Shortcuts(
              shortcuts: {
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
                    UndoIntent(context),
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyY):
                    RedoIntent(context),
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):
                    NewIntent(context, fromTemplate: false),
                LogicalKeySet(LogicalKeyboardKey.control,
                        LogicalKeyboardKey.shift, LogicalKeyboardKey.keyN):
                    NewIntent(context, fromTemplate: true),
                LogicalKeySet(LogicalKeyboardKey.tab): EditModeIntent(context),
                LogicalKeySet(
                    LogicalKeyboardKey.control,
                    LogicalKeyboardKey.shift,
                    LogicalKeyboardKey.keyP): WaypointsIntent(context),
                LogicalKeySet(
                    LogicalKeyboardKey.control,
                    LogicalKeyboardKey.alt,
                    LogicalKeyboardKey.shift,
                    LogicalKeyboardKey.keyS): ProjectIntent(context),
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyP):
                    ColorPaletteIntent(context),
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyB):
                    BackgroundIntent(context),
                LogicalKeySet(
                    LogicalKeyboardKey.control,
                    LogicalKeyboardKey.shift,
                    LogicalKeyboardKey.keyA): AreasIntent(context),
                LogicalKeySet(
                        LogicalKeyboardKey.control, LogicalKeyboardKey.keyL):
                    LayersIntent(context),
                LogicalKeySet(LogicalKeyboardKey.control,
                        LogicalKeyboardKey.alt, LogicalKeyboardKey.keyN):
                    InsertIntent(context, Offset.zero),
                if (widget.embedding == null) ...{
                  LogicalKeySet(
                          LogicalKeyboardKey.control, LogicalKeyboardKey.keyO):
                      OpenIntent(context),
                  LogicalKeySet(
                          LogicalKeyboardKey.control, LogicalKeyboardKey.keyI):
                      ImportIntent(context),
                  LogicalKeySet(
                          LogicalKeyboardKey.control, LogicalKeyboardKey.keyE):
                      ExportIntent(context),
                  LogicalKeySet(
                      LogicalKeyboardKey.control,
                      LogicalKeyboardKey.shift,
                      LogicalKeyboardKey.keyE): ImageExportIntent(context),
                  LogicalKeySet(
                      LogicalKeyboardKey.control,
                      LogicalKeyboardKey.alt,
                      LogicalKeyboardKey.shift,
                      LogicalKeyboardKey.keyE): PdfExportIntent(context),
                  LogicalKeySet(
                      LogicalKeyboardKey.control,
                      LogicalKeyboardKey.alt,
                      LogicalKeyboardKey.keyE): SvgExportIntent(context),
                  LogicalKeySet(
                      LogicalKeyboardKey.control,
                      LogicalKeyboardKey.alt,
                      LogicalKeyboardKey.keyS): SettingsIntent(context),
                  LogicalKeySet(
                          LogicalKeyboardKey.alt, LogicalKeyboardKey.keyS):
                      ChangePathIntent(context),
                  LogicalKeySet(
                          LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
                      SaveIntent(context),
                },
              },
              child: Actions(
                  actions: <Type, Action<Intent>>{
                    UndoIntent: UndoAction(),
                    RedoIntent: RedoAction(),
                    NewIntent: NewAction(),
                    OpenIntent: OpenAction(),
                    ImportIntent: ImportAction(),
                    SvgExportIntent: SvgExportAction(),
                    ImageExportIntent: ImageExportAction(),
                    PdfExportIntent: PdfExportAction(),
                    ExportIntent: ExportAction(),
                    EditModeIntent: EditModeAction(),
                    SettingsIntent: SettingsAction(),
                    ProjectIntent: ProjectAction(),
                    WaypointsIntent: WaypointsAction(),
                    AreasIntent: AreasAction(),
                    ColorPaletteIntent: ColorPaletteAction(),
                    BackgroundIntent: BackgroundAction(),
                    LayersIntent: LayersAction(),
                    InsertIntent: InsertAction(),
                    ChangePathIntent: ChangePathAction(),
                    SaveIntent: SaveAction(),
                  },
                  child: SafeArea(
                    child: ClipRect(
                      child: Builder(builder: (context) {
                        PreferredSizeWidget appBar = PadAppBar(
                          viewportKey: _viewportKey,
                        );
                        return Focus(
                            autofocus: true,
                            child: FocusScope(
                              child: Scaffold(
                                  appBar: appBar,
                                  body: LayoutBuilder(
                                      builder: (context, constraints) {
                                    final isMobile =
                                        MediaQuery.of(context).size.width < 800;
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                              key: _viewportKey,
                                              child: Stack(
                                                children: [
                                                  const MainViewViewport(),
                                                  Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        ColorView(),
                                                      ]),
                                                ],
                                              )),
                                          if (isMobile)
                                            Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: EditToolbar(
                                                        isMobile: isMobile))),
                                        ]);
                                  })),
                            ));
                      }),
                    ),
                  )),
            );
          })),
    );
  }
}

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> with WindowListener {
  bool maximized = false, alwaysOnTop = false, fullScreen = false;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
    updateStates();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> updateStates() async {
    final nextMaximized = await windowManager.isMaximized();
    final nextAlwaysOnTop = await windowManager.isAlwaysOnTop();
    final nextFullScreen = await windowManager.isFullScreen();
    if (mounted) {
      setState(() {
        maximized = nextMaximized;
        alwaysOnTop = nextAlwaysOnTop;
        fullScreen = nextFullScreen;
      });
    }
  }

  @override
  void onWindowUnmaximize() {
    setState(() => maximized = false);
  }

  @override
  void onWindowMaximize() {
    setState(() => maximized = true);
  }

  @override
  void onWindowEnterFullScreen() {
    setState(() => fullScreen = true);
  }

  @override
  void onWindowLeaveFullScreen() {
    setState(() => fullScreen = false);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.nativeWindowTitleBar != current.nativeWindowTitleBar,
        builder: (context, settings) {
          if (!kIsWeb && isWindow() && !settings.nativeWindowTitleBar) {
            return LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!fullScreen)
                      IconButton(
                        icon: Icon(alwaysOnTop
                            ? PhosphorIcons.pushPinFill
                            : PhosphorIcons.pushPinLight),
                        tooltip: alwaysOnTop
                            ? AppLocalizations.of(context)!.exitAlwaysOnTop
                            : AppLocalizations.of(context)!.alwaysOnTop,
                        onPressed: () async {
                          await windowManager.setAlwaysOnTop(!alwaysOnTop);
                          setState(() => alwaysOnTop = !alwaysOnTop);
                        },
                      ),
                    IconButton(
                      icon: Icon(fullScreen
                          ? PhosphorIcons.arrowsInLight
                          : PhosphorIcons.arrowsOutLight),
                      tooltip: fullScreen
                          ? AppLocalizations.of(context)!.exitFullScreen
                          : AppLocalizations.of(context)!.enterFullScreen,
                      onPressed: () async {
                        setState(() => fullScreen = !fullScreen);
                        await windowManager.setFullScreen(fullScreen);
                      },
                    ),
                    if (!fullScreen) ...[
                      const VerticalDivider(),
                      IconButton(
                        icon: const Icon(PhosphorIcons.minusLight),
                        tooltip: AppLocalizations.of(context)!.minimize,
                        iconSize: 16,
                        splashRadius: 20,
                        onPressed: () => windowManager.minimize(),
                      ),
                      IconButton(
                        icon: Icon(PhosphorIcons.squareLight,
                            size: maximized ? 14 : 20),
                        tooltip: maximized
                            ? AppLocalizations.of(context)!.restore
                            : AppLocalizations.of(context)!.maximize,
                        iconSize: 16,
                        splashRadius: 20,
                        onPressed: () async => await windowManager.isMaximized()
                            ? windowManager.unmaximize()
                            : windowManager.maximize(),
                      ),
                      IconButton(
                        icon: const Icon(PhosphorIcons.xLight),
                        tooltip: AppLocalizations.of(context)!.close,
                        hoverColor: Colors.red,
                        iconSize: 16,
                        splashRadius: 20,
                        onPressed: () => windowManager.close(),
                      )
                    ]
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
