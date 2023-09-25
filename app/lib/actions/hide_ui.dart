import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HideUIIntent extends Intent {
  final BuildContext context;

  const HideUIIntent(this.context);
}

class HideUIAction extends Action<HideUIIntent> {
  HideUIAction();

  @override
  void invoke(HideUIIntent intent) {
    intent.context.read<CurrentIndexCubit>().toggleKeyboardHideUI();
  }
}
