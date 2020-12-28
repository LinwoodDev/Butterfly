import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

class InspectorView extends StatefulWidget {
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  final DocumentBloc documentBloc;

  const InspectorView({Key key, this.view, this.window, this.expanded, this.documentBloc})
      : super(key: key);
  @override
  _InspectorViewState createState() => _InspectorViewState();
}

class _InspectorViewState extends State<InspectorView> {
  // ignore: close_sinks
  DocumentBloc _bloc;

  @override
  void initState() {
    _bloc = widget.documentBloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'inspector_view',
        child: SplitScaffold(
            bloc: _bloc,
            body: Container(
                alignment: Alignment.center,
                child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                  if (state is DocumentLoadSuccess && state.currentInspectorItem != null)
                    return Container(child: state.currentInspectorItem.buildInspector(_bloc));
                  else
                    return CircularProgressIndicator();
                })),
            view: widget.view,
            window: widget.window,
            expanded: widget.expanded,
            title: 'Inspector',
            icon: Icon(Mdi.tuneVertical)));
  }
}
