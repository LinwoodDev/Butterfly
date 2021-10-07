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
  final ToolType currentTool;
  final int currentPainterIndex;
  final Matrix4? transform;

  const DocumentLoadSuccess(this.document,
      {this.currentTool = ToolType.view,
      this.transform,
      this.documentIndex = 0,
      this.currentPainterIndex = 0});

  @override
  List<Object?> get props => [document, currentTool, transform, currentPainterIndex, documentIndex];

  Painter? get currentPainter {
    if (document.painters.isEmpty) {
      return null;
    }
    return document.painters[currentPainterIndex.clamp(0, document.painters.length - 1)];
  }

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      ToolType? currentTool,
      Matrix4? transform,
      int? currentPainterIndex,
      int? documentIndex}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentTool: currentTool ?? this.currentTool,
        transform: transform ?? this.transform,
        documentIndex: documentIndex ?? this.documentIndex,
        currentPainterIndex: currentPainterIndex ?? this.currentPainterIndex);
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
