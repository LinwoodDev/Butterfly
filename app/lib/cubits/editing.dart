import 'dart:ui';

import 'package:butterfly/models/elements/element.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditingCubit extends Cubit<Map<int, PadElement>> {
  EditingCubit([PadElement? selected])
      : super(selected == null ? {} : {0: selected});

  PadElement? get currentMove => get(-1);

  void put(int pointer, PadElement layer) {
    if (!has(pointer)) {
      emit(Map<int, PadElement>.from(state)..[pointer] = layer);
    }
  }

  void move(PadElement layer) {
    put(-1, layer);
  }

  void resetMove() => reset(-1);

  PadElement? getAndResetMove() => getAndReset(-1);

  bool get isMoving => has(-1);

  int? first() => state.entries.isEmpty ? null : state.entries.first.key;

  bool has(int pointer) => state.containsKey(pointer);

  PadElement? getAndReset(int pointer) {
    var value = get(pointer);
    reset(pointer);
    return value;
  }

  PadElement? get(int pointer) => state[pointer];

  void reset(int pointer) =>
      emit(Map<int, PadElement>.from(state)..remove(pointer));

  void resetAll() => emit({});

  void change(int pointer, PadElement layer) {
    if (has(pointer)) {
      emit(Map<int, PadElement>.from(state)..[pointer] = layer);
    }
  }

  void moveTo(Offset offset) {
    if (isMoving) {
      var rect = currentMove!.rect;
      change(
          -1,
          currentMove!
              .moveTo(offset - Offset(rect.width / 2, rect.height / 2)));
    }
  }
}
