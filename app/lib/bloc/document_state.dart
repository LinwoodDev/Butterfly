part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final String? path;
  final String currentLayer;
  final ui.Image? image;
  final List<PadElement> bakedElements;
  final List<String> invisibleLayers;
  final int? currentPainterIndex;

  List<PadElement> get elements => List<PadElement>.of(document.content)
      .where((element) => !invisibleLayers.contains(element.layer))
      .where((element) => !bakedElements.contains(element)).toList();

  const DocumentLoadSuccess(this.document,
      {this.path,
        this.image,
        this.bakedElements = const [],
      this.currentPainterIndex,
      this.currentLayer = '',
      this.invisibleLayers = const []});

  @override
  List<Object?> get props =>
      [document, currentPainterIndex, path, invisibleLayers];

  Painter? get currentPainter {
    if (document.painters.isEmpty || currentPainterIndex == null) {
      return null;
    }
    return document
        .painters[currentPainterIndex!.clamp(0, document.painters.length - 1)];
  }

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      bool? editMode,
      int? currentPainterIndex,
      String? path,
        ui.Image? image,
        List<PadElement>? bakedElements,
      String? currentLayer,
      bool removeCurrentPainterIndex = false,
      List<String>? invisibleLayers}) {
    return DocumentLoadSuccess(document ?? this.document,
        path: path ?? this.path,
        invisibleLayers: invisibleLayers ?? this.invisibleLayers,
        currentLayer: currentLayer ?? this.currentLayer,
        image: image ?? this.image,
        bakedElements: bakedElements ?? this.bakedElements,
        currentPainterIndex: removeCurrentPainterIndex
            ? null
            : currentPainterIndex ?? this.currentPainterIndex);
  }

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  Future<String> save() {
    if (path == null) {
      return DocumentFileSystem.fromPlatform()
          .importDocument(document)
          .then((value) => value.path);
    }
    return DocumentFileSystem.fromPlatform()
        .updateDocument(path!, document)
        .then((value) => value.path);
  }
}

class DocumentLoadFailure extends DocumentState {}
