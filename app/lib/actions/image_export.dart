
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/image_export.dart';
import 'package:flutter/material.dart';

class ImageExportIntent extends Intent {
  final BuildContext context;

  const ImageExportIntent(this.context);
}

class ImageExportAction extends Action<ImageExportIntent> {
  final DocumentBloc bloc;

  ImageExportAction(this.bloc);

  @override
  Future<void> invoke(ImageExportIntent intent) async {
    showDialog(
        builder: (context) => ImageExportDialog(
              bloc: bloc,
            ),
        context: intent.context);
  }
}
