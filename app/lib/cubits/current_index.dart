import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../handlers/handler.dart';
import '../models/painter.dart';

part 'current_index.freezed.dart';

@freezed
class CurrentIndex with _$CurrentIndex {
  const factory CurrentIndex(int index, Handler? handler,
      [@Default([]) List<Renderer> foregrounds,
      @Default([]) List<Rect> selections]) = _CurrentIndex;
}

class CurrentIndexCubit extends Cubit<CurrentIndex> {
  CurrentIndexCubit() : super(const CurrentIndex(-1, null)) {
    reset();
  }

  Handler getHandler() {
    var current = state.handler;
    if (current == null) {
      current = HandHandler(this);
      emit(CurrentIndex(-1, current));
      return current;
    }
    return current;
  }

  void changeHandler(int index, Handler handler) =>
      emit(CurrentIndex(index, handler));
  Handler? changePainter(DocumentBloc bloc, int index) {
    final handler = Handler.fromBloc(this, bloc, index);
    emit(CurrentIndex(index, handler));
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
    emit(CurrentIndex(-1, HandHandler(this)));
  }

  void changeIndex(int i) {
    emit(CurrentIndex(i, state.handler));
  }
}
