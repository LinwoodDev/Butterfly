import 'dart:convert';

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
import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/language.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'toolbar.dart';
import 'view.dart';

class ProjectPage extends StatefulWidget {
  final String? id;

  const ProjectPage({Key? key, this.id}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: closeSinks
  DocumentBloc? _bloc;
  final TextEditingController _scaleController =
      TextEditingController(text: '100');

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) async {
      int? index;
      AppDocument document;
      var documents = value.getStringList('documents') ?? [];
      if (widget.id == null) {
        document = AppDocument(
            name: await formatCurrentDateTime(
                context.read<LanguageCubit>().state),
            createdAt: DateTime.now(),
            palettes: ColorPalette.getMaterialPalette(context));
      } else {
        index = int.tryParse(widget.id ?? '') ?? 0;
        document = AppDocument.fromJson(jsonDecode(documents[index]));
      }
      setState(() => _bloc = DocumentBloc(document, index));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) return const Center(child: CircularProgressIndicator());
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => _bloc!),
          BlocProvider(create: (_) => TransformCubit()),
          BlocProvider(create: (_) => SelectionCubit())
        ],
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ):
                const UndoIntent(),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyY):
                const RedoIntent(),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyN):
                NewIntent(context),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO):
                OpenIntent(context),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyI):
                ImportIntent(context),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyE):
                ExportIntent(context),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.shift,
                LogicalKeyboardKey.keyE): ImageExportIntent(context),
            LogicalKeySet(LogicalKeyboardKey.tab): const EditModeIntent(),
            LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.alt,
                LogicalKeyboardKey.keyS): SettingsIntent(context),
            LogicalKeySet(
                LogicalKeyboardKey.control,
                LogicalKeyboardKey.alt,
                LogicalKeyboardKey.shift,
                LogicalKeyboardKey.keyS): ProjectIntent(context),
          },
          child: Actions(
              actions: <Type, Action<Intent>>{
                UndoIntent: UndoAction(_bloc!),
                RedoIntent: RedoAction(_bloc!),
                NewIntent: NewAction(_bloc!),
                OpenIntent: OpenAction(_bloc!),
                ImportIntent: ImportAction(_bloc!),
                ImageExportIntent: ImageExportAction(_bloc!),
                ExportIntent: ExportAction(_bloc!),
                EditModeIntent: EditModeAction(_bloc!),
                SettingsIntent: SettingsAction(_bloc!),
                ProjectIntent: ProjectAction(_bloc!)
              },
              child: Builder(
                  builder: (context) => Focus(
                      autofocus: true,
                      child: Scaffold(
                          appBar: AppBar(
                              title: BlocBuilder<DocumentBloc, DocumentState>(
                                  builder: (context, state) {
                                if (_bloc!.state is DocumentLoadSuccess) {
                                  var current =
                                      _bloc!.state as DocumentLoadSuccess;
                                  return Text(current.document.name);
                                } else {
                                  return Text(
                                      AppLocalizations.of(context)!.loading);
                                }
                              }),
                              actions: [
                                IconButton(
                                  icon: const Icon(
                                      PhosphorIcons.arrowCounterClockwiseLight),
                                  tooltip: AppLocalizations.of(context)!.undo,
                                  onPressed: () {
                                    Actions.invoke<UndoIntent>(
                                        context, const UndoIntent());
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                      PhosphorIcons.arrowClockwiseLight),
                                  tooltip: AppLocalizations.of(context)!.redo,
                                  onPressed: () {
                                    Actions.invoke<RedoIntent>(
                                        context, const RedoIntent());
                                  },
                                ),
                                PopupMenuButton(
                                  itemBuilder: (context) => <PopupMenuEntry>[
                                    PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        child: ListTile(
                                          leading: const Icon(
                                              PhosphorIcons.filePlusLight),
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .newContent),
                                          subtitle: Text(
                                              AppLocalizations.of(context)!
                                                      .ctrlKey +
                                                  ' + N'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Actions.invoke<NewIntent>(
                                                context, NewIntent(context));
                                          },
                                        )),
                                    PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        child: ListTile(
                                            leading: const Icon(
                                                PhosphorIcons.folderOpenLight),
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .open),
                                            subtitle: Text(
                                                AppLocalizations.of(context)!
                                                        .ctrlKey +
                                                    ' + O'),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Actions.invoke<OpenIntent>(
                                                  context, OpenIntent(context));
                                            })),
                                    PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        child: ListTile(
                                          leading: const Icon(
                                              PhosphorIcons.arrowSquareInLight),
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .import),
                                          subtitle: Text(
                                              AppLocalizations.of(context)!
                                                      .ctrlKey +
                                                  ' + I'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Actions.invoke<ImportIntent>(
                                                context, ImportIntent(context));
                                          },
                                        )),
                                    PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        child: PopupMenuButton(
                                            itemBuilder: (popupContext) => [
                                                  PopupMenuItem(
                                                      padding: EdgeInsets.zero,
                                                      child: ListTile(
                                                          leading: const Icon(
                                                              PhosphorIcons
                                                                  .databaseLight),
                                                          title: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .data),
                                                          subtitle: Text(
                                                              AppLocalizations.of(
                                                                          context)!
                                                                      .ctrlKey +
                                                                  ' + E'),
                                                          onTap: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Actions.invoke<
                                                                    ExportIntent>(
                                                                context,
                                                                ExportIntent(
                                                                    context));
                                                          })),
                                                  PopupMenuItem(
                                                      padding: EdgeInsets.zero,
                                                      child: ListTile(
                                                          leading: const Icon(
                                                              PhosphorIcons
                                                                  .imageLight),
                                                          title: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .image),
                                                          subtitle: Text(AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .ctrlKey +
                                                              ' + ' +
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .shiftKey +
                                                              ' + E'),
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Actions.invoke<
                                                                    ImageExportIntent>(
                                                                context,
                                                                ImageExportIntent(
                                                                    context));
                                                          })),
                                                ],
                                            tooltip: '',
                                            child: ListTile(
                                                mouseCursor: MouseCursor.defer,
                                                leading: const Icon(
                                                    PhosphorIcons.exportLight),
                                                title: Text(AppLocalizations.of(
                                                        context)!
                                                    .export)))),
                                    const PopupMenuDivider(),
                                    PopupMenuItem(
                                        child: ListTile(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Actions.invoke<ProjectIntent>(
                                                  context,
                                                  ProjectIntent(context));
                                            },
                                            subtitle: Text(AppLocalizations.of(
                                                        context)!
                                                    .ctrlKey +
                                                ' + ' +
                                                AppLocalizations.of(context)!
                                                    .altKey +
                                                ' + ' +
                                                AppLocalizations.of(context)!
                                                    .shiftKey +
                                                ' + S'),
                                            leading: const Icon(
                                                PhosphorIcons.wrenchLight),
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .projectSettings)),
                                        padding: EdgeInsets.zero),
                                    PopupMenuItem(
                                        padding: EdgeInsets.zero,
                                        child: ListTile(
                                            leading: const Icon(
                                                PhosphorIcons.gearLight),
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .settings),
                                            subtitle: Text(AppLocalizations.of(
                                                        context)!
                                                    .ctrlKey +
                                                ' + ' +
                                                AppLocalizations.of(context)!
                                                    .altKey +
                                                ' + S'),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Actions.invoke<SettingsIntent>(
                                                  context,
                                                  SettingsIntent(context));
                                            }))
                                  ],
                                ),
                                /*const IconButton(
                                    icon: Icon(PhosphorIcons.linkLight),
                                    tooltip: "Share (not implemented)",
                                    onPressed: null)*/
                              ]),
                          body: LayoutBuilder(builder: (context, constraints) {
                            var isMobile = constraints.maxWidth < 600;
                            var toolbar = SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MainViewToolbar(bloc: _bloc!),
                                  ],
                                ));
                            var _toolScrollController = ScrollController();
                            Widget toolsSelection = Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Scrollbar(
                                    controller: _toolScrollController,
                                    child: SingleChildScrollView(
                                        controller: _toolScrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: [
                                          BlocBuilder<DocumentBloc,
                                                  DocumentState>(
                                              builder: (context, state) {
                                            if (_bloc!.state
                                                is DocumentLoadSuccess) {
                                              var current = _bloc!.state
                                                  as DocumentLoadSuccess;
                                              return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    IconButton(
                                                        icon: Icon(
                                                            current.editMode
                                                                ? PhosphorIcons
                                                                    .penLight
                                                                : PhosphorIcons
                                                                    .handLight),
                                                        tooltip: current
                                                                .editMode
                                                            ? AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .edit
                                                            : AppLocalizations
                                                                    .of(context)!
                                                                .view,
                                                        onPressed: () {
                                                          _bloc!.add(ToolChanged(
                                                              !current
                                                                  .editMode));
                                                        })
                                                  ]);
                                            }
                                            return Container();
                                          }),
                                          const VerticalDivider(),
                                          BlocBuilder<TransformCubit,
                                                  CameraTransform>(
                                              builder: (context, transform) {
                                            _scaleController.text =
                                                (transform.size * 100)
                                                    .toStringAsFixed(2);

                                            return Row(
                                              children: [
                                                IconButton(
                                                    icon: const Icon(PhosphorIcons
                                                        .magnifyingGlassMinusLight),
                                                    tooltip:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .zoomOut,
                                                    onPressed: () {
                                                      context.read<TransformCubit>().zoom(
                                                          -0.1,
                                                          Offset(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2));
                                                    }),
                                                IconButton(
                                                    icon: const Icon(PhosphorIcons
                                                        .magnifyingGlassLight),
                                                    tooltip:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .resetZoom,
                                                    onPressed: () {
                                                      var cubit = context.read<
                                                          TransformCubit>();
                                                      cubit.zoom(
                                                          1 - cubit.state.size,
                                                          Offset(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2));
                                                    }),
                                                IconButton(
                                                    icon: const Icon(PhosphorIcons
                                                        .magnifyingGlassPlusLight),
                                                    tooltip:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .zoomIn,
                                                    onPressed: () {
                                                      context.read<TransformCubit>().zoom(
                                                          0.1,
                                                          Offset(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2));
                                                    }),
                                                const SizedBox(width: 20),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 100),
                                                  child: TextField(
                                                    controller:
                                                        _scaleController,
                                                    onSubmitted: (value) {
                                                      var scale =
                                                          double.tryParse(
                                                                  value) ??
                                                              100;
                                                      scale /= 100;
                                                      var cubit = context.read<
                                                          TransformCubit>();
                                                      cubit.zoom(
                                                          scale -
                                                              cubit.state.size,
                                                          Offset(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2));
                                                    },
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .zoom),
                                                  ),
                                                ),
                                                if (!isMobile)
                                                  const VerticalDivider()
                                              ],
                                            );
                                          }),
                                        ])),
                                  )),
                                  if (!isMobile) toolbar
                                ]);
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 75,
                                    color: Theme.of(context).canvasColor,
                                    padding: const EdgeInsets.all(12.0),
                                    child: toolsSelection,
                                  ),
                                  Expanded(
                                      child: MainViewViewport(bloc: _bloc!)),
                                  if (isMobile)
                                    Align(
                                        alignment: Alignment.center,
                                        child: toolbar)
                                ]);
                          }))))),
        ));
  }
}
