import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectorView extends StatefulWidget {
  final DocumentBloc bloc;
  const InspectorView({Key? key, required this.bloc}) : super(key: key);
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
    var bloc = widget.bloc;
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
                    if (state is DocumentLoadSuccess && state.currentInspectorItem != null)
                      return Container(child: state.currentInspectorItem!.buildInspector(bloc));
                    else
                      return Text("No object selected");
                  })),
              appBar: AppBar(title: Text('Inspector')))
    );
  }
}
