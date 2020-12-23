import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';

class LayersView extends StatefulWidget {
  final DocumentBloc documentBloc;
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  const LayersView({Key key, this.documentBloc, this.view, this.window, this.expanded})
      : super(key: key);
  @override
  _LayersViewState createState() => _LayersViewState();
}

class _LayersViewState extends State<LayersView> {
  // ignore: close_sinks
  DocumentBloc _bloc;

  @override
  void initState() {
    _bloc = widget.documentBloc;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'layers_view',
        child: BlocProvider(
            create: (_) => _bloc,
            child: SplitScaffold(
                view: widget.view,
                window: widget.window,
                expanded: widget.expanded,
                title: "Layers",
                icon: Icon(Mdi.cubeOutline),
                floatingActionButton: FloatingActionButton(
                    heroTag: null,
                    onPressed: () => showDialog(
                        builder: (context) => CreateLayerDialog(
                            documentBloc: widget.documentBloc,
                            parent: (_bloc.state as DocumentLoadSuccess).currentPad.root),
                        context: context),
                    child: Icon(Mdi.plus),
                    tooltip: "Create layer"),
                body: Container(
                    alignment: Alignment.center,
                    child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                      if (state is DocumentLoadSuccess &&
                          state.currentPad != null &&
                          state.currentPad.root != null) {
                        return ListView.builder(
                            itemCount: state.currentPad.root.children.length,
                            itemBuilder: (BuildContext context, int index) => Builder(
                                builder: (context) => state.currentPad.root.children[index]
                                    .buildTile(context, state)));
                      } else
                        return CircularProgressIndicator();
                    })))));
  }
}
