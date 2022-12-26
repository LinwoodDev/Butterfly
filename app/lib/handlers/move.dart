import 'package:butterfly/handlers/handler.dart';
import 'package:flutter/material.dart';

class MoveHandler extends Handler<void> {
  MoveHandler() : super(null);

  bool _moved = false;

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final transformCubit = context.getTransformCubit();
    transformCubit.move(details.focalPointDelta / transformCubit.state.size);
    _moved = true;
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) {
    if (_moved) {
      context.bake();
    }
  }
}
