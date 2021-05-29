import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/pad/dialogs/create_item.dart';
import 'package:butterfly/pad/dialogs/path.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/models/project/type.dart';

import 'type.dart';

class ProjectView extends StatelessWidget {
  final String path;

  ProjectView({Key? key, this.path = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var bloc = BlocProvider.of<DocumentBloc>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: CreateItemDialog(
                        parent: (bloc.state as DocumentLoadSuccess).document.getFile(path)
                            as FolderProjectItem?))),
            child: Icon(PhosphorIcons.plusLight),
            tooltip: "New"),
        body: Container(
            alignment: Alignment.center,
            child: BlocBuilder<DocumentBloc, DocumentState>(builder: (_, state) {
              if (state is DocumentLoadSuccess) {
                var file = state.document.getFile(path);
                if (file == null || !(file is FolderProjectItem))
                  return Center(child: Text("Directory not found"));
                var folder = file;
                return SizedBox.expand(
                    child: SingleChildScrollView(
                        child: Wrap(
                            children: folder.files.map((file) {
                  var currentPath = path.isNotEmpty ? path + '/' : '';
                  currentPath += file.name;
                  return Card(
                      child: InkWell(
                          onLongPress: () => _changeSelected(bloc, state, currentPath),
                          onTap: () {
                            if (file is FolderProjectItem)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProjectView(path: currentPath)));
                            else
                              _changeSelected(bloc, state, currentPath);
                          },
                          child: Container(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                                  child: Column(children: [
                                    Icon(file.type.icon, size: 50),
                                    Text(file.name, overflow: TextOverflow.ellipsis)
                                  ])))));
                }).toList())));
              } else
                return CircularProgressIndicator();
            })));
  }

  void _changeSelected(DocumentBloc bloc, DocumentLoadSuccess state, String currentPath) {
    bloc.add(SelectedChanged(currentPath));
    bloc.add(InspectorChanged(item: state.document.getFile(currentPath)!));
  }
}

class ProjectTool extends Tool {
  @override
  Widget buildInspector(DocumentBloc bloc) {
    return ListView(children: []);
  }

  @override
  List<Widget> buildOptions(
      {required BuildContext context,
      required DocumentLoadSuccess state,
      required bool? expanded,
      required bool isMobile,
      required GlobalKey<NavigatorState> navigator,
      required SplitWindow? window,
      required SplitView? view}) {
    return [
      IconButton(
          icon: Icon(PhosphorIcons.houseLight, size: 20),
          tooltip: "Home",
          onPressed: () {
            navigator.currentState?.popUntil((route) => route.isFirst);
          }),
      IconButton(
          icon: Icon(PhosphorIcons.arrowUpLight, size: 20),
          tooltip: "Up",
          onPressed: () {
            if (navigator.currentState?.canPop() ?? false) {
              navigator.currentState?.pop();
            }
          }),
      IconButton(
          icon: Icon(PhosphorIcons.magnifyingGlassLight, size: 20),
          tooltip: "Path",
          onPressed: () => showDialog(
              context: context,
              builder: (context) => FilePathDialog(
                  callback: (path) => navigator.currentState!
                    ..push(MaterialPageRoute(builder: (_) => ProjectView(path: path)))))),
      IconButton(
          icon: Icon(PhosphorIcons.arrowsCounterClockwiseLight, size: 20),
          tooltip: "Reload",
          onPressed: () {
            navigator.currentState?.popUntil((route) => route.isFirst);
            navigator.currentState
                ?.pushReplacement(MaterialPageRoute(builder: (_) => ProjectView(path: "")));
          }),
    ];
  }

  @override
  IconData get icon => PhosphorIcons.folderLight;

  @override
  ToolType get type => ToolType.project;

  @override
  String get name => "Project";

  @override
  List<Object> get props => [type];
}
