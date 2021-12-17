import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editing.dart';
import 'package:butterfly/cubits/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewIntent extends Intent {
  final BuildContext context;

  const NewIntent(this.context);
}

class NewAction extends Action<NewIntent> {
  NewAction();

  @override
  Future<void> invoke(NewIntent intent) async {
    var bloc = intent.context.read<DocumentBloc>();

    bloc.clearHistory();
    intent.context.read<SelectionCubit>().reset();
    intent.context.read<EditingCubit>().resetAll();
    intent.context.read<TransformCubit>().reset();
    bloc.emit(DocumentLoadSuccess(AppDocument(
        name: await formatCurrentDateTime(
            intent.context.read<SettingsCubit>().state.locale),
        createdAt: DateTime.now(),
        palettes: ColorPalette.getMaterialPalette(intent.context))));
  }
}
