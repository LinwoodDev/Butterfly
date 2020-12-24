import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/project/item.dart';
import 'package:butterfly/models/project/pad.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc(AppDocument document) : super(DocumentLoadSuccess(document));

  @override
  Stream<DocumentState> mapEventToState(
    DocumentEvent event,
  ) async* {
    if (event is DocumentNameChanged)
      yield* _mapDocumentNameChangedToState(event);
    else if (event is LayerCreated)
      yield* _mapLayerCreatedToState(event);
    else if (event is SelectedChanged) yield* _mapSelectedChangedToState(event);
  }

  Stream<DocumentState> _mapLayerCreatedToState(LayerCreated event) async* {
    if (state is DocumentLoadSuccess) {
      var current = (state as DocumentLoadSuccess);
      if (current.currentPad != null) current.currentPad.root = event.layer;
      yield DocumentLoadSuccess(current.document);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapDocumentNameChangedToState(DocumentNameChanged event) async* {
    if (state is DocumentLoadSuccess) {
      yield DocumentLoadSuccess((state as DocumentLoadSuccess).document..name = event.name);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapSelectedChangedToState(SelectedChanged event) async* {
    if (state is DocumentLoadSuccess) {
      var last = (state as DocumentLoadSuccess);
      yield DocumentLoadSuccess(last.document, currentSelectedPath: event.path);
      _saveDocument();
    }
  }

  void _saveDocument() {}
}
