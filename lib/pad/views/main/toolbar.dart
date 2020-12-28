import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectMode { add, replace, remove }

class MainViewToolbar extends StatefulWidget {
  final bool isMobile;
  final bool expanded;
  final SplitView view;
  final SplitWindow window;

  const MainViewToolbar({Key key, this.isMobile, this.expanded, this.view, this.window})
      : super(key: key);

  @override
  _MainViewToolbarState createState() => _MainViewToolbarState();
}

class _MainViewToolbarState extends State<MainViewToolbar> {
  void _toggleTool(Tool tool) {
    print("TEST");
    // ignore: close_sinks
    var bloc = BlocProvider.of<DocumentBloc>(context);
    bloc.add(ToolChanged(tool));
    bloc.add(InspectorChanged(tool));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var current = state as DocumentLoadSuccess;
      return ListView(scrollDirection: Axis.horizontal, shrinkWrap: true, children: [
        ...ToolType.values.map((e) {
          Tool tool = e.create();
          return IconButton(
              tooltip: tool.name,
              icon: Icon(tool.icon),
              onPressed: () => _toggleTool(tool),
              color:
                  current.currentTool?.type == tool.type ? Theme.of(context).primaryColor : null);
        }).toList(),
        if (current.currentTool != null) ...[
          VerticalDivider(),
          ...current.currentTool.buildOptions(
              context: context,
              expanded: widget.expanded,
              view: widget.view,
              window: widget.window,
              isMobile: widget.isMobile)
        ]
      ]);
    }));
  }
}
