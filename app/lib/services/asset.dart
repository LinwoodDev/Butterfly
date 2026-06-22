import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/services/logger.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly/helpers/element.dart' as element_helper;
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdfrx/pdfrx.dart';

Uint8List? _getDataFromSource((NoteData, String) message) =>
    element_helper.getDataFromSource(message.$1, message.$2);

class AssetService {
  final Map<String, Future<ui.Image?>> _images = {};
  final Map<String, Future<Uint8List?>> _dataCache = {};
  final Map<String, Future<PdfDocument?>> _pdfs = {};

  AssetService();

  Future<ui.Image?> getImage(String path, NoteData document) async {
    if (_images.containsKey(path)) {
      return _images[path]!.then((img) => img?.clone());
    }
    final future = _importImage(path, document);
    _images[path] = future;
    return await future.then((img) => img?.clone());
  }

  Future<ui.Image?> _importImage(String path, NoteData document) async {
    var data = await compute(_getDataFromSource, (document, path));
    if (data == null) return null;
    if (path.toLowerCase().endsWith('.svg')) {
      return _importSvgImage(data);
    }
    final codec = await ui.instantiateImageCodec(data);
    try {
      final frameInfo = await codec.getNextFrame();
      final image = frameInfo.image;
      return image;
    } finally {
      codec.dispose();
    }
  }

  Future<ui.Image?> _importSvgImage(Uint8List data) async {
    final pictureInfo = await vg.loadPicture(
      SvgStringLoader(utf8.decode(data)),
      null,
      clipViewbox: false,
    );
    try {
      final width = max(1, pictureInfo.size.width.ceil());
      final height = max(1, pictureInfo.size.height.ceil());
      return await pictureInfo.picture.toImage(width, height);
    } finally {
      pictureInfo.picture.dispose();
    }
  }

  Future<void> invalidateImage(String path) async {
    try {
      final imageFuture = _images.remove(path);
      if (imageFuture != null) {
        final image = await imageFuture;
        image?.dispose();
      }
    } catch (_) {}
    _images.remove(path);
  }

  Future<Uint8List?> computeDataFromSource(String source, NoteData document) {
    if (_dataCache.containsKey(source)) {
      return _dataCache[source]!;
    }
    final data = element_helper.computeDataFromSource(document, source);
    _dataCache[source] = data;
    return data;
  }

  void invalidateData(String source) {
    _dataCache.remove(source);
  }

  Future<PdfDocument?> getPdfDocument(String source, NoteData document) async {
    final cached = _pdfs[source];
    if (cached != null) return cached;
    final future = _loadPdfDocument(source, document);
    _pdfs[source] = future;
    try {
      return await future;
    } catch (error, stackTrace) {
      _pdfs.remove(source);
      talker.error('Failed to load PDF document $source', error, stackTrace);
      return null;
    }
  }

  Future<PdfDocument?> _loadPdfDocument(
    String source,
    NoteData document,
  ) async {
    final data = await computeDataFromSource(source, document);
    if (data == null) return null;
    final pdfDocument = await PdfDocument.openData(data);
    return pdfDocument;
  }

  Future<void> invalidatePdfDocument(String source) async {
    return _pdfs.remove(source)?.then((pdf) => pdf?.dispose());
  }

  Future<void> invalidate(String source) async {
    invalidateData(source);
    await invalidateImage(source);
    await invalidatePdfDocument(source);
  }

  Future<void> dispose() async {
    final imageFutures = _images.values.toList();
    _images.clear();
    _dataCache.clear();
    final pdfFutures = _pdfs.values.toList();
    _pdfs.clear();
    await Future.wait([
      ...imageFutures.map((future) async {
        final image = await future;
        image?.dispose();
      }),
      ...pdfFutures.map((future) async {
        final pdf = await future;
        await pdf?.dispose();
      }),
    ]);
  }
}
