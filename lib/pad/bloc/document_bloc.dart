import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/elements/type.dart';
import 'package:butterfly/models/inspector.dart';
import 'package:butterfly/models/project/folder.dart';
import 'package:butterfly/models/project/pad.dart';
import 'package:butterfly/models/project/type.dart';
import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/models/tools/view.dart';
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
    else if (event is ItemCreated)
      yield* _mapItemCreatedToState(event);
    else if (event is SelectedChanged)
      yield* _mapSelectedChangedToState(event);
    else if (event is ToolChanged)
      yield* _mapToolChangedToState(event);
    else if (event is InspectorChanged)
      yield* _mapInspectorChangedToState(event);
    else if (event is LayerChanged)
      yield* _mapLayerChangedToState(event);
    else if (event is ProjectChanged)
      yield* _mapProjectChangedToState(event);
    else if (event is ItemCreated) yield* _mapItemCreatedToState(event);
  }

  Stream<DocumentState> _mapItemCreatedToState(ItemCreated event) async* {
    if (state is DocumentLoadSuccess) {
      var last = (state as DocumentLoadSuccess);
      print("event");
      print(event.parent!.addFile(event.item));
      yield last.copyWith(document: last.document.copyWith());
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
      if (current.currentPad != null) {
        if (event.parent == null)
          current.currentPad!.root = event.layer;
        else
          event.parent!.children.add(event.layer);
      }
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

  Stream<DocumentState> _mapInspectorChangedToState(InspectorChanged event) async* {
    if (state is DocumentLoadSuccess) {
      yield (state as DocumentLoadSuccess).copyWith(currentInspectorItem: event.item);
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
