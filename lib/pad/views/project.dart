import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/models/project/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/create_item.dart';
import 'package:butterfly/pad/dialogs/path.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

class ProjectView extends StatefulWidget {
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  const ProjectView({Key key, this.view, this.window, this.expanded}) : super(key: key);
  @override
  _ProjectViewState createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  void initState() {
    super.initState();
  }

  BuildContext _systemContext;
  _ProjectViewSystem _system;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var bloc = BlocProvider.of<DocumentBloc>(context);
    return Hero(
        tag: 'project_view',
        child: SplitScaffold(
            bloc: bloc,
            view: widget.view,
            window: widget.window,
            expanded: widget.expanded,
            title: "Project",
            icon: Icon(Mdi.tableOfContents),
            actions: [
              IconButton(
                  icon: Icon(Mdi.homeOutline),
                  tooltip: "Home",
                  onPressed: () => Navigator.popUntil(_systemContext, (route) => route.isFirst)),
              IconButton(
                  icon: Icon(Mdi.arrowUp),
                  tooltip: "Up",
                  onPressed: () {
                    if (Navigator.canPop(_systemContext)) Navigator.pop(_systemContext);
                  }),
              IconButton(
                  icon: Icon(Mdi.magnify),
                  tooltip: "Path",
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => FilePathDialog(
                          callback: (path) =>
                              Navigator.of(_systemContext).push(MaterialPageRoute(builder: (_) {
                                _system = _ProjectViewSystem(path: path);
                                return _system;
                              }))))),
              IconButton(
                  icon: Icon(Mdi.reload), tooltip: "Reload", onPressed: () => setState(() {})),
              VerticalDivider()
            ],
            floatingActionButton: FloatingActionButton(
                heroTag: null,
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                        create: (_) => bloc,
                        child: CreateItemDialog(
                            parent: (bloc.state as DocumentLoadSuccess)
                                .document
                                .getFile(_system.path)))),
                child: Icon(Mdi.plus),
                tooltip: "New"),
            body: Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
                      _systemContext = context;
                      _system = _ProjectViewSystem();
                      return _system;
                    }))));
  }
}

class _ProjectViewSystem extends StatelessWidget {
  final String path;

  const _ProjectViewSystem({Key key, this.path = ''}) : super(key: key);

  void _changeSelected(DocumentBloc bloc, DocumentLoadSuccess state, String currentPath) {
    bloc.add(SelectedChanged(currentPath));
    bloc.add(InspectorChanged(state.document.getFile(currentPath)));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<DocumentBloc>(context);
    return Container(
        alignment: Alignment.center,
        child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
          if (state is DocumentLoadSuccess) {
            var file = state.document.getFile(path);
            if (file == null || !(file is FolderProjectItem))
              return Center(child: Text("Directory not found"));
            var folder = file as FolderProjectItem;
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
                                  builder: (context) => _ProjectViewSystem(path: currentPath)));
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
        }));
  }
}
