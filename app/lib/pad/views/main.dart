import 'package:butterfly/models/tools/project.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/main/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main/toolbar.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late HeroController _heroController;
  @override
  void initState() {
    super.initState();
    _heroController = HeroController(createRectTween: _createRectTween);
  }

  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  GlobalKey<NavigatorState> _navigator = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var bloc = state as DocumentLoadSuccess;
      return Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Expanded(
                child: bloc.currentTool.type == ToolType.project
                    ? Navigator(
                        key: _navigator,
                        observers: [_heroController],
                        onGenerateRoute: (settings) =>
                            MaterialPageRoute(builder: (context) => ProjectView()))
                    : Hero(tag: 'main_view', child: MainViewViewport(bloc: bloc))),
            if (bloc.currentTool.type != ToolType.project)
              Container(
                  color: Theme.of(context).focusColor,
                  child:
                      Hero(tag: 'main_view_toolbar', child: MainViewToolbar(navigator: _navigator)))
          ]));
    }));
  }
}
