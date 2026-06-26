import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class NextPageIntent extends Intent {
  const NextPageIntent();
}

const nextPageShortcut = ShortcutDefinition(
  id: 'next_page',
  intent: NextPageIntent(),
  defaultActivator: SingleActivator(LogicalKeyboardKey.pageDown),
);

class NextPageAction extends Action<NextPageIntent> {
  final BuildContext context;

  NextPageAction(this.context);

  @override
  void invoke(NextPageIntent intent) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;

    final pages = state.data.getPages(true);
    final index = pages.indexOf(state.pageName);
    if (index < 0 || index >= pages.length - 1) return;

    bloc.add(PageChanged(pages[index + 1]));
  }
}
