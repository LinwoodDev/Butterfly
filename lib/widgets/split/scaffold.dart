import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SplitScaffold extends StatelessWidget {
  final SplitView view;
  final SplitWindow window;
  final bool expanded;
  final String title;
  final Widget body;
  final FloatingActionButton floatingActionButton;

  SplitScaffold(
      {@required this.view,
      @required this.window,
      @required this.expanded,
      @required this.title,
      @required this.body,
      this.floatingActionButton});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(title),
          actions: [
            IconButton(
                icon: Icon(expanded ? MdiIcons.windowMinimize : MdiIcons.windowMaximize),
                onPressed: expanded
                    ? Navigator.of(context).pop
                    : () => window.expand(context, view, window))
          ],
        ),
        floatingActionButton: floatingActionButton,
        body: body);
  }
}
