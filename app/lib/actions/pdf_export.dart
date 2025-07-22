import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/export/pdf.dart';

class PdfExportIntent extends Intent {
  final BuildContext context;
  final bool print;

  const PdfExportIntent(this.context, [this.print = false]);
}

class PdfExportAction extends Action<PdfExportIntent> {
  PdfExportAction();

  @override
  Future<void> invoke(PdfExportIntent intent) async {
    final context = intent.context;
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    var areas = <AreaPreset>[state.areaPreset];
    if (state.info.exportPresets.isNotEmpty) {
      final preset = await showDialog<ExportPreset>(
        context: intent.context,
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
          child: PdfExportDialog(areas: areas, print: intent.print),
        ),
        context: context,
      );
    }
  }
}
