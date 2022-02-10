import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/insert.dart';

class InsertIntent extends Intent {
  final BuildContext context;

  const InsertIntent(this.context);
}

class InsertAction extends Action<InsertIntent> {
  InsertAction();

  @override
  Future<dynamic> invoke(InsertIntent intent) {
    return showDialog(
      context: intent.context,
      builder: (context) => BlocProvider.value(
          value: intent.context.read<DocumentBloc>(),
          child: const InsertDialog()),
    );
  }
}
