import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchIntent extends Intent {
  final BuildContext context;

  const SearchIntent(this.context);
}

class SearchAction extends Action<SearchIntent> {
  SearchAction();

  @override
  Future<void> invoke(SearchIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    showGeneralDialog(
      context: intent.context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          BlocProvider.value(
        value: bloc,
        child: const SearchDialog(),
      ),
      barrierDismissible: true,
      barrierLabel:
          MaterialLocalizations.of(intent.context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Animate the dialog from bottom to center
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.5),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
