import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/export/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class SvgExportIntent extends Intent {
  const SvgExportIntent();
}

final svgExportShortcut = ShortcutDefinition(
  id: 'svg_export',
  intent: const SvgExportIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyE,
    control: true,
    alt: true,
  ),
);

class SvgExportAction extends Action<SvgExportIntent> {
  final BuildContext context;

  SvgExportAction(this.context);

  @override
  Future<void> invoke(SvgExportIntent intent) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    showDialog<void>(
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: GeneralExportDialog(
          preset: ExportTransformPreset.view,
          options: getDefaultSvgExportOptions(context, transform: transform),
        ),
      ),
      context: context,
    );
  }
}
