import 'dart:ffi' as ffi;
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/pdf_direct.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:ffi/ffi.dart';
import 'package:image/image.dart' as img;
import 'package:pdfrx/pdfrx.dart';
import 'package:perfect_freehand/perfect_freehand.dart' as freehand;
// ignore: implementation_imports
import 'package:pdfrx_engine/src/native/pdfium.dart' as pdfium_native;
import 'package:pdfium_dart/pdfium_dart.dart' as pdfium_bindings;

typedef _LayeredElement = ({PadElement element, String? layerId});

class _DirectPdfOverlayBitmap {
  final Uint8List bgraBytes;
  final int width;
  final int height;

  const _DirectPdfOverlayBitmap({
    required this.bgraBytes,
    required this.width,
    required this.height,
  });
}

class _DirectPdfPageSpec {
  final String pageName;
  final DocumentPage page;
  final Area area;
  final int? originalPageIndex;
  final List<PenElement> nativeInkPens;
  final List<_LayeredElement> overlayElements;
  _DirectPdfOverlayBitmap? overlayBitmap;

  _DirectPdfPageSpec({
    required this.pageName,
    required this.page,
    required this.area,
    required this.originalPageIndex,
    required this.nativeInkPens,
    required this.overlayElements,
  });

  bool get hasEdits => nativeInkPens.isNotEmpty || overlayBitmap != null;
}

class _PdfPointBounds {
  final double left;
  final double right;
  final double bottom;
  final double top;

  const _PdfPointBounds({
    required this.left,
    required this.right,
    required this.bottom,
    required this.top,
  });

  _PdfPointBounds inflate(double amount) => _PdfPointBounds(
    left: left - amount,
    right: right + amount,
    bottom: bottom - amount,
    top: top + amount,
  );

  _PdfPointBounds clampToPage(double width, double height) => _PdfPointBounds(
    left: left.clamp(0.0, width).toDouble(),
    right: right.clamp(0.0, width).toDouble(),
    bottom: bottom.clamp(0.0, height).toDouble(),
    top: top.clamp(0.0, height).toDouble(),
  );
}

Future<Uint8List?> buildDirectPdfBytes({
  required NoteData document,
  required DocumentInfo info,
  required AssetService assetService,
  required TransformCubit transformCubit,
  required Set<String> invisibleLayers,
  double overlayScale = 2.0,
}) async {
  final directPdfSource = _resolveDirectPdfSource(document);
  if (directPdfSource == null) {
    return null;
  }
  final sourceBytes = await assetService.computeDataFromSource(
    directPdfSource,
    document,
  );
  if (sourceBytes == null) {
    return null;
  }

  final originalDoc = await PdfDocument.openData(
    sourceBytes,
    sourceName: 'direct-pdf-source',
  );
  PdfDocument? rebuiltDoc;
  PdfDocument? blankDoc;
  final pageSpecs = _collectDirectPdfPageSpecs(document, invisibleLayers);
  final resolvedOverlayScale = max(1.0, overlayScale);

  try {
    await Future.wait(
      pageSpecs.map(
        (spec) => _prepareOverlayBitmap(
          spec,
          document: document,
          info: info,
          assetService: assetService,
          transformCubit: transformCubit,
          invisibleLayers: invisibleLayers,
          scale: resolvedOverlayScale,
        ),
      ),
    );

    final canEditInPlace = _canEditInPlace(pageSpecs, originalDoc.pages.length);
    final targetDoc = canEditInPlace
        ? originalDoc
        : (rebuiltDoc = await _buildReorderedPdfDocument(
            originalDoc,
            pageSpecs,
            onBlankDocumentCreated: (doc) => blankDoc = doc,
          ));

    if (targetDoc == null) {
      return null;
    }

    final changedPages = await _applyPageEdits(targetDoc, pageSpecs);
    if (changedPages.isNotEmpty) {
      await _reloadAllPdfPages(targetDoc);
    }
    if (!canEditInPlace) {
      // Freeze the reordered document onto its own page instances so the
      // final encode step doesn't re-import stale external source pages.
      targetDoc.pages = List<PdfPage>.of(targetDoc.pages);
    }

    return await targetDoc.encodePdf(incremental: canEditInPlace);
  } finally {
    await rebuiltDoc?.dispose();
    await blankDoc?.dispose();
    await originalDoc.dispose();
  }
}

String? _resolveDirectPdfSource(NoteData document) {
  for (final pageName in document.getPages(true)) {
    final page = document.getPage(pageName);
    if (page == null) continue;
    final element = _findDirectSourcePdfElement(page);
    if (element != null && element.source.isNotEmpty) {
      return element.source;
    }
  }
  return null;
}

List<_DirectPdfPageSpec> _collectDirectPdfPageSpecs(
  NoteData document,
  Set<String> invisibleLayers,
) {
  final specs = <_DirectPdfPageSpec>[];
  for (final pageName in document.getPages(true)) {
    final page = document.getPage(pageName);
    if (page == null) continue;
    final area = _resolveDirectPdfArea(page, pageName);
    if (area == null) continue;
    final sourcePdf = _findDirectSourcePdfElement(page);
    final originalPageIndex =
        sourcePdf?.extra[kPdfDirectOriginalPageKey] as int?;
    final nativeInkPens = <PenElement>[];
    final overlayElements = <_LayeredElement>[];

    for (final layer in page.layers) {
      final layerId = layer.id;
      if (layerId != null && invisibleLayers.contains(layerId)) {
        continue;
      }
      for (final element in layer.content) {
        if (element is PdfElement) {
          continue;
        }
        if (element is PenElement && _supportsNativeInk(element)) {
          nativeInkPens.add(element);
        } else {
          overlayElements.add((element: element, layerId: layerId));
        }
      }
    }

    specs.add(
      _DirectPdfPageSpec(
        pageName: pageName,
        page: page,
        area: area,
        originalPageIndex: originalPageIndex,
        nativeInkPens: nativeInkPens,
        overlayElements: overlayElements,
      ),
    );
  }
  return specs;
}

Area? _resolveDirectPdfArea(DocumentPage page, String fallbackName) {
  final initialArea = page.areas.firstWhereOrNull((area) => area.isInitial);
  if (initialArea != null) {
    return initialArea;
  }
  final pdf =
      _findDirectSourcePdfElement(page) ??
      page.content.whereType<PdfElement>().firstOrNull;
  if (pdf == null) {
    return page.areas.firstOrNull;
  }
  return Area(
    name: fallbackName,
    width: pdf.width,
    height: pdf.height,
    position: Point(pdf.position.x, pdf.position.y),
    isInitial: true,
  );
}

PdfElement? _findDirectSourcePdfElement(DocumentPage page) => page.content
    .whereType<PdfElement>()
    .firstWhereOrNull(_isDirectSourcePdfElement);

bool _isDirectSourcePdfElement(PdfElement element) =>
    element.extra[kPdfDirectOriginalPageKey] is int;

bool _supportsNativeInk(PenElement element) =>
    element.rotation == 0 &&
    element.property.fill.a == 0 &&
    element.property.color.a > 0 &&
    element.points.isNotEmpty;

bool _canEditInPlace(List<_DirectPdfPageSpec> pages, int originalPageCount) {
  if (pages.length != originalPageCount) {
    return false;
  }
  for (var i = 0; i < pages.length; i++) {
    if (pages[i].originalPageIndex != i) {
      return false;
    }
  }
  return true;
}

Future<PdfDocument?> _buildReorderedPdfDocument(
  PdfDocument originalDoc,
  List<_DirectPdfPageSpec> pageSpecs, {
  required void Function(PdfDocument document) onBlankDocumentCreated,
}) async {
  final blankSpecs = pageSpecs
      .where((spec) => spec.originalPageIndex == null)
      .toList();
  PdfDocument? blankDoc;
  if (blankSpecs.isNotEmpty) {
    blankDoc = await PdfDocument.createNew(sourceName: 'direct-pdf-blank');
    onBlankDocumentCreated(blankDoc);
    await _appendBlankPages(blankDoc, blankSpecs);
  }

  final rebuiltDoc = await PdfDocument.createNew(sourceName: 'direct-pdf-save');
  final pages = <PdfPage>[];
  var blankIndex = 0;
  for (final spec in pageSpecs) {
    final originalPageIndex = spec.originalPageIndex;
    if (originalPageIndex != null &&
        originalPageIndex >= 0 &&
        originalPageIndex < originalDoc.pages.length) {
      pages.add(originalDoc.pages[originalPageIndex]);
      continue;
    }
    if (blankDoc == null || blankIndex >= blankDoc.pages.length) {
      await rebuiltDoc.dispose();
      return null;
    }
    pages.add(blankDoc.pages[blankIndex]);
    blankIndex++;
  }

  rebuiltDoc.pages = pages;
  await rebuiltDoc.assemble();
  await _reloadAllPdfPages(rebuiltDoc);
  return rebuiltDoc;
}

Future<void> _appendBlankPages(
  PdfDocument document,
  List<_DirectPdfPageSpec> pageSpecs,
) async {
  await document.useNativeDocumentHandle((handle) {
    final nativeDocument = pdfium_bindings.FPDF_DOCUMENT.fromAddress(handle);
    for (var i = 0; i < pageSpecs.length; i++) {
      final spec = pageSpecs[i];
      final page = pdfium_native.pdfium.FPDFPage_New(
        nativeDocument,
        i,
        spec.area.width,
        spec.area.height,
      );
      if (page.address != 0) {
        pdfium_native.pdfium.FPDF_ClosePage(page);
      }
    }
  });
  await document.reloadPages();
}

Future<void> _reloadAllPdfPages(PdfDocument document) async {
  final pageCount = document.pages.length;
  if (pageCount <= 0) {
    return;
  }
  await document.reloadPages(
    pageNumbersToReload: List<int>.generate(pageCount, (index) => index + 1),
  );
}

Future<void> _prepareOverlayBitmap(
  _DirectPdfPageSpec pageSpec, {
  required NoteData document,
  required DocumentInfo info,
  required AssetService assetService,
  required TransformCubit transformCubit,
  required Set<String> invisibleLayers,
  required double scale,
}) async {
  if (pageSpec.overlayElements.isEmpty) {
    pageSpec.overlayBitmap = null;
    return;
  }

  pageSpec.overlayBitmap = await _renderOverlayBitmap(
    pageSpec,
    document: document,
    info: info,
    assetService: assetService,
    transformCubit: transformCubit,
    invisibleLayers: invisibleLayers,
    scale: scale,
  );
}

Future<_DirectPdfOverlayBitmap?> _renderOverlayBitmap(
  _DirectPdfPageSpec pageSpec, {
  required NoteData document,
  required DocumentInfo info,
  required AssetService assetService,
  required TransformCubit transformCubit,
  required Set<String> invisibleLayers,
  required double scale,
}) async {
  final outputWidth = max(1, (pageSpec.area.width * scale).ceil());
  final outputHeight = max(1, (pageSpec.area.height * scale).ceil());
  final renderers = <Renderer<PadElement>>[];

  try {
    for (final entry in pageSpec.overlayElements) {
      final renderer = Renderer<PadElement>.fromInstance(
        entry.element,
        entry.layerId,
      );
      await renderer.setup(
        transformCubit,
        document,
        assetService,
        pageSpec.page,
      );
      await _primeRendererAssets(
        renderer,
        document: document,
        assetService: assetService,
      );
      renderers.add(renderer);
    }

    if (renderers.isEmpty) {
      return null;
    }

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final transform = CameraTransform(
      1,
      pageSpec.area.position.toOffset(),
      scale,
    );
    final viewport = CameraViewport.unbaked(
      unbakedElements: renderers,
      visibleElements: renderers,
      visibleUnbakedElements: renderers,
      width: outputWidth.toDouble(),
      height: outputHeight.toDouble(),
      invisibleLayers: invisibleLayers,
    );
    final painter = ViewPainter(
      document,
      pageSpec.page,
      info,
      currentArea: pageSpec.area,
      invisibleLayers: invisibleLayers,
      renderBackground: false,
      renderBaked: false,
      renderBakedLayers: false,
      cameraViewport: viewport,
      transform: transform,
    );
    painter.paint(
      canvas,
      Size(outputWidth.toDouble(), outputHeight.toDouble()),
    );
    final picture = recorder.endRecording();
    late final ui.Image image;
    try {
      image = await picture.toImage(outputWidth, outputHeight);
    } finally {
      picture.dispose();
    }

    try {
      final bitmap = await _convertOverlayImage(image);
      if (!_hasVisibleAlpha(bitmap.bgraBytes)) {
        return null;
      }
      return bitmap;
    } finally {
      image.dispose();
    }
  } finally {
    for (final renderer in renderers) {
      renderer.dispose();
    }
  }
}

Future<void> _primeRendererAssets(
  Renderer<PadElement> renderer, {
  required NoteData document,
  required AssetService assetService,
}) async {
  if (renderer is ImageRenderer) {
    renderer.image ??= await assetService.getImage(
      renderer.element.source,
      document,
    );
    renderer.ownsImage = true;
    return;
  }
}

Future<_DirectPdfOverlayBitmap> _convertOverlayImage(ui.Image image) async {
  var bitmap = await convertFlutterUiToImage(image);
  if (bitmap.format != img.Format.uint8 || bitmap.numChannels != 4) {
    final command = img.Command()
      ..image(bitmap)
      ..convert(format: img.Format.uint8, numChannels: 4);
    final converted = await command.getImageThread();
    if (converted != null) {
      bitmap = converted;
    }
  }
  return _DirectPdfOverlayBitmap(
    bgraBytes: bitmap.getBytes(order: img.ChannelOrder.bgra),
    width: bitmap.width,
    height: bitmap.height,
  );
}

bool _hasVisibleAlpha(Uint8List bgraBytes) {
  for (var i = 3; i < bgraBytes.length; i += 4) {
    if (bgraBytes[i] != 0) {
      return true;
    }
  }
  return false;
}

Future<List<int>> _applyPageEdits(
  PdfDocument document,
  List<_DirectPdfPageSpec> pageSpecs,
) async {
  final changedPages = <int>[];
  await document.useNativeDocumentHandle((handle) {
    final nativeDocument = pdfium_bindings.FPDF_DOCUMENT.fromAddress(handle);
    for (var index = 0; index < pageSpecs.length; index++) {
      final spec = pageSpecs[index];
      if (!spec.hasEdits) {
        continue;
      }

      final page = pdfium_native.pdfium.FPDF_LoadPage(nativeDocument, index);
      if (page.address == 0) {
        continue;
      }

      var changed = false;
      try {
        for (final pen in spec.nativeInkPens) {
          changed = _appendInkAnnotation(page, spec, pen) || changed;
        }
        final overlay = spec.overlayBitmap;
        if (overlay != null) {
          changed =
              _insertOverlayBitmap(nativeDocument, page, spec, overlay) ||
              changed;
        }
      } finally {
        pdfium_native.pdfium.FPDF_ClosePage(page);
      }

      if (changed) {
        changedPages.add(index + 1);
      }
    }
  });
  return changedPages;
}

bool _appendInkAnnotation(
  pdfium_bindings.FPDF_PAGE page,
  _DirectPdfPageSpec spec,
  PenElement pen,
) {
  final pdfPoints = _buildPdfInkStrokePoints(spec.area, pen);
  if (pdfPoints.isEmpty) {
    return false;
  }
  final outlinePoints = _buildPdfInkOutlinePoints(spec.area, pen);

  return using((arena) {
    final pdfium = pdfium_native.pdfium;
    final annotation = pdfium.FPDFPage_CreateAnnot(
      page,
      pdfium_bindings.FPDF_ANNOT_INK,
    );
    if (annotation.address == 0) {
      return false;
    }

    try {
      final boundsPoints = outlinePoints.isNotEmpty ? outlinePoints : pdfPoints;
      final rect = _boundsForPoints(boundsPoints)
          .inflate(outlinePoints.isNotEmpty ? 1 : (_resolveInkWidth(pen) / 2 + 1))
          .clampToPage(spec.area.width, spec.area.height);
      final rectBuffer = arena<pdfium_bindings.FS_RECTF>();
      rectBuffer.ref
        ..left = rect.left
        ..bottom = rect.bottom
        ..right = rect.right
        ..top = rect.top;

      final pointsBuffer = arena<pdfium_bindings.FS_POINTF>(pdfPoints.length);
      for (var i = 0; i < pdfPoints.length; i++) {
        pointsBuffer[i]
          ..x = pdfPoints[i].dx
          ..y = pdfPoints[i].dy;
      }

      final color = pen.property.color;
      final width = _resolveInkWidth(pen);
      if (pdfium.FPDFAnnot_AddInkStroke(
            annotation,
            pointsBuffer,
            pdfPoints.length,
          ) <
          0) {
        return false;
      }
      pdfium.FPDFAnnot_SetRect(annotation, rectBuffer);
      pdfium.FPDFAnnot_SetBorder(annotation, 0, 0, width);
      pdfium.FPDFAnnot_SetColor(
        annotation,
        pdfium_bindings.FPDFANNOT_COLORTYPE.FPDFANNOT_COLORTYPE_Color,
        color.r,
        color.g,
        color.b,
        color.a,
      );

      final path = _createInkAppearancePath(
        outlinePoints: outlinePoints,
        strokePoints: pdfPoints,
        width: width,
        color: color,
      );
      if (path.address != 0) {
        final appended = pdfium.FPDFAnnot_AppendObject(annotation, path) != 0;
        if (appended) {
          pdfium.FPDFAnnot_UpdateObject(annotation, path);
        } else {
          pdfium.FPDFPageObj_Destroy(path);
        }
      }
      return true;
    } finally {
      pdfium.FPDFPage_CloseAnnot(annotation);
    }
  });
}

pdfium_bindings.FPDF_PAGEOBJECT _createInkAppearancePath(
  {
  required List<Offset> outlinePoints,
  required List<Offset> strokePoints,
  required double width,
  required SRGBColor color,
}) {
  if (outlinePoints.isNotEmpty) {
    return _createFilledInkAppearancePath(outlinePoints, color);
  }
  if (strokePoints.isEmpty) {
    return ffi.nullptr.cast<pdfium_bindings.fpdf_pageobject_t__>();
  }
  return _createStrokedInkAppearancePath(strokePoints, width, color);
}

pdfium_bindings.FPDF_PAGEOBJECT _createFilledInkAppearancePath(
  List<Offset> outlinePoints,
  SRGBColor color,
) {
  final pdfium = pdfium_native.pdfium;
  final path = pdfium.FPDFPageObj_CreateNewPath(
    outlinePoints.first.dx,
    outlinePoints.first.dy,
  );
  if (path.address == 0) {
    return path;
  }

  var current = outlinePoints.first;
  if (outlinePoints.length == 2) {
    pdfium.FPDFPath_LineTo(path, outlinePoints.last.dx, outlinePoints.last.dy);
  } else {
    for (var i = 1; i < outlinePoints.length - 1; i++) {
      final control = outlinePoints[i];
      final next = outlinePoints[i + 1];
      final end = Offset(
        (control.dx + next.dx) / 2,
        (control.dy + next.dy) / 2,
      );
      _addQuadraticBezierSegment(path, current, control, end);
      current = end;
    }
  }
  pdfium.FPDFPath_Close(path);
  pdfium.FPDFPath_SetDrawMode(
    path,
    pdfium_bindings.FPDF_FILLMODE_WINDING,
    0,
  );
  pdfium.FPDFPageObj_SetFillColor(path, color.r, color.g, color.b, color.a);
  return path;
}

pdfium_bindings.FPDF_PAGEOBJECT _createStrokedInkAppearancePath(
  List<Offset> strokePoints,
  double width,
  SRGBColor color,
) {
  final pdfium = pdfium_native.pdfium;
  final path = pdfium.FPDFPageObj_CreateNewPath(
    strokePoints.first.dx,
    strokePoints.first.dy,
  );
  if (path.address == 0) {
    return path;
  }

  final smoothPoints = _buildSmoothControlPoints(strokePoints);
  var current = smoothPoints.first;
  if (smoothPoints.length == 2) {
    pdfium.FPDFPath_LineTo(path, smoothPoints.last.dx, smoothPoints.last.dy);
  } else {
    for (var i = 1; i < smoothPoints.length - 1; i++) {
      final control = smoothPoints[i];
      final next = smoothPoints[i + 1];
      final end = Offset(
        (control.dx + next.dx) / 2,
        (control.dy + next.dy) / 2,
      );
      _addQuadraticBezierSegment(path, current, control, end);
      current = end;
    }
    pdfium.FPDFPath_LineTo(path, smoothPoints.last.dx, smoothPoints.last.dy);
  }
  pdfium.FPDFPath_SetDrawMode(path, pdfium_bindings.FPDF_FILLMODE_NONE, 1);
  pdfium.FPDFPageObj_SetStrokeColor(path, color.r, color.g, color.b, color.a);
  pdfium.FPDFPageObj_SetStrokeWidth(path, width);
  pdfium.FPDFPageObj_SetLineCap(path, pdfium_bindings.FPDF_LINECAP_ROUND);
  pdfium.FPDFPageObj_SetLineJoin(path, pdfium_bindings.FPDF_LINEJOIN_ROUND);
  return path;
}

void _addQuadraticBezierSegment(
  pdfium_bindings.FPDF_PAGEOBJECT path,
  Offset start,
  Offset control,
  Offset end,
) {
  final pdfium = pdfium_native.pdfium;
  final cubicControl1 = Offset(
    start.dx + (control.dx - start.dx) * (2 / 3),
    start.dy + (control.dy - start.dy) * (2 / 3),
  );
  final cubicControl2 = Offset(
    end.dx + (control.dx - end.dx) * (2 / 3),
    end.dy + (control.dy - end.dy) * (2 / 3),
  );
  pdfium.FPDFPath_BezierTo(
    path,
    cubicControl1.dx,
    cubicControl1.dy,
    cubicControl2.dx,
    cubicControl2.dy,
    end.dx,
    end.dy,
  );
}

double _resolveInkWidth(PenElement element) {
  final property = element.property;
  final averagePressure = element.points.isEmpty
      ? 1.0
      : element.points.fold<double>(0, (sum, point) => sum + point.pressure) /
            element.points.length;
  return max(
    0.5,
    property.strokeWidth + averagePressure * max(0.0, property.thinning),
  );
}

List<Offset> _buildPdfInkStrokePoints(Area area, PenElement element) {
  final centerlinePoints = _buildSmoothedCenterlinePoints(element);
  if (centerlinePoints.isEmpty) {
    return const [];
  }
  final sampledPoints = _sampleSmoothPolyline(
    centerlinePoints,
    spacing: max(0.75, min(2.0, element.property.strokeWidth / 3)),
  );
  return _toPdfOffsets(area, sampledPoints);
}

List<Offset> _buildPdfInkOutlinePoints(Area area, PenElement element) {
  final points = element.points;
  if (points.isEmpty) {
    return const [];
  }
  final currentZoom = element.zoom ?? kMaxZoom;
  final bounds = _boundsForPathPoints(points);
  final center = bounds.center;
  final property = element.property;
  var outlinePoints = freehand.getStroke(
    points
        .map((point) => point.scale(currentZoom, center))
        .map((point) => point.toFreehandPoint())
        .toList(),
    options: freehand.StrokeOptions(
      size: property.strokeWidth * currentZoom,
      thinning: property.thinning.clamp(0, 1),
      smoothing: property.smoothing.clamp(0, 1),
      streamline: property.streamline.clamp(.1, 1),
      simulatePressure: _shouldSimulatePressure(element),
    ),
  );
  outlinePoints = outlinePoints
      .map((point) => _scaleOffsetFromCenter(point, 1 / currentZoom, center))
      .toList();
  return _toPdfOffsets(area, outlinePoints);
}

List<Offset> _buildSmoothedCenterlinePoints(PenElement element) {
  final points = element.points;
  if (points.isEmpty) {
    return const [];
  }
  final currentZoom = element.zoom ?? kMaxZoom;
  final bounds = _boundsForPathPoints(points);
  final center = bounds.center;
  final property = element.property;
  final strokePoints = freehand.getStrokePoints(
    points
        .map((point) => point.scale(currentZoom, center))
        .map((point) => point.toFreehandPoint())
        .toList(),
    options: freehand.StrokeOptions(
      size: property.strokeWidth * currentZoom,
      thinning: property.thinning.clamp(0, 1),
      smoothing: property.smoothing.clamp(0, 1),
      streamline: property.streamline.clamp(.1, 1),
      simulatePressure: _shouldSimulatePressure(element),
    ),
  );
  return strokePoints
      .map(
        (strokePoint) => _scaleOffsetFromCenter(
          strokePoint.point,
          1 / currentZoom,
          center,
        ),
      )
      .toList();
}

bool _shouldSimulatePressure(PenElement element) {
  final points = element.points.skip(1).toList(growable: false);
  final pressure = points.firstOrNull?.pressure;
  return pressure == null || points.every((point) => point.pressure == pressure);
}

Rect _boundsForPathPoints(List<PathPoint> points) {
  final offsets = points.map((point) => point.toOffset()).toList(growable: false);
  return Rect.fromPoints(
    Offset(
      offsets.map((point) => point.dx).reduce(min),
      offsets.map((point) => point.dy).reduce(min),
    ),
    Offset(
      offsets.map((point) => point.dx).reduce(max),
      offsets.map((point) => point.dy).reduce(max),
    ),
  );
}

List<Offset> _sampleSmoothPolyline(
  List<Offset> points, {
  required double spacing,
}) {
  if (points.isEmpty) {
    return const [];
  }
  if (points.length == 1) {
    return [points.first, points.first.translate(0.01, 0.01)];
  }
  final path = Path()..moveTo(points.first.dx, points.first.dy);
  if (points.length == 2) {
    path.lineTo(points.last.dx, points.last.dy);
  } else {
    for (var i = 1; i < points.length - 1; i++) {
      final control = points[i];
      final next = points[i + 1];
      final end = Offset(
        (control.dx + next.dx) / 2,
        (control.dy + next.dy) / 2,
      );
      path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
    }
    path.lineTo(points.last.dx, points.last.dy);
  }

  final sampled = <Offset>[];
  for (final metric in path.computeMetrics()) {
    if (metric.length <= 0) {
      continue;
    }
    for (double offset = 0; offset < metric.length; offset += spacing) {
      final tangent = metric.getTangentForOffset(offset);
      if (tangent != null) {
        sampled.add(tangent.position);
      }
    }
    final endTangent = metric.getTangentForOffset(metric.length);
    if (endTangent != null) {
      sampled.add(endTangent.position);
    }
  }
  return _dedupeCloseOffsets(sampled);
}

List<Offset> _buildSmoothControlPoints(List<Offset> points) =>
    _dedupeCloseOffsets(points);

Offset _scaleOffsetFromCenter(Offset point, double zoom, Offset center) =>
    Offset(
      center.dx + (point.dx - center.dx) * zoom,
      center.dy + (point.dy - center.dy) * zoom,
    );

List<Offset> _dedupeCloseOffsets(List<Offset> points) {
  if (points.isEmpty) {
    return const [];
  }
  final deduped = <Offset>[points.first];
  for (final point in points.skip(1)) {
    if ((point - deduped.last).distance >= 0.25) {
      deduped.add(point);
    }
  }
  if (deduped.length == 1) {
    deduped.add(deduped.first.translate(0.01, 0.01));
  }
  return deduped;
}

List<Offset> _toPdfOffsets(Area area, List<Offset> points) {
  if (points.isEmpty) {
    return const [];
  }
  final converted = points
      .map((point) {
        final localX = point.dx - area.position.x;
        final localY = point.dy - area.position.y;
        return Offset(
          localX.clamp(0.0, area.width).toDouble(),
          (area.height - localY).clamp(0.0, area.height).toDouble(),
        );
      })
      .toList(growable: false);
  if (converted.length == 1) {
    final point = converted.first;
    return [point, point.translate(0.01, 0.01)];
  }
  return converted;
}

_PdfPointBounds _boundsForPoints(List<Offset> points) {
  if (points.isEmpty) {
    return const _PdfPointBounds(left: 0, right: 0, bottom: 0, top: 0);
  }

  var minX = points.first.dx;
  var maxX = points.first.dx;
  var minY = points.first.dy;
  var maxY = points.first.dy;

  for (final point in points.skip(1)) {
    minX = min(minX, point.dx);
    maxX = max(maxX, point.dx);
    minY = min(minY, point.dy);
    maxY = max(maxY, point.dy);
  }

  return _PdfPointBounds(left: minX, right: maxX, bottom: minY, top: maxY);
}

bool _insertOverlayBitmap(
  pdfium_bindings.FPDF_DOCUMENT nativeDocument,
  pdfium_bindings.FPDF_PAGE page,
  _DirectPdfPageSpec spec,
  _DirectPdfOverlayBitmap overlay,
) {
  final pdfium = pdfium_native.pdfium;
  final buffer = malloc<ffi.Uint8>(overlay.bgraBytes.length);
  try {
    buffer.asTypedList(overlay.bgraBytes.length).setAll(0, overlay.bgraBytes);
    final bitmap = pdfium.FPDFBitmap_CreateEx(
      overlay.width,
      overlay.height,
      pdfium_bindings.FPDFBitmap_BGRA,
      buffer.cast<ffi.Void>(),
      overlay.width * 4,
    );
    if (bitmap.address == 0) {
      return false;
    }

    try {
      final imageObject = pdfium.FPDFPageObj_NewImageObj(nativeDocument);
      if (imageObject.address == 0) {
        return false;
      }

      final pages = malloc<pdfium_bindings.FPDF_PAGE>();
      try {
        pages.value = page;
        if (pdfium.FPDFImageObj_SetBitmap(pages, 1, imageObject, bitmap) == 0) {
          pdfium.FPDFPageObj_Destroy(imageObject);
          return false;
        }
      } finally {
        malloc.free(pages);
      }

      pdfium.FPDFImageObj_SetMatrix(
        imageObject,
        spec.area.width,
        0,
        0,
        spec.area.height,
        0,
        0,
      );
      pdfium.FPDFPage_InsertObject(page, imageObject);
      return pdfium.FPDFPage_GenerateContent(page) != 0;
    } finally {
      pdfium.FPDFBitmap_Destroy(bitmap);
    }
  } finally {
    malloc.free(buffer);
  }
}
