import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:butterfly/models/elements/document.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc(AppDocument document) : super(DocumentLoadInProgress());

  @override
  Stream<DocumentState> mapEventToState(
    DocumentEvent event,
  ) async* {
    if (event is DocumentNameChanged) yield* _mapDocumentNameChangedToState(event);
  }

  Stream<DocumentState> _mapDocumentNameChangedToState(DocumentNameChanged event) async* {
    if (state is DocumentLoadSuccess) {
      final AppDocument updatedDocument = (state as DocumentLoadSuccess).document
        ..name = event.name;
      yield DocumentLoadSuccess(updatedDocument);
      _saveDocument(updatedDocument);
    }
  }

  void _saveDocument(AppDocument document) {}
}
