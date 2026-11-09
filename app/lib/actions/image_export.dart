import 'package:butterfly/dialogs/export/batch.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';

class ImageExportIntent extends Intent {
  const ImageExportIntent();
}

const imageExportShortcut = ShortcutDefinition(
  id: 'image_export',
  intent: ImageExportIntent(),
  defaultActivator: SingleActivator(
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
  Future<void> invoke(ImageExportIntent intent) => showExportDialog(context);
}
