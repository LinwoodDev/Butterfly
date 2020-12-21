part of 'pad_bloc.dart';

abstract class PadState extends Equatable {
  const PadState();

  @override
  List<Object> get props => [];
}

class PadInitial extends PadState {}

class PadLoadSuccess extends PadState {
  final PadProjectItem pad;

  const PadLoadSuccess(this.pad);

  @override
  List<Object> get props => [pad];
}

class PadLoadFailure extends PadState {}
