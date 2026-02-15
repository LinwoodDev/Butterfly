import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../dialogs/export/pdf.dart';

class PdfExportIntent extends Intent {
  const PdfExportIntent();
}

final pdfExportShortcut = ShortcutDefinition(
  id: 'pdf_export',
  intent: const PdfExportIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyP,
    control: true,
    shift: true,
  ),
);

class PdfExportAction extends Action<PdfExportIntent> {
  final BuildContext context;

  PdfExportAction(this.context);

  @override
  Future<void> invoke(PdfExportIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    var areas = <AreaPreset>[state.areaPreset];
    if (state.info.exportPresets.isNotEmpty) {
      final preset = await showDialog<ExportPreset>(
        context: context,
        builder: (context) =>
            BlocProvider.value(value: bloc, child: const ExportPresetsDialog()),
      );
      if (preset == null) return;
      areas = preset.areas;
    }
    if (context.mounted) {
      return showDialog<void>(
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: PdfExportDialog(areas: areas),
        ),
        context: context,
      );
    }
  }
}
