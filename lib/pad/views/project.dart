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
                floatingActionButton: FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _showNewSheet(context),
                    child: Icon(Mdi.plus),
                    tooltip: "New"),
                body: Builder(
                    builder: (context) => Container(
                        alignment: Alignment.center,
                        child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                          if (state is DocumentLoadSuccess && state.document.root != null) {
                            var document = state.document;
                            return ListView.builder(
                                itemCount: document.root.children.length,
                                itemBuilder: (BuildContext context, int index) => Builder(
                                    builder: (context) => document.root.children[index]
                                        .buildTile(context, document)));
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
