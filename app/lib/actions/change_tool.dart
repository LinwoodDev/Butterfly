import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';

class ChangeToolIntent extends Intent {
  final BuildContext context;
  final int index;

  const ChangeToolIntent(this.context, this.index);
}

class ChangeToolAction extends Action<ChangeToolIntent> {
  ChangeToolAction();

  @override
  Future<void> invoke(ChangeToolIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    intent.context.read<CurrentIndexCubit>().changeTool(
      bloc,
      context: intent.context,
      index: intent.index,
    );
  }
}
