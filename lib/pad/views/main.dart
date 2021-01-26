import 'package:butterfly/pad/views/main/view.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'main/toolbar.dart';

class MainView extends StatefulWidget {
  final bool? expanded;
  final SplitView? view;
  final SplitWindow? window;

  const MainView({Key? key, this.expanded, this.view, this.window}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = widget.window == null || widget.view == null || widget.expanded == null;
    return Container(
        child: Hero(
            tag: 'main_view',
            child: Column(children: [
              MainViewViewport(),
              Container(
                  height: 44.0,
                  color: Theme.of(context).focusColor,
                  child: MainViewToolbar(
                      isMobile: isMobile,
                      expanded: widget.expanded,
                      view: widget.view,
                      window: widget.window))
            ])));
  }
}
