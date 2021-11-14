import 'package:butterfly/api/format_date_time.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/language.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewIntent extends Intent {
  final BuildContext context;

  const NewIntent(this.context);
}

class NewAction extends Action<NewIntent> {
  final DocumentBloc bloc;

  NewAction(this.bloc);

  @override
  Future<void> invoke(NewIntent intent) async {
    bloc.clearHistory();
    bloc.emit(DocumentLoadSuccess(AppDocument(
        name: await formatCurrentDateTime(
            intent.context.read<LanguageCubit>().state),
        createdAt: DateTime.now(),
        palettes: ColorPalette.getMaterialPalette(intent.context))));
  }
}
