import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/tool.dart';
import 'package:equatable/equatable.dart';

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
    else if (event is SelectedChanged)
      yield* _mapSelectedChangedToState(event);
    else if (event is ToolChanged)
      yield* _mapToolChangedToState(event);
    else if (event is LayerChanged)
      yield* _mapLayerChangedToState(event);
    else if (event is ProjectChanged)
      yield* _mapProjectChangedToState(event);
    else if (event is ToggleGridView) yield* _mapToggleGridViewToState(event);
  }

  Stream<DocumentState> _mapToggleGridViewToState(ToggleGridView event) async* {
    if (state is DocumentLoadSuccess) {
      var last = (state as DocumentLoadSuccess);
      yield last.copyWith(gridView: !last.gridView);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapProjectChangedToState(ProjectChanged event) async* {
    if (state is DocumentLoadSuccess) {
      var last = (state as DocumentLoadSuccess);
      yield last.copyWith(
          document: last.document.copyWith(), currentSelectedPath: event.nextSelected);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapLayerCreatedToState(LayerCreated event) async* {
    if (state is DocumentLoadSuccess) {
      var current = (state as DocumentLoadSuccess);
      current.document.content.add(event.layer);
      yield current.copyWith(document: current.document.copyWith());
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

  Stream<DocumentState> _mapSelectedChangedToState(SelectedChanged event) async* {
    if (state is DocumentLoadSuccess) {
      yield (state as DocumentLoadSuccess).copyWith(currentSelectedPath: event.path);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapToolChangedToState(ToolChanged event) async* {
    if (state is DocumentLoadSuccess) {
      yield (state as DocumentLoadSuccess).copyWith(currentTool: event.tool);
      _saveDocument();
    }
  }

  Stream<DocumentState> _mapLayerChangedToState(LayerChanged event) async* {
    if (state is DocumentLoadSuccess) {
      yield (state as DocumentLoadSuccess)
          .copyWith(currentLayer: event.layer, unselectLayer: event.layer == null);
      _saveDocument();
    }
  }

  void _saveDocument() {}
}
