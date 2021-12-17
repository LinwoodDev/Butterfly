import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/image_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageExportIntent extends Intent {
  final BuildContext context;

  const ImageExportIntent(this.context);
}

class ImageExportAction extends Action<ImageExportIntent> {
  ImageExportAction();

  @override
  Future<void> invoke(ImageExportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    showDialog(
        builder: (context) => ImageExportDialog(
              bloc: bloc,
            ),
        context: intent.context);
  }
}
