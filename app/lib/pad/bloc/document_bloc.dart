import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/tool.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc(AppDocument document) : super(DocumentLoadSuccess(document));

  @override
  Stream<DocumentState> mapEventToState(
    DocumentEvent event,
  ) async* {
    if (event is DocumentNameChanged) {
      yield* _mapDocumentNameChangedToState(event);
    } else if (event is LayerCreated) {
      yield* _mapLayerCreatedToState(event);
    } else if (event is ToolChanged) {
      yield* _mapToolChangedToState(event);
    } else if (event is TransformChanged) {
      yield* _mapTransformChangedToState(event);
    } else if (event is EditingLayerChanged) {
      yield* _mapEditingLayerChangedToState(event);
    }
  }

  Stream<DocumentState> _mapEditingLayerChangedToState(EditingLayerChanged event) async* {
    if (state is DocumentLoadSuccess) {
      var current = (state as DocumentLoadSuccess);
      yield current.copyWith(currentEditLayer: event.editingLayer);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapLayerCreatedToState(LayerCreated event) async* {
    if (state is DocumentLoadSuccess) {
      var current = (state as DocumentLoadSuccess);
      yield current.copyWith(
          removeCurrentEditLayer: event.layer == null,
          document: current.document.copyWith(
              content: current.currentEditLayer == null && event.layer == null
                  ? current.document.content
                  : (List.from(current.document.content)
                    ..add(event.layer ?? current.currentEditLayer!))));
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapDocumentNameChangedToState(DocumentNameChanged event) async* {
    if (state is DocumentLoadSuccess) {
      var current = (state as DocumentLoadSuccess);
      yield current.copyWith(document: current.document.copyWith(name: event.name));
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapToolChangedToState(ToolChanged event) async* {
    if (state is DocumentLoadSuccess) {
      yield (state as DocumentLoadSuccess).copyWith(currentTool: event.tool);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapTransformChangedToState(TransformChanged event) async* {
    if (state is DocumentLoadSuccess) {
      var current = (state as DocumentLoadSuccess);
      yield current.copyWith(
        transform: event.transform,
      );
      _saveDocument();
    }
  }

  void _saveDocument() {}
}
