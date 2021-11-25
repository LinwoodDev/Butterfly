import 'package:butterfly/models/elements/element.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditingCubit extends Cubit<Map<int, ElementLayer>> {
  EditingCubit([ElementLayer? selected])
      : super(selected == null ? {} : {0: selected});

  void put(int pointer, ElementLayer layer) {
    if (!has(pointer)) {
      emit(Map<int, ElementLayer>.from(state)..[pointer] = layer);
    }
  }

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
}
