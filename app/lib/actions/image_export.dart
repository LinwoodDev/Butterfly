import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/export/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class ImageExportIntent extends Intent {
  const ImageExportIntent();
}

final imageExportShortcut = ShortcutDefinition(
  id: 'image_export',
  intent: const ImageExportIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyE,
    control: true,
    alt: true,
    shift: true,
  ),
);

class ImageExportAction extends Action<ImageExportIntent> {
  final BuildContext context;

  ImageExportAction(this.context);

  @override
  Future<void> invoke(ImageExportIntent intent) async {
    var bloc = context.read<DocumentBloc>();
    var transform = context.read<TransformCubit>().state;
    return showDialog<void>(
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: GeneralExportDialog(
          preset: ExportTransformPreset.view,
          options: getDefaultImageExportOptions(context, transform: transform),
        ),
      ),
      context: context,
    );
  }
}
