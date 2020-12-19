import 'package:butterfly/models/elements/document.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/views/main.dart';
import 'package:butterfly/pad/views/project.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

import 'bloc/document_bloc.dart';
import 'dialogs/settings.dart';

class ProjectPage extends StatefulWidget {
  final AppDocument document = AppDocument();
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  // ignore: close_sinks
  DocumentBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = DocumentBloc(widget.document);
    WidgetsBinding.instance.addPostFrameCallback((_) => _showRootDialog());
  }

  void _showRootDialog() async {
    var document = (_bloc.state as DocumentLoadSuccess).document;
    if (document.root == null) {
      await showDialog(
          context: context, builder: (context) => CreateLayerDialog(documentBloc: _bloc));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _bloc,
        child: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: Column(children: [
                      Text(
                        "Title",
                      ),
                      BlocBuilder<DocumentBloc, DocumentState>(
                        builder: (context, state) {
                          return Text(
                              _bloc.state is DocumentLoadSuccess
                                  ? (_bloc.state as DocumentLoadSuccess).document.name
                                  : "Loading",
                              style: Theme.of(context).textTheme.subtitle1);
                        },
                      )
                    ]),
                    actions: [
                      IconButton(
                        icon: Icon(Mdi.undo),
                        tooltip: "Undo",
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Mdi.redo),
                        tooltip: "Redo",
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Mdi.cogOutline),
                          tooltip: "Project settings",
                          onPressed: () => _showProjectSettings(context)),
                      IconButton(
                          icon: Icon(Mdi.link), tooltip: "Share (not implemented)", onPressed: null)
                    ]),
                body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  bool isMobile = MediaQuery.of(context).size.width < 800 ||
                      MediaQuery.of(context).size.height < 600;
                  if (isMobile)
                    return MainView(documentBloc: _bloc);
                  else
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SplitView(
                            axis: Axis.horizontal,
                            second: SplitWindow(
                                border: false,
                                minSize: 200,
                                size: 250,
                                maxSize: 500,
                                builder: (BuildContext context, SplitView view, SplitWindow window,
                                        bool expanded) =>
                                    SplitView(
                                        axis: Axis.vertical,
                                        first: SplitWindow(
                                          minSize: 150,
                                          size: 250,
                                          builder: (context, view, window, expanded) => LayersView(
                                              view: view,
                                              window: window,
                                              expanded: expanded,
                                              documentBloc: _bloc),
                                        ),
                                        second: SplitWindow(
                                            minSize: 100,
                                            builder: (BuildContext context, SplitView view,
                                                    SplitWindow window, bool expanded) =>
                                                InspectorView(
                                                    documentBloc: _bloc,
                                                    view: view,
                                                    window: window,
                                                    expanded: expanded)))),
                            first: SplitWindow(
                                border: false,
                                builder: (BuildContext context, SplitView view, SplitWindow window, bool expanded) => SplitView(
                                    axis: Axis.vertical,
                                    second: SplitWindow(
                                        minSize: 150,
                                        size: 250,
                                        maxSize: 350,
                                        builder: (BuildContext context, SplitView view,
                                                SplitWindow window, bool expanded) =>
                                            ProjectView(view: view, window: window, expanded: expanded, documentBloc: _bloc)),
                                    first: SplitWindow(builder: (BuildContext context, SplitView view, SplitWindow window, bool expanded) => MainView(view: view, window: window, expanded: expanded, documentBloc: _bloc))))));
                }))));
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
