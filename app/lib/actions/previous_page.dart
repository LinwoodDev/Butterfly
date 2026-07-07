import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class PreviousPageIntent extends Intent {
  const PreviousPageIntent();
}

const previousPageShortcut = ShortcutDefinition(
  id: 'previous_page',
  intent: PreviousPageIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.pageUp),
);

class PreviousPageAction extends Action<PreviousPageIntent> {
  final BuildContext context;

  PreviousPageAction(this.context);

  @override
  void invoke(PreviousPageIntent intent) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;

    final pages = state.data.getPages(true);
    final index = pages.indexOf(state.pageName);
    if (index <= 0) return;

    bloc.add(PageChanged(pages[index - 1]));
  }
}
