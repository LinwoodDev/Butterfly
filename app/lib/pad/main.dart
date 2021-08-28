import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/pad/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'bloc/document_bloc.dart';
import 'dialogs/settings.dart';

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
    var pad = (_bloc.state as DocumentLoadSuccess).currentPad;
    if (pad != null && pad.root == null) {
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
                    bottom: TabBar(
                        isScrollable: true,
                        onTap: (value) {
                          var tool = tools[value];
                          _bloc.add(ToolChanged(tool));
                          _bloc.add(InspectorChanged(item: tool));
                        },
                        tabs: tools.map((e) => Tab(icon: Icon(e.icon), text: e.name)).toList()),
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
                body: MainView())));
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
