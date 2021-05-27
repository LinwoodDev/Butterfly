import 'package:butterfly/models/tools/project.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/main/view.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  GlobalKey<NavigatorState> _navigator = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isMobile = widget.window == null || widget.view == null || widget.expanded == null;
    return Container(
        child: Hero(
            tag: 'main_view',
            child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
              var bloc = state as DocumentLoadSuccess;
              print(bloc.currentTool);
              return Scaffold(
                  body: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Container(
                        color: Theme.of(context).focusColor,
                        child: MainViewToolbar(
                            isMobile: isMobile,
                            expanded: widget.expanded,
                            view: widget.view,
                            window: widget.window,
                            navigator: _navigator)),
                    Expanded(
                        child: bloc.currentTool.type == ToolType.project
                            ? Navigator(
                                key: _navigator,
                                onGenerateRoute: (settings) =>
                                    MaterialPageRoute(builder: (context) => ProjectView()))
                            : MainViewViewport(bloc: bloc))
                  ]));
            })));
  }
}
