import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/transform.dart';
import '../dialogs/svg_export.dart';

class SvgExportIntent extends Intent {
  final BuildContext context;

  const SvgExportIntent(this.context);
}

class SvgExportAction extends Action<SvgExportIntent> {
  SvgExportAction();

  @override
  Future<void> invoke(SvgExportIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();
    var transform = intent.context.read<TransformCubit>().state;
    var size = MediaQuery.of(intent.context).size;
    showDialog(
        builder: (context) => BlocProvider.value(
              value: bloc,
              child: SvgExportDialog(
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
