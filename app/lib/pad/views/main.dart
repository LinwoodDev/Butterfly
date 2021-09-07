import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/elements/text.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var tools = ToolType.values;
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
                body: LayoutBuilder(builder: (context, constraints) {
                  var isMobile = constraints.maxWidth < 600;
                  var toolbar = SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MainViewToolbar(),
                        ],
                      )));
                  Widget toolsSelection = Row(
                      mainAxisAlignment:
                          isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                          if (_bloc.state is DocumentLoadSuccess) {
                            var current = _bloc.state as DocumentLoadSuccess;
                            return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:
                                    Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                  ...tools.map((e) {
                                    IconData activeIcon, icon;
                                    switch (e) {
                                      case ToolType.view:
                                        icon = PhosphorIcons.handLight;
                                        activeIcon = PhosphorIcons.handFill;
                                        break;
                                      case ToolType.object:
                                        icon = PhosphorIcons.cursorLight;
                                        activeIcon = PhosphorIcons.cursorFill;
                                        break;
                                      case ToolType.edit:
                                        icon = PhosphorIcons.penLight;
                                        activeIcon = PhosphorIcons.penFill;
                                        break;
                                    }
                                    return IconButton(
                                      icon: Icon(current.currentTool == e ? activeIcon : icon,
                                          size: 26),
                                      color: current.currentTool == e
                                          ? Theme.of(context).colorScheme.primary
                                          : null,
                                      tooltip: e.toString(),
                                      onPressed: () {
                                        _bloc.add(ToolChanged(e));
                                      },
                                    );
                                  }).toList(),
                                  PopupMenuButton<ElementLayer>(
                                      itemBuilder: (context) => [TextElement()]
                                          .map((e) => PopupMenuItem<ElementLayer>(
                                              child: ListTile(
                                                  mouseCursor: MouseCursor.defer,
                                                  title: Text(e.toJson()["type"])),
                                              value: e))
                                          .toList(),
                                      icon: Icon(PhosphorIcons.plusLight, size: 26)),
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
                                  if (!isMobile) VerticalDivider()
                                ]));
                          } else
                            return Container();
                        }),
                        if (!isMobile) Flexible(child: toolbar)
                      ]);
                  if (isMobile)
                    toolsSelection = SingleChildScrollView(
                        scrollDirection: Axis.horizontal, child: toolsSelection);
                  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Container(
                      height: 75,
                      color: Theme.of(context).canvasColor,
                      padding: const EdgeInsets.all(12.0),
                      child: toolsSelection,
                    ),
                    Expanded(child: MainViewViewport(bloc: _bloc)),
                    if (isMobile) Align(alignment: Alignment.center, child: toolbar)
                  ]);
                }))));
  }

  void _showProjectSettings(bloc) {
    showDialog(context: context, builder: (context) => PadSettingsDialog(bloc: _bloc));
  }
}
