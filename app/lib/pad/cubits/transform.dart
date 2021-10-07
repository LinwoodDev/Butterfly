import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransformCubit extends Cubit<Matrix4> {
  TransformCubit() : super(Matrix4.identity());
}
