import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InspectorView extends StatefulWidget {
  final SplitView? view;
  final SplitWindow? window;
  final bool? expanded;

  const InspectorView({Key? key, this.view, this.window, this.expanded}) : super(key: key);
  @override
  _InspectorViewState createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<DocumentBloc>(context);
    return Hero(
        tag: 'inspector_view',
        child: SplitScaffold(
            bloc: bloc,
            body: Container(
                alignment: Alignment.center,
                child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                  if (state is DocumentLoadSuccess && state.currentInspectorItem != null)
                    return Container(child: state.currentInspectorItem!.buildInspector(bloc));
                  else
                    return Text("No object selected");
                })),
            view: widget.view,
            window: widget.window,
            expanded: widget.expanded,
            title: 'Inspector',
            icon: MdiIcons.tuneVertical));
  }
}
