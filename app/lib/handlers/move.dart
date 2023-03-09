import 'package:butterfly/handlers/handler.dart';
import 'package:flutter/material.dart';

abstract class GeneralMoveHandler<T> extends Handler<T> {
  bool _moved = false;

  GeneralMoveHandler(super.data);

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

class MoveHandler extends GeneralMoveHandler<void> {
  MoveHandler() : super(null);
}
