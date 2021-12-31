import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/layers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayersIntent extends Intent {
  final BuildContext context;

  const LayersIntent(this.context);
}

class LayersAction extends Action<LayersIntent> {
  LayersAction();

  @override
  Object? invoke(LayersIntent intent) {
    showDialog(
      context: intent.context,
      builder: (context) => BlocProvider.value(
          value: intent.context.read<DocumentBloc>(), child: LayersDialog()),
    );
  }
}
