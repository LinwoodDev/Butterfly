import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
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
    var transform = intent.context.read<TransformCubit>().state;
    var size = MediaQuery.of(intent.context).size;
    showDialog(
        builder: (context) => BlocProvider.value(
              value: bloc,
              child: ImageExportDialog(
                width: size.width.round(),
                height: size.height.round(),
                x: -transform.position.dx,
                y: -transform.position.dy,
                scale: transform.size,
              ),
            ),
        context: intent.context);
  }
}
