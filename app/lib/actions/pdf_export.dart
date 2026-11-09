import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';

import '../dialogs/export/batch.dart';

class PdfExportIntent extends Intent {
  const PdfExportIntent();
}

const pdfExportShortcut = ShortcutDefinition(
  id: 'pdf_export',
  intent: PdfExportIntent(),
  defaultActivator: SingleActivator(
    LogicalKeyboardKey.keyP,
    control: true,
    shift: true,
  ),
);

class PdfExportAction extends Action<PdfExportIntent> {
  final BuildContext context;

  PdfExportAction(this.context);

  @override
  Future<void> invoke(PdfExportIntent intent) =>
      showExportDialog(context, format: .pdf);
}
