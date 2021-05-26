import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/models/project/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/create_item.dart';
import 'package:butterfly/pad/dialogs/path.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProjectView extends StatefulWidget {
  final SplitView? view;
  final SplitWindow? window;
  final bool? expanded;

  const ProjectView({Key? key, this.view, this.window, this.expanded}) : super(key: key);
  @override
  _ProjectViewState createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  List<String> history = [''];

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
            icon: PhosphorIcons.rowsLight,
            actions: [
              IconButton(
                  icon: Icon(PhosphorIcons.houseLight, size: 20),
                  tooltip: "Home",
                  onPressed: () {
                    _navigator.currentState!.popUntil((route) => route.isFirst);
                    history.clear();
                  }),
              IconButton(
                  icon: Icon(PhosphorIcons.arrowUpLight, size: 20),
                  tooltip: "Up",
                  onPressed: () {
                    if (_navigator.currentState!.canPop()) {
                      _navigator.currentState!.pop();
                      history.removeLast();
                    }
                  }),
              IconButton(
                  icon: Icon(PhosphorIcons.magnifyingGlassLight, size: 20),
                  tooltip: "Path",
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => FilePathDialog(
                          callback: (path) => _navigator.currentState!
                            ..push(MaterialPageRoute(
                                builder: (_) => _ProjectViewSystem(path: path)))))),
              IconButton(
                  icon: Icon(PhosphorIcons.arrowsCounterClockwiseLight, size: 20),
                  tooltip: "Reload",
                  onPressed: () => setState(() {})),
              VerticalDivider()
            ],
            floatingActionButton: FloatingActionButton(
                heroTag: null,
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                        value: bloc,
                        child: CreateIteMdiIconsalog(
                            parent: (bloc.state as DocumentLoadSuccess)
                                .document
                                .getFile(history.last) as FolderProjectItem?))),
                child: Icon(PhosphorIcons.plusLight),
                tooltip: "New"),
            body: Navigator(
                key: _navigator,
                onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => _ProjectViewSystem(history: history, path: '')))));
  }
}

class _ProjectViewSystem extends StatelessWidget {
  final List<String>? history;
  final String? path;

  const _ProjectViewSystem({Key? key, this.history, this.path}) : super(key: key);

  void _changeSelected(DocumentBloc bloc, DocumentLoadSuccess state, String currentPath) {
    bloc.add(SelectedChanged(currentPath));
    bloc.add(InspectorChanged(item: state.document.getFile(currentPath)!));
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<DocumentBloc>(context);
    return Container(
        alignment: Alignment.center,
        child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
          if (state is DocumentLoadSuccess) {
            var file = state.document.getFile(path!);
            if (file == null || !(file is FolderProjectItem))
              return Center(child: Text("Directory not found"));
            var folder = file;
            return SizedBox.expand(
                child: SingleChildScrollView(
                    child: Wrap(
                        children: folder.files.map((file) {
              var currentPath = path!.isNotEmpty ? path! + '/' : '';
              currentPath += file.name;
              return Card(
                  child: InkWell(
                      onLongPress: () => _changeSelected(bloc, state, currentPath),
                      onTap: () {
                        if (file is FolderProjectItem)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => _ProjectViewSystem(
                                      path: currentPath, history: history!..add(currentPath))));
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
