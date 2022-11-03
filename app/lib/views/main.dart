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
import 'package:butterfly/services/import.dart';
import 'package:butterfly/views/app_bar.dart';
import 'package:butterfly/views/color.dart';
import 'package:butterfly/views/edit.dart';
import 'package:butterfly/views/error.dart';
import 'package:butterfly/views/property.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../actions/change_painter.dart';
import '../models/background.dart';
import 'view.dart';

class ProjectPage extends StatefulWidget {
  final AssetLocation? location;
  final Embedding? embedding;
  final String type;
  final Object? data;

  const ProjectPage(
      {super.key, this.location, this.embedding, this.type = '', this.data});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: closeSinks
  DocumentBloc? _bloc;
  TransformCubit? _transformCubit;
  CurrentIndexCubit? _currentIndexCubit;
  late final ImportService _importService;
  final GlobalKey _viewportKey = GlobalKey();
  final actions = <Type, Action<Intent>>{
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
    ChangePainterIntent: ChangePainterAction(),
  };

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
      final document = AppDocument(
          createdAt: DateTime.now(),
          painters: createDefaultPainters(),
          palettes: ColorPalette.getMaterialPalette(context),
          name: '');
      var language = embedding.language;
      if (language == 'system') {
        language = '';
      }
      if (language != 'user') {
        settingsCubit.changeLocaleTemporarily(language);
      }
      setState(() {
        _transformCubit = TransformCubit();
        _currentIndexCubit =
            CurrentIndexCubit(settingsCubit, _transformCubit!, embedding);
        _bloc = DocumentBloc(
          _currentIndexCubit!,
          settingsCubit,
          document,
          widget.location ?? const AssetLocation(path: ''),
          BoxBackgroundRenderer(const BoxBackground()),
          [],
        );
        _importService = ImportService(_bloc!, context);
        _bloc?.load();
        embedding.handler.register(_bloc!);
      });
      return;
    }
    try {
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
        if (!widget.location!.absolute) {
          await fileSystem.getAsset(widget.location!.path).then((value) {
            if (value is! AppDocumentFile) {
              return document = null;
            }
            return document = value.getDocumentInfo()?.load();
          });
        }
      }
      if (!mounted) return;
      final name = (widget.location?.absolute ?? false)
          ? widget.location!.fileName
          : await formatCurrentDateTime(
              context.read<SettingsCubit>().state.locale);
      if (document == null && prefs.containsKey('default_template')) {
        var template = await TemplateFileSystem.fromPlatform(remote: remote)
            .getTemplate(prefs.getString('default_template')!);
        if (template != null && mounted) {
          document = template.document.copyWith(
            name: name,
            createdAt: DateTime.now(),
          );
        }
      }
      if (mounted) {
        document ??= AppDocument(
            name: name,
            createdAt: DateTime.now(),
            painters: createDefaultPainters(),
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
              CurrentIndexCubit(settingsCubit, _transformCubit!, null);
          _bloc = DocumentBloc(
              _currentIndexCubit!,
              settingsCubit,
              document!,
              widget.location ??
                  AssetLocation(path: '', remote: remote?.identifier ?? ''),
              background,
              renderers);
          _bloc?.load();
          _importService = ImportService(_bloc!, context);
          _importService.load(widget.type, widget.data);
        });
      }
      if (!(widget.location?.absolute ?? false)) {
        _showIntroduction(documentOpened);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        _transformCubit = TransformCubit();
        _currentIndexCubit =
            CurrentIndexCubit(settingsCubit, _transformCubit!, null);
        _bloc = DocumentBloc.error(e.toString());
      });
    }
  }

  Future<void> _showIntroduction([bool documentOpened = false]) async {
    final settingsCubit = context.read<SettingsCubit>();
    if (settingsCubit.isFirstStart()) {
      await showDialog<void>(
        context: context,
        builder: (context) => const AppIntroductionDialog(),
      );
      await settingsCubit.updateLastVersion();
      await settingsCubit.save();
    } else if (await settingsCubit.hasNewerVersion()) {
      await showDialog<void>(
          context: context,
          builder: (context) => const UpdateIntroductionDialog());
      await settingsCubit.updateLastVersion();
      await settingsCubit.save();
    }
    if (!documentOpened && settingsCubit.state.startEnabled) {
      await showDialog<void>(
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
                  value: _currentIndexCubit!,
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
    final state = _bloc!.state;
    if (state is DocumentLoadFailure) {
      return ErrorPage(message: state.message);
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
            BlocProvider.value(value: _bloc!),
            BlocProvider.value(value: _transformCubit!),
            BlocProvider.value(value: _currentIndexCubit!),
          ],
          child: Builder(builder: (context) {
            return RepositoryProvider.value(
              value: _importService,
              child: Builder(builder: (context) {
                return Actions(
                  actions: actions,
                  child: Shortcuts(
                    shortcuts: {
                      LogicalKeySet(LogicalKeyboardKey.control,
                          LogicalKeyboardKey.keyZ): UndoIntent(context),
                      LogicalKeySet(LogicalKeyboardKey.control,
                          LogicalKeyboardKey.keyY): RedoIntent(context),
                      LogicalKeySet(LogicalKeyboardKey.control,
                              LogicalKeyboardKey.keyN):
                          NewIntent(context, fromTemplate: false),
                      LogicalKeySet(
                              LogicalKeyboardKey.control,
                              LogicalKeyboardKey.shift,
                              LogicalKeyboardKey.keyN):
                          NewIntent(context, fromTemplate: true),
                      LogicalKeySet(LogicalKeyboardKey.tab):
                          EditModeIntent(context),
                      LogicalKeySet(
                          LogicalKeyboardKey.control,
                          LogicalKeyboardKey.shift,
                          LogicalKeyboardKey.keyP): WaypointsIntent(context),
                      LogicalKeySet(
                          LogicalKeyboardKey.control,
                          LogicalKeyboardKey.alt,
                          LogicalKeyboardKey.shift,
                          LogicalKeyboardKey.keyS): ProjectIntent(context),
                      LogicalKeySet(LogicalKeyboardKey.control,
                          LogicalKeyboardKey.keyP): ColorPaletteIntent(context),
                      LogicalKeySet(LogicalKeyboardKey.control,
                          LogicalKeyboardKey.keyB): BackgroundIntent(context),
                      LogicalKeySet(
                          LogicalKeyboardKey.control,
                          LogicalKeyboardKey.shift,
                          LogicalKeyboardKey.keyA): AreasIntent(context),
                      LogicalKeySet(LogicalKeyboardKey.control,
                          LogicalKeyboardKey.keyL): LayersIntent(context),
                      LogicalKeySet(LogicalKeyboardKey.control,
                              LogicalKeyboardKey.alt, LogicalKeyboardKey.keyN):
                          InsertIntent(context, Offset.zero),
                      if (widget.embedding == null) ...{
                        LogicalKeySet(LogicalKeyboardKey.control,
                            LogicalKeyboardKey.keyO): OpenIntent(context),
                        LogicalKeySet(LogicalKeyboardKey.control,
                            LogicalKeyboardKey.keyI): ImportIntent(context),
                        LogicalKeySet(LogicalKeyboardKey.control,
                            LogicalKeyboardKey.keyE): ExportIntent(context),
                        LogicalKeySet(
                                LogicalKeyboardKey.control,
                                LogicalKeyboardKey.shift,
                                LogicalKeyboardKey.keyE):
                            ImageExportIntent(context),
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
                        LogicalKeySet(LogicalKeyboardKey.alt,
                            LogicalKeyboardKey.keyS): ChangePathIntent(context),
                        LogicalKeySet(LogicalKeyboardKey.control,
                            LogicalKeyboardKey.keyS): SaveIntent(context),
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
                          LogicalKeyboardKey.digit0
                        ].asMap().map((k, v) => MapEntry(
                            LogicalKeySet(LogicalKeyboardKey.control, v),
                            ChangePainterIntent(context, k))),
                      },
                    },
                    child: SafeArea(
                      child: ClipRect(
                        child: Focus(
                          autofocus: true,
                          child: FocusScope(
                              child: Scaffold(
                            appBar: PadAppBar(
                              viewportKey: _viewportKey,
                            ),
                            body: Actions(
                                actions: actions,
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  final isMobile =
                                      MediaQuery.of(context).size.width < 800;
                                  final isLandscape =
                                      MediaQuery.of(context).size.height < 400;
                                  const property = PropertyView();
                                  return Stack(
                                    children: [
                                      Column(
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
                                                    if (!isLandscape) property
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
                                          ]),
                                      if (isLandscape) property
                                    ],
                                  );
                                })),
                          )),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          })),
    );
  }
}
