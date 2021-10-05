import 'package:bloc/bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/tool.dart';
import 'package:butterfly/painter/painter.dart';
import 'package:butterfly/painter/pen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc(AppDocument document) : super(DocumentLoadSuccess(document)) {
    on<EditingLayerChanged>((event, emit) {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(currentEditLayer: event.editingLayer));
        _saveDocument();
      }
    });

    on<LayerCreated>((event, emit) {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(
            removeCurrentEditLayer: event.layer == null,
            document: current.document.copyWith(
                content: current.currentEditLayer == null && event.layer == null
                    ? current.document.content
                    : (List.from(current.document.content)
                      ..add(event.layer ?? current.currentEditLayer!)))));
        _saveDocument();
      }
    });
    on<LayersRemoved>((event, emit) {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(
            document: current.document.copyWith(
                content: List.from(current.document.content)
                  ..removeWhere((element) => event.layers.contains(element)))));
        _saveDocument();
      }
    });
    on<DocumentNameChanged>((event, emit) {
      if (state is DocumentLoadSuccess) {
        var current = (state as DocumentLoadSuccess);
        emit(current.copyWith(document: current.document.copyWith(name: event.name)));
        _saveDocument();
      }
    });

    on<ToolChanged>((event, emit) {
      if (state is DocumentLoadSuccess) {
        emit((state as DocumentLoadSuccess).copyWith(currentTool: event.tool));
        _saveDocument();
      }
    });

    on<TransformChanged>((event, emit) {
      if (state is DocumentLoadSuccess) {
        emit((state as DocumentLoadSuccess).copyWith(transform: event.transform));
        _saveDocument();
      }
    });
    on<EditOptionChanged>((event, emit) {
      if (state is DocumentLoadSuccess) {
        emit((state as DocumentLoadSuccess).copyWith(editOption: event.option));
        _saveDocument();
      }
    });
    on<PainterChanged>((event, emit) {
      if (state is DocumentLoadSuccess) {
        emit((state as DocumentLoadSuccess).copyWith(currentPainter: event.painter));
        _saveDocument();
      }
    });
  }

  void _saveDocument() {}
}
