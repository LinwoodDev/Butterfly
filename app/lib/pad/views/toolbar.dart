import 'package:butterfly/models/tool.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/tool/edit.dart';
import 'package:butterfly/pad/tool/object.dart';
import 'package:butterfly/pad/tool/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectMode { add, replace, remove }

class MainViewToolbar extends StatefulWidget {
  final DocumentBloc bloc;
  const MainViewToolbar({Key? key, required this.bloc}) : super(key: key);

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
    return BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var current = state as DocumentLoadSuccess;

      Widget toolbar;
      switch (current.currentTool) {
        case ToolType.view:
          toolbar = ViewToolbar(bloc: widget.bloc);
          break;
        case ToolType.edit:
          toolbar = EditToolbar(bloc: widget.bloc);
          break;
        case ToolType.object:
          toolbar = ObjectToolbar(bloc: widget.bloc);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Align(
                alignment: Alignment.centerRight, child: SizedBox(height: 50, child: toolbar)),
          ),
        ],
      );
    });
  }
}
