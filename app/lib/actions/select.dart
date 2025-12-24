import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

import '../cubits/current_index.dart';

class SelectAllIntent extends Intent {
  const SelectAllIntent();
}

final selectAllShortcut = ShortcutDefinition(
  id: 'select_all',
  intent: const SelectAllIntent(),
  defaultActivator: const SingleActivator(
    LogicalKeyboardKey.keyA,
    control: true,
  ),
);

class SelectAllAction extends Action<SelectAllIntent> {
  final BuildContext context;

  SelectAllAction(this.context);

  @override
  Future<void> invoke(SelectAllIntent intent) async {
    final cubit = context.read<CurrentIndexCubit>();
    if (cubit.getHandler() is SelectHandler) return;
    final bloc = context.read<DocumentBloc>();
    final handler = await cubit.changeTemporaryHandler(
      context,
      SelectTool(),
      bloc: bloc,
      temporaryState: TemporaryState.removeAfterClick,
    );
    if (handler is! SelectHandler) return;
    handler.selectAll(bloc);
  }
}
