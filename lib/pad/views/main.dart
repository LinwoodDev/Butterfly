import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main/toolbar.dart';

class MainView extends StatefulWidget {
  final bool expanded;
  final SplitView view;
  final SplitWindow window;
  final DocumentBloc documentBloc;

  const MainView({Key key, this.expanded, this.view, this.window, this.documentBloc})
      : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // ignore: close_sinks
  DocumentBloc _bloc;

  @override
  void initState() {
    _bloc = widget.documentBloc;
    super.initState();
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    bool isMobile = widget.window == null || widget.view == null || widget.expanded == null;
    return Hero(
        tag: 'main_view',
        child: BlocProvider(
            create: (_) => _bloc,
            child: Scaffold(
                body: Container(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(child: Center(child: FlutterLogo(size: 256))),
              Container(
                  color: Theme.of(context).focusColor,
                  child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                          child: MainViewToolbar(
                              isMobile: isMobile,
                              documentBloc: _bloc,
                              expanded: widget.expanded,
                              view: widget.view,
                              window: widget.window))))
            ])))));
  }
}
