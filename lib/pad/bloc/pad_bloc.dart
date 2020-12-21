import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/project/pad.dart';
import 'package:equatable/equatable.dart';

part 'pad_event.dart';
part 'pad_state.dart';

class PadBloc extends Bloc<PadEvent, PadState> {
  PadBloc() : super(PadInitial());

  @override
  Stream<PadState> mapEventToState(
    PadEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
