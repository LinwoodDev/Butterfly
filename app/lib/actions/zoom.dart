import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keybinder/keybinder.dart';

class ZoomIntent extends Intent {
  final bool reverse;

  const ZoomIntent({this.reverse = false});
}

const zoomInShortcut = ShortcutDefinition(
  id: 'zoom_in',
  intent: ZoomIntent(reverse: false),
  defaultActivator: SingleActivator(LogicalKeyboardKey.add, control: true),
);

const zoomOutShortcut = ShortcutDefinition(
  id: 'zoom_out',
  intent: ZoomIntent(reverse: true),
  defaultActivator: SingleActivator(LogicalKeyboardKey.minus, control: true),
);

class ZoomAction extends Action<ZoomIntent> {
  final BuildContext context;

  ZoomAction(this.context);

  @override
  void invoke(ZoomIntent intent) {
    final currentIndex = context.read<CurrentIndexCubit>().state;
    final viewport = currentIndex.cameraViewport;
    final center = Offset(
      (viewport.width ?? 0) / 2,
      (viewport.height ?? 0) / 2,
    );
    final transformCubit = currentIndex.transformCubit;
    transformCubit.size(
      transformCubit.state.size + (intent.reverse ? -0.1 : 0.1),
      center,
    );
  }
}
