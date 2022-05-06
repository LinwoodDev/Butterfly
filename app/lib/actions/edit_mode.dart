import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditModeIntent extends Intent {
  final BuildContext context;

  const EditModeIntent(this.context);
}

class EditModeAction extends Action<EditModeIntent> {
  EditModeAction();

  @override
  void invoke(EditModeIntent intent) {
    var cubit = intent.context.read<CurrentIndexCubit>();
    cubit.reset();
  }
}
