import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class SplitScaffold extends StatelessWidget {
  final SplitView view;
  final SplitWindow window;
  final bool expanded;
  final String title;
  final Widget body;
  final Icon icon;
  final DocumentBloc bloc;
  final List<Widget> actions;
  final FloatingActionButton floatingActionButton;

  SplitScaffold(
      {this.view,
      this.window,
      this.expanded = true,
      @required this.title,
      @required this.body,
      this.icon,
      this.actions,
      this.bloc,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    bool isSplitted = window != null && view != null && expanded != null;
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Theme.of(context).accentColor,
            automaticallyImplyLeading: !isSplitted,
            title: Text(title),
            leading: icon,
            actions: [
              if (actions != null) ...actions,
              IconButton(
                  icon: Icon(!isSplitted || expanded ? Mdi.windowMinimize : Mdi.windowMaximize),
                  onPressed: !isSplitted || expanded
                      ? Navigator.of(context).pop
                      : () => window.expand(context, view, window))
            ]),
        floatingActionButton: floatingActionButton,
        body: body);
  }
}
