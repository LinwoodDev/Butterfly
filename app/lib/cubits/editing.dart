import 'dart:ui';

import 'package:butterfly/models/elements/element.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditingCubit extends Cubit<Map<int, ElementLayer>> {
  Offset startOffset = Offset.zero;

  EditingCubit([ElementLayer? selected])
      : super(selected == null ? {} : {0: selected});

  ElementLayer? get currentMove => get(-1);

  void put(int pointer, ElementLayer layer) {
    if (!has(pointer)) {
      emit(Map<int, ElementLayer>.from(state)..[pointer] = layer);
    }
  }

  void move(ElementLayer layer) {
    if (!has(-1)) {
      startOffset = Offset.zero;
    }
    put(-1, layer);
  }

  void resetMove() => reset(-1);

  void getAndResetMove() => getAndReset(-1);

  bool get isMoving => has(-1);

  int? first() => state.entries.isEmpty ? null : state.entries.first.key;

  bool has(int pointer) => state.containsKey(pointer);

  ElementLayer? getAndReset(int pointer) {
    var value = get(pointer);
    reset(pointer);
    return value;
  }

  ElementLayer? get(int pointer) => state[pointer];

  void reset(int pointer) =>
      emit(Map<int, ElementLayer>.from(state)..remove(pointer));

  void resetAll() => emit({});

  void change(int pointer, ElementLayer layer) {
    if (has(pointer)) {
      emit(Map<int, ElementLayer>.from(state)..[pointer] = layer);
    }
  }

  void moveTo(Offset offset) {
    if (isMoving) {
      var deltaOffset = offset - startOffset;
      change(-1, currentMove!.moveBy(deltaOffset));
      startOffset = offset;
    }
  }
}
