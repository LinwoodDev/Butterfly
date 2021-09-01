import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/type.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/pad/dialogs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'inspector.dart';
import 'layers.dart';
import 'main/toolbar.dart';
import 'main/view.dart';

class ProjectPage extends StatefulWidget {
  final String? path;
  final String? id;

  const ProjectPage({Key? key, this.path, required this.id}) : super(key: key);
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: close_sinks
  late DocumentBloc _bloc;
  final AppDocument document = AppDocument(name: "Document name");
  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
      Modular.to.navigate("/");
    }
    _bloc = DocumentBloc(document);
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showRootDialog());
  }

  void _showRootDialog() async {
    var pad = (_bloc.state as DocumentLoadSuccess).document;
    if (pad.root == null) {
      await showDialog(context: context, builder: (context) => CreateLayerDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    var tools = ToolType.values.map((e) => e.create()).toList();
    return DefaultTabController(
        length: tools.length,
        initialIndex: 1,
        child: BlocProvider(
            create: (_) => _bloc,
            child: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                      if (_bloc.state is DocumentLoadSuccess) {
                        var current = _bloc.state as DocumentLoadSuccess;
                        return Text(current.document.name);
                      } else
                        return Text("Loading...");
                    }),
                    actions: [
                      IconButton(
                        icon: Icon(PhosphorIcons.arrowCounterClockwiseLight),
                        tooltip: "Undo",
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(PhosphorIcons.arrowClockwiseLight),
                        tooltip: "Redo",
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(PhosphorIcons.gearLight),
                          tooltip: "Project settings",
                          onPressed: () => _showProjectSettings(context)),
                      IconButton(
                          icon: Icon(PhosphorIcons.linkLight),
                          tooltip: "Share (not implemented)",
                          onPressed: null)
                    ]),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 75,
                      color: Theme.of(context).canvasColor,
                      padding: const EdgeInsets.all(12.0),
                      child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                        if (_bloc.state is DocumentLoadSuccess) {
                          var current = _bloc.state as DocumentLoadSuccess;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Row(children: [
                                ...tools
                                    .map((e) => IconButton(
                                          icon: Icon(
                                              current.currentTool.type == e.type
                                                  ? e.activeIcon
                                                  : e.icon,
                                              size: 26),
                                          color: current.currentTool.type == e.type
                                              ? Theme.of(context).colorScheme.primary
                                              : null,
                                          tooltip: e.name,
                                          onPressed: () {
                                            _bloc.add(ToolChanged(e));
                                            _bloc.add(InspectorChanged(item: e));
                                          },
                                        ))
                                    .toList(),
                                VerticalDivider(),
                                IconButton(
                                    icon: Icon(PhosphorIcons.magnifyingGlassPlusLight),
                                    tooltip: "Zoom in",
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(PhosphorIcons.magnifyingGlassLight),
                                    tooltip: "Reset zoom",
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(PhosphorIcons.magnifyingGlassMinusLight),
                                    tooltip: "Zoom out",
                                    onPressed: () {}),
                                VerticalDivider(),
                                IconButton(
                                    icon: Icon(PhosphorIcons.cubeLight),
                                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => LayersView(bloc: _bloc)))),
                                IconButton(
                                    icon: Icon(PhosphorIcons.fadersLight),
                                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => InspectorView(bloc: _bloc)))),
                                PopupMenuButton<LayerType>(
                                    itemBuilder: (context) => LayerType.values
                                        .map((e) => PopupMenuItem<LayerType>(
                                            child: ListTile(
                                                mouseCursor: MouseCursor.defer,
                                                leading: Icon(e.icon),
                                                title: Text(e.name)),
                                            value: e))
                                        .toList(),
                                    icon: Icon(PhosphorIcons.plusLight, size: 26))
                              ])),
                              Expanded(
                                  child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      height: 50,
                                      child: MainViewToolbar())),
                            ],
                          );
                        }
                        return Container();
                      }),
                    ),
                    Expanded(child: MainViewViewport(bloc: _bloc)),
                  ],
                ))));
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
