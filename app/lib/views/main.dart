import 'dart:convert';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/export.dart';
import 'package:butterfly/dialogs/file_system.dart';
import 'package:butterfly/dialogs/open.dart';
import 'package:butterfly/dialogs/save.dart';
import 'package:butterfly/dialogs/settings.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/settings/home.dart';
import 'package:flutter/material.dart';
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
    SharedPreferences.getInstance().then((value) {
      int? index;
      AppDocument document;
      var documents = value.getStringList('documents') ?? [];
      if (widget.id == null) {
        document = AppDocument(name: '', createdAt: DateTime.now());
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
          BlocProvider(create: (_) => TransformCubit())
        ],
        child: Scaffold(
            appBar: AppBar(
                title: BlocBuilder<DocumentBloc, DocumentState>(
                    builder: (context, state) {
                  if (_bloc!.state is DocumentLoadSuccess) {
                    var current = _bloc!.state as DocumentLoadSuccess;
                    return Text(current.document.name);
                  } else {
                    return Text(AppLocalizations.of(context)!.loading);
                  }
                }),
                actions: [
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
                    tooltip: AppLocalizations.of(context)!.undo,
                    onPressed: () {
                      _bloc?.undo();
                      var state = _bloc?.state;
                      if (state is DocumentLoadSuccess) state.save();
                    },
                  ),
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrowClockwiseLight),
                    tooltip: AppLocalizations.of(context)!.redo,
                    onPressed: () {
                      _bloc?.redo();
                      var state = _bloc?.state;
                      if (state is DocumentLoadSuccess) state.save();
                    },
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => <PopupMenuEntry>[
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            leading: const Icon(PhosphorIcons.filePlusLight),
                            title:
                                Text(AppLocalizations.of(context)!.newContent),
                            onTap: () {
                              // TODO: Add new content
                            },
                          )),
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                              leading:
                                  const Icon(PhosphorIcons.folderOpenLight),
                              title: Text(AppLocalizations.of(context)!.open),
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) =>
                                      FileSystemDialog(bloc: _bloc!)).then(
                                  (value) => SharedPreferences.getInstance()
                                      .then((prefs) => _bloc?.emit(
                                          DocumentLoadSuccess(AppDocument.fromJson(jsonDecode((prefs.getStringList('documents') ?? [])[value])), documentIndex: value)))))),
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            leading:
                                const Icon(PhosphorIcons.arrowSquareInLight),
                            title: Text(AppLocalizations.of(context)!.import),
                            onTap: () {
                              showDialog(
                                      builder: (context) => const OpenDialog(),
                                      context: context)
                                  .then((content) {
                                if (content == null) return;
                                setState(() {
                                  // TODO: Implement import
                                  //_documents.add(AppDocument.fromJson(jsonDecode(content)));
                                  //saveDocuments();
                                });
                              });
                            },
                          )),
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                              leading:
                                  const Icon(PhosphorIcons.floppyDiskLight),
                              title: Text(AppLocalizations.of(context)!.save),
                              onTap: () async {
                                var data = json.encode(
                                    (_bloc?.state as DocumentLoadSuccess)
                                        .document
                                        .toJson());
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        SaveDialog(data: data));
                              })),

                      /*PopupMenuItem(
                        padding: EdgeInsets.zero,
                        child: PopupMenuButton(
                          tooltip: '',
                        child: ListTile(
                          mouseCursor: MouseCursor.defer,
                            leading:const Icon(PhosphorIcons.arrowSquareOutLight),title: Text(AppLocalizations.of(context)!.export)),
                        onSelected: (value) { },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                  leading:
                                  const Icon(PhosphorIcons.imageLight),
                                  title: Text(AppLocalizations.of(context)!.image),
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          ExportDialog(bloc: _bloc!)))),
                        ],
                      ),
                    ),*/
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                              leading: const Icon(PhosphorIcons.exportLight),
                              title: Text(AppLocalizations.of(context)!.export),
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) =>
                                      ExportDialog(bloc: _bloc!)))),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                          child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        PadSettingsDialog(bloc: _bloc));
                              },
                              leading: const Icon(PhosphorIcons.wrenchLight),
                              title: Text(AppLocalizations.of(context)!
                                  .projectSettings)),
                          padding: EdgeInsets.zero),
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                              leading: const Icon(PhosphorIcons.gearLight),
                              title:
                                  Text(AppLocalizations.of(context)!.settings),
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                      child: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxHeight: 400, maxWidth: 600),
                                          child: const SettingsPage(
                                              isDialog: true))))))
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
                            BlocBuilder<DocumentBloc, DocumentState>(
                                builder: (context, state) {
                              if (_bloc!.state is DocumentLoadSuccess) {
                                var current =
                                    _bloc!.state as DocumentLoadSuccess;
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      IconButton(
                                          icon: Icon(current.editMode
                                              ? PhosphorIcons.penLight
                                              : PhosphorIcons.handLight),
                                          tooltip: current.editMode
                                              ? AppLocalizations.of(context)!
                                                  .edit
                                              : AppLocalizations.of(context)!
                                                  .view,
                                          onPressed: () {
                                            _bloc!.add(
                                                ToolChanged(!current.editMode));
                                          })
                                    ]);
                              }
                              return Container();
                            }),
                            const VerticalDivider(),
                            BlocBuilder<TransformCubit, CameraTransform>(
                                builder: (context, transform) {
                              _scaleController.text =
                                  (transform.size * 100).toStringAsFixed(2);
                              void setScale(double scale) {
                                setState(() =>
                                    context.read<TransformCubit>().size(scale));
                              }

                              return Row(
                                children: [
                                  IconButton(
                                      icon: const Icon(PhosphorIcons
                                          .magnifyingGlassMinusLight),
                                      tooltip:
                                          AppLocalizations.of(context)!.zoomOut,
                                      onPressed: () {
                                        setScale(transform.size - 0.05);
                                      }),
                                  IconButton(
                                      icon: const Icon(
                                          PhosphorIcons.magnifyingGlassLight),
                                      tooltip: AppLocalizations.of(context)!
                                          .resetZoom,
                                      onPressed: () {
                                        setScale(1);
                                      }),
                                  IconButton(
                                      icon: const Icon(PhosphorIcons
                                          .magnifyingGlassPlusLight),
                                      tooltip:
                                          AppLocalizations.of(context)!.zoomIn,
                                      onPressed: () {
                                        setScale(transform.size + 0.05);
                                      }),
                                  const SizedBox(width: 20),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 100),
                                    child: TextField(
                                      controller: _scaleController,
                                      onSubmitted: (value) {
                                        var scale =
                                            double.tryParse(value) ?? 100;
                                        scale /= 100;
                                        setScale(scale);
                                      },
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .zoom),
                                    ),
                                  ),
                                  if (!isMobile) const VerticalDivider()
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
                    Expanded(child: MainViewViewport(bloc: _bloc!)),
                    if (isMobile)
                      Align(alignment: Alignment.center, child: toolbar)
                  ]);
            })));
  }
}
