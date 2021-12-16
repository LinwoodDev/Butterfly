import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/color_palette.dart';
import 'package:butterfly/actions/edit_mode.dart';
import 'package:butterfly/actions/export.dart';
import 'package:butterfly/actions/image_export.dart';
import 'package:butterfly/actions/import.dart';
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
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/tool/edit.dart';
import 'package:butterfly/tool/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  final TextEditingController _scaleController =
      TextEditingController(text: '100');

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
    AppDocument? document;
    if (widget.path != null) {
      await fileSystem.getAsset(widget.path!).then(
          (value) => document = value is AppDocumentFile ? value.load() : null);
    }
    document ??= AppDocument(
        name: await formatCurrentDateTime(
            context.read<SettingsCubit>().state.locale),
        createdAt: DateTime.now(),
        palettes: ColorPalette.getMaterialPalette(context));
    setState(() => _bloc = DocumentBloc(document!, widget.path));
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) return const Center(child: CircularProgressIndicator());
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _bloc!),
          BlocProvider(create: (_) => TransformCubit()),
          BlocProvider(create: (_) => SelectionCubit()),
          BlocProvider(create: (_) => EditingCubit()),
        ],
        child: Builder(builder: (context) {
          return Shortcuts(
            shortcuts: {
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
                  const UndoIntent(),
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyY):
                  const RedoIntent(),
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):
                  NewIntent(context),
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
              LogicalKeySet(LogicalKeyboardKey.tab): const EditModeIntent(),
              LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.alt,
                  LogicalKeyboardKey.keyS): SettingsIntent(context),
              LogicalKeySet(
                  LogicalKeyboardKey.control,
                  LogicalKeyboardKey.alt,
                  LogicalKeyboardKey.shift,
                  LogicalKeyboardKey.keyS): ProjectIntent(context),
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyW):
                  WaypointsIntent(context),
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyP):
                  ColorPaletteIntent(context),
              LogicalKeySet(
                      LogicalKeyboardKey.control, LogicalKeyboardKey.keyB):
                  BackgroundIntent(context),
            },
            child: Actions(
                actions: <Type, Action<Intent>>{
                  UndoIntent: UndoAction(_bloc!),
                  RedoIntent: RedoAction(_bloc!),
                  NewIntent: NewAction(
                      _bloc!,
                      context.read<SelectionCubit>(),
                      context.read<EditingCubit>(),
                      context.read<TransformCubit>()),
                  OpenIntent: OpenAction(_bloc!),
                  ImportIntent: ImportAction(_bloc!),
                  ImageExportIntent: ImageExportAction(_bloc!),
                  ExportIntent: ExportAction(_bloc!),
                  EditModeIntent: EditModeAction(_bloc!),
                  SettingsIntent: SettingsAction(_bloc!),
                  ProjectIntent: ProjectAction(_bloc!),
                  WaypointsIntent: WaypointsAction(_bloc!),
                  ColorPaletteIntent: ColorPaletteAction(),
                  BackgroundIntent: BackgroundAction(),
                },
                child: Builder(builder: (context) {
                  PreferredSizeWidget appBar = _buildAppBar();
                  if (isWindow()) {
                    appBar = PreferredSize(
                        preferredSize: const Size.fromHeight(60),
                        child: MoveWindow(child: appBar));
                  }
                  return Focus(
                      autofocus: true,
                      child: Scaffold(
                          appBar: appBar,
                          body: LayoutBuilder(builder: (context, constraints) {
                            var isMobile = constraints.maxWidth < 600;
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 75,
                                    color: Theme.of(context).canvasColor,
                                    padding: const EdgeInsets.all(12.0),
                                    child: _buildToolSelection(isMobile),
                                  ),
                                  Expanded(
                                      key: _viewportKey,
                                      child: const MainViewViewport()),
                                  if (isMobile)
                                    Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: _buildToolbar()))
                                ]);
                          })));
                })),
          );
        }));
  }

  AppBar _buildAppBar() => AppBar(
          title: BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
            if (_bloc!.state is DocumentLoadSuccess) {
              var current = _bloc!.state as DocumentLoadSuccess;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      current.document.name,
                      textAlign: TextAlign.center,
                    ),
                    if (current.path != null)
                      Text(current.path!,
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.center),
                  ]);
            } else {
              return Text(AppLocalizations.of(context)!.loading);
            }
          }),
          actions: [
            IconButton(
              icon: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
              tooltip: AppLocalizations.of(context)!.undo,
              onPressed: () {
                Actions.maybeInvoke<UndoIntent>(context, const UndoIntent());
              },
            ),
            IconButton(
              icon: const Icon(PhosphorIcons.arrowClockwiseLight),
              tooltip: AppLocalizations.of(context)!.redo,
              onPressed: () {
                Actions.maybeInvoke<RedoIntent>(context, const RedoIntent());
              },
            ),
            _buildPopupMenu(),
            if (isWindow()) ...[const VerticalDivider(), const WindowButtons()]
          ]);

  Widget _buildToolbar() => const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(height: 50, child: EditToolbar()),
      );

  Widget _buildToolSelection(bool isMobile) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
              if (_bloc!.state is DocumentLoadSuccess) {
                return const ViewToolbar();
              }
              return Container();
            }),
            const VerticalDivider(),
            BlocBuilder<TransformCubit, CameraTransform>(
                builder: (context, transform) {
              _scaleController.text = (transform.size * 100).toStringAsFixed(2);

              return Row(
                children: [
                  IconButton(
                      icon: const Icon(PhosphorIcons.magnifyingGlassMinusLight),
                      tooltip: AppLocalizations.of(context)!.zoomOut,
                      onPressed: () {
                        context.read<TransformCubit>().zoom(
                            -0.1,
                            Offset(MediaQuery.of(context).size.width / 2,
                                MediaQuery.of(context).size.height / 2));
                      }),
                  IconButton(
                      icon: const Icon(PhosphorIcons.magnifyingGlassLight),
                      tooltip: AppLocalizations.of(context)!.resetZoom,
                      onPressed: () {
                        var cubit = context.read<TransformCubit>();
                        cubit.zoom(
                            1 - cubit.state.size,
                            Offset(MediaQuery.of(context).size.width / 2,
                                MediaQuery.of(context).size.height / 2));
                      }),
                  IconButton(
                      icon: const Icon(PhosphorIcons.magnifyingGlassPlusLight),
                      tooltip: AppLocalizations.of(context)!.zoomIn,
                      onPressed: () {
                        var viewportSize = _viewportKey.currentContext?.size ??
                            MediaQuery.of(context).size;
                        context.read<TransformCubit>().zoom(
                            0.1,
                            Offset(viewportSize.width / 2,
                                viewportSize.height / 2));
                      }),
                  const SizedBox(width: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: TextField(
                      controller: _scaleController,
                      onSubmitted: (value) {
                        var viewportSize = MediaQuery.of(context).size;
                        var scale = double.tryParse(value) ?? 100;
                        scale /= 100;
                        var cubit = context.read<TransformCubit>();
                        cubit.zoom(
                            scale - cubit.state.size,
                            Offset(viewportSize.width / 2,
                                viewportSize.height / 2));
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.zoom),
                    ),
                  ),
                  if (!isMobile) const VerticalDivider()
                ],
              );
            }),
          ]),
          if (!isMobile)
            Flexible(
              child: _buildToolbar(),
            )
        ]);
  }

  Widget _buildPopupMenu() => PopupMenuButton(
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(PhosphorIcons.filePlusLight),
                title: Text(AppLocalizations.of(context)!.newContent),
                subtitle: Text(AppLocalizations.of(context)!.ctrlKey + ' + N'),
                onTap: () {
                  Navigator.of(context).pop();
                  Actions.maybeInvoke<NewIntent>(context, NewIntent(context));
                },
              )),
          PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                  leading: const Icon(PhosphorIcons.folderOpenLight),
                  title: Text(AppLocalizations.of(context)!.open),
                  subtitle:
                      Text(AppLocalizations.of(context)!.ctrlKey + ' + O'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<OpenIntent>(
                        context, OpenIntent(context));
                  })),
          PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(PhosphorIcons.arrowSquareInLight),
                title: Text(AppLocalizations.of(context)!.import),
                subtitle: Text(AppLocalizations.of(context)!.ctrlKey + ' + I'),
                onTap: () {
                  Navigator.of(context).pop();
                  Actions.maybeInvoke<ImportIntent>(
                      context, ImportIntent(context));
                },
              )),
          PopupMenuItem(
              padding: EdgeInsets.zero,
              child: PopupMenuButton(
                  itemBuilder: (popupContext) => <PopupMenuEntry>[
                        PopupMenuItem(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                                leading:
                                    const Icon(PhosphorIcons.caretLeftLight),
                                title: Text(AppLocalizations.of(context)!.back),
                                onTap: () async {
                                  Navigator.of(context).pop();
                                })),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                                leading:
                                    const Icon(PhosphorIcons.databaseLight),
                                title: Text(AppLocalizations.of(context)!.data),
                                subtitle: Text(
                                    AppLocalizations.of(context)!.ctrlKey +
                                        ' + E'),
                                onTap: () async {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Actions.maybeInvoke<ExportIntent>(
                                      context, ExportIntent(context));
                                })),
                        PopupMenuItem(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                                leading: const Icon(PhosphorIcons.imageLight),
                                title:
                                    Text(AppLocalizations.of(context)!.image),
                                subtitle: Text(
                                    AppLocalizations.of(context)!.ctrlKey +
                                        ' + ' +
                                        AppLocalizations.of(context)!.shiftKey +
                                        ' + E'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Actions.maybeInvoke<ImageExportIntent>(
                                      context, ImageExportIntent(context));
                                })),
                      ],
                  tooltip: '',
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      leading: const Icon(PhosphorIcons.exportLight),
                      trailing: const Icon(PhosphorIcons.caretRightLight),
                      title: Text(AppLocalizations.of(context)!.export)))),
          const PopupMenuDivider(),
          PopupMenuItem(
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<ProjectIntent>(
                        context, ProjectIntent(context));
                  },
                  subtitle: Text(AppLocalizations.of(context)!.ctrlKey +
                      ' + ' +
                      AppLocalizations.of(context)!.altKey +
                      ' + ' +
                      AppLocalizations.of(context)!.shiftKey +
                      ' + S'),
                  leading: const Icon(PhosphorIcons.wrenchLight),
                  title: Text(AppLocalizations.of(context)!.projectSettings)),
              padding: EdgeInsets.zero),
          PopupMenuItem(
              padding: EdgeInsets.zero,
              child: ListTile(
                  leading: const Icon(PhosphorIcons.gearLight),
                  title: Text(AppLocalizations.of(context)!.settings),
                  subtitle: Text(AppLocalizations.of(context)!.ctrlKey +
                      ' + ' +
                      AppLocalizations.of(context)!.altKey +
                      ' + S'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Actions.maybeInvoke<SettingsIntent>(
                        context, SettingsIntent(context));
                  }))
        ],
      );
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isWindow()) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(PhosphorIcons.minusLight),
              iconSize: 16,
              splashRadius: 20,
              onPressed: () => appWindow.minimize(),
            ),
            IconButton(
              icon: const Icon(PhosphorIcons.squareLight),
              iconSize: 16,
              splashRadius: 20,
              onPressed: () => appWindow.maximizeOrRestore(),
            ),
            IconButton(
              icon: const Icon(PhosphorIcons.xLight),
              hoverColor: Colors.red,
              iconSize: 16,
              splashRadius: 20,
              onPressed: () => appWindow.close(),
            )
          ],
        ),
      );
    }
    return Container();
  }
}
