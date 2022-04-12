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
import 'package:butterfly/actions/project.dart';
import 'package:butterfly/actions/redo.dart';
import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/actions/undo.dart';
import 'package:butterfly/actions/waypoints.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/introduction/app.dart';
import 'package:butterfly/dialogs/introduction/update.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/views/app_bar.dart';
import 'package:butterfly/views/edit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'view.dart';

bool isWindow() =>
    !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

class ProjectPage extends StatefulWidget {
  final String? path;

  const ProjectPage({Key? key, this.path}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: closeSinks
  DocumentBloc? _bloc;
  final GlobalKey _viewportKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void didUpdateWidget(ProjectPage oldWidget) {
    if (oldWidget.path != widget.path) {
      _bloc?.close();
      _bloc = null;
      load();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> load() async {
    var fileSystem = DocumentFileSystem.fromPlatform();
    var prefs = await SharedPreferences.getInstance();
    AppDocument? document;
    if (widget.path != null) {
      await fileSystem.getAsset(widget.path!).then(
          (value) => document = value is AppDocumentFile ? value.load() : null);
    }
    if (document == null && prefs.containsKey('default_template')) {
      var template = await TemplateFileSystem.fromPlatform()
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
          document!.content.map((e) => Renderer.fromElement(e)).toList();
      for (var renderer in renderers) {
        await renderer.setup(document!);
      }
      setState(() => _bloc = DocumentBloc(document!, widget.path, renderers));
    }
    _showIntroduction();
  }

  Future<void> _showIntroduction() async {
    final settingsCubit = context.read<SettingsCubit>();
    if (settingsCubit.isFirstStart()) {
      await showDialog(
        context: context,
        builder: (context) => const AppIntroductionDialog(),
      );
    } else if (await settingsCubit.hasNewerVersion()) {
      await showDialog(
          context: context,
          builder: (context) => const UpdateIntroductionDialog());
    } else {
      return;
    }
    await settingsCubit.updateLastVersion();
    await settingsCubit.save();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) return const Center(child: CircularProgressIndicator());
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _bloc!),
          BlocProvider(create: (_) => TransformCubit()),
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
              LogicalKeySet(LogicalKeyboardKey.tab): EditModeIntent(context),
              LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.alt,
                  LogicalKeyboardKey.keyS): SettingsIntent(context),
              LogicalKeySet(
                  LogicalKeyboardKey.control,
                  LogicalKeyboardKey.alt,
                  LogicalKeyboardKey.shift,
                  LogicalKeyboardKey.keyS): ProjectIntent(context),
              LogicalKeySet(
                  LogicalKeyboardKey.control,
                  LogicalKeyboardKey.shift,
                  LogicalKeyboardKey.keyP): WaypointsIntent(context),
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
              LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.alt,
                  LogicalKeyboardKey.keyN): InsertIntent(context, Offset.zero),
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
                  ChangePathIntent(context),
            },
            child: Actions(
                actions: <Type, Action<Intent>>{
                  UndoIntent: UndoAction(),
                  RedoIntent: RedoAction(),
                  NewIntent: NewAction(),
                  OpenIntent: OpenAction(),
                  ImportIntent: ImportAction(),
                  ImageExportIntent: ImageExportAction(),
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
                                            child: const MainViewViewport()),
                                        if (isMobile)
                                          Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: EditToolbar(
                                                      isMobile: isMobile)))
                                      ]);
                                })),
                          ));
                    }),
                  ),
                )),
          );
        }));
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isWindow()) {
      return LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(PhosphorIcons.minusLight),
                iconSize: 16,
                splashRadius: 20,
                onPressed: () => windowManager.minimize(),
              ),
              IconButton(
                icon: const Icon(PhosphorIcons.squareLight),
                iconSize: 16,
                splashRadius: 20,
                onPressed: () async => await windowManager.isMaximized()
                    ? windowManager.unmaximize()
                    : windowManager.maximize(),
              ),
              IconButton(
                icon: const Icon(PhosphorIcons.xLight),
                hoverColor: Colors.red,
                iconSize: 16,
                splashRadius: 20,
                onPressed: () => windowManager.close(),
              )
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
