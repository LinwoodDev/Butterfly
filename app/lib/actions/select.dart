import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/current_index.dart';

class SelectAllIntent extends Intent {
  final BuildContext context;

  const SelectAllIntent(this.context);
}

class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction();

  @override
  Future<void> invoke(SelectAllIntent intent) async {
    final cubit = intent.context.read<CurrentIndexCubit>();
    if (cubit.getHandler() is SelectHandler) return;
    final bloc = intent.context.read<DocumentBloc>();
    final handler = await cubit.changeTemporaryHandler(
      intent.context,
      SelectTool(),
      bloc: bloc,
      temporaryClicked: true,
    );
    if (handler is! SelectHandler) return;
    handler.selectAll(bloc);
  }
}
