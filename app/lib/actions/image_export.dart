import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/export/general.dart';
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
    return showDialog<void>(
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: GeneralExportDialog(
          preset: ExportTransformPreset.view,
          options: getDefaultImageExportOptions(context, transform: transform),
        ),
      ),
      context: intent.context,
    );
  }
}
