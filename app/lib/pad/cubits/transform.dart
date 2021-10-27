import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CameraTransform extends Equatable {
  final Offset position;
  final double size;

  const CameraTransform([this.position = Offset.zero, this.size = 1]);

  CameraTransform withPosition(Offset position) =>
      CameraTransform(position, size);
  CameraTransform withScale(double scale) =>
      CameraTransform(position, size * scale);
  CameraTransform withSize(double size) => CameraTransform(position, size);

  Offset localToGlobal(Offset local) => local / size - position;

  @override
  List<Object?> get props => [position, size];
}

class TransformCubit extends Cubit<CameraTransform> {
  TransformCubit() : super(const CameraTransform());

  void move(Offset delta) => emit(state.withPosition(state.position + delta));
  void scale(double scale) => emit(state.withScale(scale));
  void size(double size) => emit(state.withSize(size));
}
