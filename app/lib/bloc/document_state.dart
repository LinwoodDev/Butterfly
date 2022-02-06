part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

abstract class DocumentLoadSuccess extends DocumentState {
  AppDocument get document;
  final String currentLayer;
  final List<String> invisibleLayers;
  final BakedViewport? bakedViewport;
  final int? currentPainterIndex;

  const DocumentLoadSuccess(
      {this.bakedViewport,
      this.currentPainterIndex = 0,
      this.currentLayer = '',
      this.invisibleLayers = const []});

  @override
  List<Object?> get props =>
      [currentPainterIndex, invisibleLayers, bakedViewport];

  List<PadElement> get elements {
    return bakedViewport?.unbakedElements ?? document.content;
  }

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
      String? currentLayer,
      bool removeCurrentPainterIndex = false,
      List<String>? invisibleLayers,
      BakedViewport? bakedViewport,
      bool removeBakedViewport = false});

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  Future<String> save();
}

class AppDocumentLoadSuccess extends DocumentLoadSuccess {
  @override
  final AppDocument document;
  final String? path;

  const AppDocumentLoadSuccess(this.document,
      {this.path,
      BakedViewport? bakedViewport,
      int? currentPainterIndex = 0,
      String currentLayer = '',
      List<String> invisibleLayers = const []})
      : super(
            bakedViewport: bakedViewport,
            currentPainterIndex: currentPainterIndex,
            currentLayer: currentLayer,
            invisibleLayers: invisibleLayers);

  @override
  AppDocumentLoadSuccess copyWith(
          {AppDocument? document,
          bool? editMode,
          int? currentPainterIndex,
          String? path,
          String? currentLayer,
          bool removeCurrentPainterIndex = false,
          List<String>? invisibleLayers,
          BakedViewport? bakedViewport,
          bool removeBakedViewport = false}) =>
      AppDocumentLoadSuccess(document ?? this.document,
          path: path ?? this.path,
          invisibleLayers: invisibleLayers ?? this.invisibleLayers,
          currentLayer: currentLayer ?? this.currentLayer,
          bakedViewport:
              removeBakedViewport ? null : bakedViewport ?? this.bakedViewport,
          currentPainterIndex: removeCurrentPainterIndex
              ? null
              : currentPainterIndex ?? this.currentPainterIndex);

  @override
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

  @override
  List<Object?> get props =>
      [document, currentPainterIndex, invisibleLayers, bakedViewport, path];
}

class TemplateLoadSuccess extends DocumentLoadSuccess {
  final DocumentTemplate template;

  const TemplateLoadSuccess(this.template,
      {BakedViewport? bakedViewport,
      int? currentPainterIndex = 0,
      String currentLayer = '',
      List<String> invisibleLayers = const []})
      : super(
            bakedViewport: bakedViewport,
            currentPainterIndex: currentPainterIndex,
            currentLayer: currentLayer,
            invisibleLayers: invisibleLayers);

  @override
  TemplateLoadSuccess copyWith(
          {AppDocument? document,
          bool? editMode,
          int? currentPainterIndex,
          String? currentLayer,
          bool removeCurrentPainterIndex = false,
          List<String>? invisibleLayers,
          BakedViewport? bakedViewport,
          bool removeBakedViewport = false,
          DocumentTemplate? template}) =>
      TemplateLoadSuccess(
          (template ?? this.template).copyWith(document: document),
          invisibleLayers: invisibleLayers ?? this.invisibleLayers,
          currentLayer: currentLayer ?? this.currentLayer,
          bakedViewport:
              removeBakedViewport ? null : bakedViewport ?? this.bakedViewport,
          currentPainterIndex: removeCurrentPainterIndex
              ? null
              : currentPainterIndex ?? this.currentPainterIndex);

  @override
  // TODO: implement document
  AppDocument get document => throw UnimplementedError();

  @override
  Future<String> save() async {
    await TemplateFileSystem.fromPlatform().updateTemplate(template);
    return template.name;
  }
}

class DocumentLoadFailure extends DocumentState {}
