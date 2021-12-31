import 'package:butterfly/models/elements/element.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCubit extends Cubit<PadElement?> {
  SelectionCubit([PadElement? selected]) : super(selected);

  void change(PadElement? layer) => emit(layer);

  void reset() => emit(null);
}
