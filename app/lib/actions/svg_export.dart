import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/export/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/transform.dart';

class SvgExportIntent extends Intent {
  final BuildContext context;

  const SvgExportIntent(this.context);
}

class SvgExportAction extends Action<SvgExportIntent> {
  SvgExportAction();

  @override
  Future<void> invoke(SvgExportIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    final transform = intent.context.read<TransformCubit>().state;
    showDialog<void>(
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: GeneralExportDialog(
          preset: ExportTransformPreset.view,
          options: getDefaultSvgExportOptions(context, transform: transform),
        ),
      ),
      context: intent.context,
    );
  }
}
