import 'package:flutter_bloc/flutter_bloc.dart';

class SelectionCubit extends Cubit<dynamic> {
  SelectionCubit([dynamic selected]) : super(selected);

  void change(dynamic layer) => emit(layer);

  void reset() => emit(null);
}
