import 'dart:ui' as ui;

import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly/helpers/element.dart' as element_helper;
import 'package:flutter/foundation.dart';
import 'package:pdfrx/pdfrx.dart';

Uint8List? _getDataFromSource((NoteData, String) message) =>
    element_helper.getDataFromSource(message.$1, message.$2);

class AssetService {
  final NoteData document;
  final Map<String, ui.Image> _images = {};
  final Map<String, Future<Uint8List?>> _dataCache = {};
  final Map<String, PdfDocument> _pdfDocumentCache = {};

  AssetService(this.document);

  Future<ui.Image?> getImage(String path, [NoteData? document]) async {
    if (_images.containsKey(path)) {
      return _images[path]!.clone();
    }
    document ??= this.document;
    return _importImage(path);
  }

  Future<ui.Image?> _importImage(String path) async {
    var data = await compute(_getDataFromSource, (document, path));
    if (data == null) return null;
    final codec = await ui.instantiateImageCodec(data);
    try {
      final frameInfo = await codec.getNextFrame();
      final image = frameInfo.image;
      _images[path] = image;
      return image.clone();
    } finally {
      codec.dispose();
    }
  }

  void invalidateImage(String path) {
    try {
      _images[path]?.dispose();
    } catch (_) {}
    _images.remove(path);
  }

  Future<Uint8List?> computeDataFromSource(
    String source, [
    NoteData? document,
  ]) {
    if (_dataCache.containsKey(source)) {
      return _dataCache[source]!;
    }
    document ??= this.document;
    final data = element_helper.computeDataFromSource(document, source);
    _dataCache[source] = data;
    return data;
  }

  void invalidateData(String source) {
    _dataCache.remove(source);
  }

  Future<PdfDocument?> getPdfDocument(
    String source, [
    NoteData? document,
  ]) async {
    if (_pdfDocumentCache.containsKey(source)) {
      return _pdfDocumentCache[source];
    }
    document ??= this.document;
    final data = await computeDataFromSource(source, document);
    if (data == null) return null;
    final pdfDocument = await PdfDocument.openData(data);
    _pdfDocumentCache[source] = pdfDocument;
    return pdfDocument;
  }

  void invalidatePdfDocument(String source) {
    _pdfDocumentCache.remove(source)?.dispose();
  }

  void invalidate(String source) {
    invalidateImage(source);
    invalidateData(source);
    invalidatePdfDocument(source);
  }

  void dispose() {
    _images.keys.toList().forEach(invalidateImage);
    _images.clear();
    _dataCache.clear();
    _pdfDocumentCache.keys.toList().forEach(invalidatePdfDocument);
    _pdfDocumentCache.clear();
  }
}
