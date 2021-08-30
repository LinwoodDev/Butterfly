import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/dialogs/create_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/models/elements/type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LayersView extends StatefulWidget {
  final DocumentBloc bloc;
  const LayersView({Key? key, required this.bloc}) : super(key: key);
  @override
  _LayersViewState createState() => _LayersViewState();
}

class _LayersViewState extends State<LayersView> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var bloc = widget.bloc;
    return BlocProvider.value(
      value: bloc,
      child: Hero(
          tag: 'layers_view',
          child: Scaffold(
              appBar: AppBar(title: Text("Layers"), leading: Icon(PhosphorIcons.cubeLight)),
              floatingActionButton: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    showDialog(
                        builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: CreateLayerDialog(
                                parent: (bloc.state as DocumentLoadSuccess).document.root)),
                        context: context);
                  },
                  child: Icon(PhosphorIcons.plusLight),
                  tooltip: "Create layer"),
              body: Navigator(
                  onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) => Container(
                          alignment: Alignment.center,
                          child:
                              BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                            if (state is DocumentLoadSuccess && state.document.root != null) {
                              return ListView.builder(
                                  itemCount: state.document.root!.children.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var current = state.document.root!.children[index]!;
                                    return ListTile(
                                      title: Text(current.name!),
                                      subtitle: Text(current.type.name),
                                      leading: Icon(current.type.icon),
                                      selected: state.currentLayer == current,
                                      onTap: () => bloc.add(LayerChanged(
                                          state.currentLayer == current ? null : current)),
                                    );
                                  });
                            } else
                              return Text("No pad selected");
                          })))))),
    );
  }
}
