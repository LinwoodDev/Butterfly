import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/views/main.dart';
import 'package:butterfly/pad/views/project.dart';
import 'package:butterfly/widgets/split/core.dart';
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
  late HeroController _heroController;
  final AppDocument document = AppDocument(name: "Document name");
  @override
  void initState() {
    super.initState();
    if (widget.id == null) {
      Modular.to.navigate("/");
    }
    _bloc = DocumentBloc(document);
    _heroController = HeroController(createRectTween: _createRectTween);
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showRootDialog());
  }

  void _showRootDialog() async {
    var pad = (_bloc.state as DocumentLoadSuccess).currentPad;
    if (pad != null && pad.root == null) {
      await showDialog(context: context, builder: (context) => CreateLayerDialog());
    }
  }

  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    var tools = ToolType.values.map((e) => e.create()).toList();
    return DefaultTabController(
      length: 4,
      child: BlocProvider(
          create: (_) => _bloc,
          child: Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                    if (_bloc.state is DocumentLoadSuccess) {
                      var current = _bloc.state as DocumentLoadSuccess;
                      return Column(children: [
                        if (current.currentSelectedPath != null)
                          Text(current.currentSelectedPath!,
                              style: Theme.of(context).textTheme.subtitle1),
                        Text(current.document.name)
                      ]);
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
              body: Navigator(
                  observers: [_heroController],
                  onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                            bool isMobile = MediaQuery.of(context).size.width < 800 ||
                                MediaQuery.of(context).size.height < 600;
                            if (isMobile)
                              return MainView(expanded: true);
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
                                          builder: (BuildContext context, SplitView? view, SplitWindow? window, bool expanded) =>
                                              SplitView(
                                                  axis: Axis.vertical,
                                                  first: SplitWindow(
                                                    minSize: 150,
                                                    size: 250,
                                                    builder: (context, view, window, expanded) =>
                                                        LayersView(
                                                            view: view,
                                                            window: window,
                                                            expanded: expanded),
                                                  ),
                                                  second: SplitWindow(
                                                      minSize: 100,
                                                      builder: (BuildContext context,
                                                              SplitView? view,
                                                              SplitWindow? window,
                                                              bool expanded) =>
                                                          InspectorView(
                                                              view: view,
                                                              window: window,
                                                              expanded: expanded)))),
                                      first: SplitWindow(
                                          border: false,
                                          builder: (BuildContext context, SplitView? view, SplitWindow? window, bool expanded) =>
                                              SplitView(
                                                  axis: Axis.vertical,
                                                  second: SplitWindow(
                                                      minSize: 150,
                                                      size: 250,
                                                      builder: (BuildContext context,
                                                              SplitView? view,
                                                              SplitWindow? window,
                                                              bool expanded) =>
                                                          ProjectView(view: view, window: window, expanded: expanded)),
                                                  first: SplitWindow(builder: (BuildContext context, SplitView? view, SplitWindow? window, bool expanded) => MainView(view: view, window: window, expanded: expanded))))));
                          }))))),
    );
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
