part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final int? documentIndex;
  final bool editMode;
  final int currentPainterIndex;

  const DocumentLoadSuccess(this.document,
      {this.editMode = true, this.documentIndex, this.currentPainterIndex = 0});

  @override
  List<Object?> get props =>
      [document, editMode, currentPainterIndex, documentIndex];

  Painter? get currentPainter {
    if (document.painters.isEmpty) {
      return null;
    }
    return document
        .painters[currentPainterIndex.clamp(0, document.painters.length - 1)];
  }

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      bool? editMode,
      int? currentPainterIndex,
      int? documentIndex}) {
    return DocumentLoadSuccess(document ?? this.document,
        editMode: editMode ?? this.editMode,
        documentIndex: documentIndex ?? this.documentIndex,
        currentPainterIndex: currentPainterIndex ?? this.currentPainterIndex);
  }

  Future<int> save() {
    return SharedPreferences.getInstance().then((prefs) {
      var documents = List<String>.from(prefs.getStringList('documents') ?? []);
      var content = jsonEncode(document.toJson());
      var index = documentIndex;
      if (documentIndex == null || documents.length <= documentIndex!) {
        index = documents.length;
        documents.add(content);
      } else {
        documents[documentIndex!] = content;
      }
      prefs.setStringList('documents', documents);
      return index!;
    });
  }
}

class DocumentLoadFailure extends DocumentState {}
