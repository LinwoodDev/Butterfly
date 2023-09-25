import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullScreenIntent extends Intent {
  final BuildContext context;

  const FullScreenIntent(this.context);
}

class FullScreenAction extends Action<FullScreenIntent> {
  FullScreenAction();

  @override
  void invoke(FullScreenIntent intent) {
    intent.context.read<SettingsCubit>().toggleFullScreen();
  }
}
