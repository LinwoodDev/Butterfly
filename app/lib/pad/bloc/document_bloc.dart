import 'dart:convert';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:equatable/equatable.dart';
import 'package:replay_bloc/replay_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends ReplayBloc<DocumentEvent, DocumentState> {
  DocumentBloc(AppDocument document, int documentIndex, int fileVersion)
      : super(
            DocumentLoadSuccess(document, documentIndex: documentIndex, fileVersion: fileVersion)) {
    on<LayerCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(
            document: current.document
                .copyWith(content: (List.from(current.document.content)..add(event.layer)))));
        _saveDocument();
      }
    });
    on<LayerChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(
            document: current.document.copyWith(
                content: (List.from(current.document.content)..[event.index] = event.layer))));
        _saveDocument();
      }
    });
    on<LayersRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(
            document: current.document.copyWith(
                content: List.from(current.document.content)
                  ..removeWhere((element) => event.layers.contains(element)))));
        _saveDocument();
      }
    });
    on<DocumentDescriptorChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(
            document: current.document.copyWith(name: event.name, description: event.description)));
        _saveDocument();
      }
    });

    on<ToolChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        emit((state as DocumentLoadSuccess).copyWith(currentTool: event.tool));
      }
    });
    on<CurrentPainterChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        emit((state as DocumentLoadSuccess).copyWith(currentPainterIndex: event.painter));
        _saveDocument();
      }
    });
    on<PainterCreated>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        emit(current.copyWith(
            document: current.document
                .copyWith(painters: List.from(current.document.painters)..add(event.painter))));
        _saveDocument();
      }
    });
    on<PainterChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        emit(current.copyWith(
            document: current.document.copyWith(
                painters: List.from(current.document.painters)..[event.index] = event.painter)));
        _saveDocument();
      }
    });
    on<PainterRemoved>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        emit(current.copyWith(
            document: current.document
                .copyWith(painters: List.from(current.document.painters)..removeAt(event.index))));
        _saveDocument();
      }
    });
    on<PainterReordered>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        var painters = List<Painter>.from(current.document.painters);
        var oldIndex = event.oldIndex;
        var newIndex = event.newIndex;
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final item = painters.removeAt(oldIndex);
        painters.insert(newIndex, item);
        emit(current.copyWith(
            document: current.document.copyWith(painters: painters),
            currentPainterIndex: oldIndex == current.currentPainterIndex
                ? newIndex
                : newIndex == current.currentPainterIndex
                    ? oldIndex
                    : current.currentPainterIndex));
        _saveDocument();
      }
    });
    on<DocumentBackgroundChanged>((event, emit) async {
      if (state is DocumentLoadSuccess) {
        var current = state as DocumentLoadSuccess;
        emit(current.copyWith(
            document: current.document.copyWith(
                background: event.background, removeBackground: event.background == null)));
        _saveDocument();
      }
    });
  }

  Future<void> _saveDocument() async {
    if (state is DocumentLoadSuccess) {
      var current = state as DocumentLoadSuccess;
      await current.save();
    }
  }
}
