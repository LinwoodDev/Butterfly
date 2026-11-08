import 'package:butterfly/dialogs/export/batch.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';

class SvgExportIntent extends Intent {
  const SvgExportIntent();
}

const svgExportShortcut = ShortcutDefinition(
  id: 'svg_export',
  intent: SvgExportIntent(),
  defaultActivator: SingleActivator(
    LogicalKeyboardKey.keyE,
    control: true,
    alt: true,
  ),
);

class SvgExportAction extends Action<SvgExportIntent> {
  final BuildContext context;

  SvgExportAction(this.context);

  @override
  Future<void> invoke(SvgExportIntent intent) =>
      showExportDialog(context, format: .svg);
}
