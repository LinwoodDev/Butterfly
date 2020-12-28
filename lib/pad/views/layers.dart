import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/widgets/split/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdi/mdi.dart';
import 'package:butterfly/models/elements/type.dart';

class LayersView extends StatefulWidget {
  final SplitView view;
  final SplitWindow window;
  final bool expanded;

  const LayersView({Key key, this.view, this.window, this.expanded}) : super(key: key);
  @override
  _LayersViewState createState() => _LayersViewState();
}

class _LayersViewState extends State<LayersView> {
  // ignore: close_sinks
  DocumentBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'layers_view',
        child: SplitScaffold(
            bloc: _bloc,
            view: widget.view,
            window: widget.window,
            expanded: widget.expanded,
            title: "Layers",
            icon: Icon(Mdi.cubeOutline),
            floatingActionButton: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  if ((_bloc.state as DocumentLoadSuccess).currentPad != null)
                    showDialog(
                        builder: (context) => CreateLayerDialog(
                            parent: (_bloc.state as DocumentLoadSuccess).currentPad.root),
                        context: context);
                },
                child: Icon(Mdi.plus),
                tooltip: "Create layer"),
            body: Navigator(
                onGenerateRoute: (settings) => MaterialPageRoute(
                    builder: (context) => Container(
                        alignment: Alignment.center,
                        child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                          if (state is DocumentLoadSuccess &&
                              state.currentPad != null &&
                              state.currentPad.root != null) {
                            return ListView.builder(
                                itemCount: state.currentPad.root.children.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var current = state.currentPad.root.children[index];
                                  return ListTile(
                                    title: Text(current.name),
                                    subtitle: Text(current.type.getName()),
                                    leading: Icon(current.icon),
                                    selected: state.currentLayer == current,
                                    onTap: () => _bloc.add(LayerChanged(
                                        state.currentLayer == current ? null : current)),
                                  );
                                });
                          } else
                            return CircularProgressIndicator();
                        }))))));
  }
}
