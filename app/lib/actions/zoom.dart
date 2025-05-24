import 'package:butterfly/cubits/current_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZoomIntent extends Intent {
  final BuildContext context;
  final bool reverse;

  const ZoomIntent(this.context, [this.reverse = false]);
}

class ZoomAction extends Action<ZoomIntent> {
  ZoomAction();

  @override
  void invoke(ZoomIntent intent) {
    final currentIndex = intent.context.read<CurrentIndexCubit>().state;
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
