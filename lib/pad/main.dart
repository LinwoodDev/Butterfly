import 'package:butterfly/models/elements/document.dart';
import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/views/main.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

import 'bloc/document_bloc.dart';
import 'dialogs/settings.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  AppDocument _document = AppDocument();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DocumentBloc(_document),
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 100,
                title: Column(children: [
                  Text(
                    "Title",
                  ),
                  BlocBuilder<DocumentBloc, AppDocument>(
                    builder: (context, state) {
                      return Text(state.name);
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
                      onPressed: _showProjectSettings),
                  IconButton(
                      icon: Icon(Mdi.link), tooltip: "Share (not implemented)", onPressed: null)
                ]),
            body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              bool isMobile = MediaQuery.of(context).size.width < 800;
              if (isMobile)
                return MainView(document: _document);
              else
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SplitView(
                        axis: Axis.horizontal,
                        second: SplitWindow(
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
                                          document: _document),
                                    ),
                                    second: SplitWindow(
                                        minSize: 100,
                                        builder: (BuildContext context, SplitView view,
                                                SplitWindow window, bool expanded) =>
                                            InspectorView(
                                                view: view, window: window, expanded: expanded)))),
                        first: SplitWindow(
                            builder: (BuildContext context, SplitView view, SplitWindow window,
                                    bool expanded) =>
                                MainView(
                                    view: view,
                                    window: window,
                                    expanded: expanded,
                                    document: _document))));
            })));
  }

  void _showProjectSettings() {
    showDialog(
        context: context,
        builder: (context) =>
            BlocProvider(create: (_) => AppDocumentCubit(_document), child: PadSettingsDialog()));
  }
}
