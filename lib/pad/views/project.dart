import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

class ProjectView extends StatefulWidget {
  final DocumentBloc documentBloc;
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  const ProjectView({Key key, this.documentBloc, this.view, this.window, this.expanded})
      : super(key: key);
  @override
  _ProjectViewState createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  // ignore: close_sinks
  DocumentBloc _bloc;

  @override
  void initState() {
    _bloc = widget.documentBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'project_view',
        child: BlocProvider(
            create: (_) => _bloc,
            child: SplitScaffold(
                view: widget.view,
                window: widget.window,
                expanded: widget.expanded,
                title: "Project",
                icon: Icon(Mdi.tableOfContents),
                actions: [
                  IconButton(icon: Icon(Mdi.homeOutline), tooltip: "Home", onPressed: () {}),
                  IconButton(icon: Icon(Mdi.arrowUp), tooltip: "Up", onPressed: () {}),
                  IconButton(icon: Icon(Mdi.magnify), tooltip: "Path", onPressed: () {}),
                  IconButton(icon: Icon(Mdi.reload), tooltip: "Reload", onPressed: () {}),
                  VerticalDivider()
                ],
                floatingActionButton: FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _showNewSheet(context),
                    child: Icon(Mdi.plus),
                    tooltip: "New"),
                body: Builder(
                    builder: (context) => Container(
                        alignment: Alignment.center,
                        child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                          if (state is DocumentLoadSuccess) {
                            var path = state.currentPath;
                            var folder = state.document.folder.getFile(path) as FolderProjectItem;
                            print("Path: " + path + "Folder: " + folder.toString());
                            return Wrap(
                                children: folder.files
                                    .map((file) => Card(
                                            child: Column(children: [
                                          Icon(file.icon, size: 50),
                                          Text(file.name)
                                        ])))
                                    .toList());
                          } else
                            return CircularProgressIndicator();
                        }))))));
  }

  void _showNewSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("Create", style: Theme.of(context).textTheme.headline5),
              ListTile(title: Text("Pad"), leading: Icon(Mdi.paletteOutline), onTap: () {}),
              Divider(),
              ListTile(title: Text("Import"), leading: Icon(Mdi.import), onTap: () {})
            ])));
  }
}
