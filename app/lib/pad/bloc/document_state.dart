part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final int documentIndex;
  final bool editMode;
  final int fileVersion;
  final int currentPainterIndex;

  const DocumentLoadSuccess(this.document,
      {this.editMode = false,
      this.documentIndex = 0,
      this.currentPainterIndex = 0,
      required this.fileVersion});

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
        currentPainterIndex: currentPainterIndex ?? this.currentPainterIndex,
        fileVersion: fileVersion);
  }

  Future<void> save() {
    return SharedPreferences.getInstance().then((prefs) {
      var documents = List<String>.from(prefs.getStringList("documents") ?? []);
      var content = jsonEncode(document.toJson());
      if (documents.length <= documentIndex) {
        documents.add(content);
      } else {
        documents[documentIndex] = content;
      }
      prefs.setStringList('documents', documents);
    });
  }
}

class DocumentLoadFailure extends DocumentState {}
