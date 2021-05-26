import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectMode { add, replace, remove }

class MainViewToolbar extends StatefulWidget {
  final bool? isMobile;
  final bool? expanded;
  final SplitView? view;
  final SplitWindow? window;

  const MainViewToolbar({Key? key, this.isMobile, this.expanded, this.view, this.window})
      : super(key: key);

  @override
  _MainViewToolbarState createState() => _MainViewToolbarState();
}

class _MainViewToolbarState extends State<MainViewToolbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var current = state as DocumentLoadSuccess;
      return BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) => (state as DocumentLoadSuccess).currentPad == null
              ? Container()
              : Container(
                  color: Theme.of(context).canvasColor,
                  child: Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            height: 50,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (current.currentTool != null)
                                    ...current.currentTool!.buildOptions(
                                        context: context,
                                        expanded: widget.expanded,
                                        view: widget.view,
                                        window: widget.window,
                                        isMobile: widget.isMobile)
                                ])),
                      ))));
    }));
  }
}
