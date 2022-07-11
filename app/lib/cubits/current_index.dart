import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../handlers/handler.dart';
import '../models/painter.dart';

part 'current_index.freezed.dart';

@freezed
class CurrentIndex with _$CurrentIndex {
  const CurrentIndex._();
  const factory CurrentIndex(
      int index, Handler? handler, SettingsCubit settingsCubit,
      [@Default([]) List<Renderer> foregrounds,
      @Default([]) List<Rect> selections,
      @Default([]) List<int> pointers]) = _CurrentIndex;

  bool get moveEnabled =>
      settingsCubit.state.inputGestures && pointers.length > 1;
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit(SettingsCubit settingsCubit)
      : super(CurrentIndex(-1, null, settingsCubit)) {
    reset();
  }

  Handler getHandler() {
    var current = state.handler;
    if (current == null) {
      current = HandHandler(this);
      emit(CurrentIndex(-1, current, state.settingsCubit));
      return current;
    }
    return current;
  }

  void changeHandler(int index, Handler handler) =>
      emit(CurrentIndex(index, handler, state.settingsCubit));
  Handler? changePainter(DocumentBloc bloc, int index) {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.document;
    final currentArea = blocState.currentArea;
    final handler = Handler.fromBloc(this, bloc, index);
    emit(CurrentIndex(
        index,
        handler,
        state.settingsCubit,
        handler.createForegrounds(document, currentArea),
        handler.createSelections(document, currentArea)));
    return handler;
  }

  T? fetchHandler<T extends Handler>() {
    final handler = getHandler();
    if (handler is T) return handler;
    return null;
  }

  void refresh(DocumentBloc bloc) {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final document = blocState.document;
    final handler = state.handler;
    final currentArea = blocState.currentArea;
    if (!isClosed) {
      emit(state.copyWith(
          foregrounds: handler?.createForegrounds(document, currentArea) ?? [],
          selections: handler?.createSelections(document, currentArea) ?? []));
    }
  }

  Painter? getPainter(DocumentBloc bloc) {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.document;
    var index = state.index;
    if (document.painters.isEmpty ||
        index < 0 ||
        index >= document.painters.length) {
      return null;
    }
    return document.painters[index];
  }

  T? fetchPainter<T extends Painter>(DocumentBloc bloc) {
    final painter = getPainter(bloc);
    if (painter is T) return painter;
    return null;
  }

  void reset() {
    emit(CurrentIndex(-1, HandHandler(this), state.settingsCubit));
  }

  void changeIndex(int i) {
    emit(CurrentIndex(i, state.handler, state.settingsCubit));
  }

  void addPointer(int pointer) {
    emit(state.copyWith(pointers: state.pointers.toList()..add(pointer)));
  }

  void removePointer(int pointer) {
    emit(state.copyWith(pointers: state.pointers.toList()..remove(pointer)));
  }
}
