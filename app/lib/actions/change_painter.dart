import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/document_bloc.dart';

class ChangePainterIntent extends Intent {
  final BuildContext context;
  final int index;

  const ChangePainterIntent(this.context, this.index);
}

class ChangePainterAction extends Action<ChangePainterIntent> {
  ChangePainterAction();

  @override
  Future<void> invoke(ChangePainterIntent intent) async {
    final bloc = intent.context.read<DocumentBloc>();
    intent.context.read<CurrentIndexCubit>().changePainter(bloc, intent.index);
  }
}
