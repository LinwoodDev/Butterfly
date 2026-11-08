import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';

import 'package:archive/archive.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/helpers/pdf.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:pdfrx/pdfrx.dart';
import 'package:synchronized/synchronized.dart';

enum ExportFormat {
  png('image/png', 'public.png'),
  jpg('image/jpeg', 'public.jpeg'),
  webp('image/webp', 'org.webmproject.webp'),
  svg('image/svg+xml', 'public.svg-image'),
  pdf('application/pdf', 'com.adobe.pdf'),
  tiff('image/tiff', 'public.tiff'),
  gif('image/gif', 'com.compuserve.gif'),
  bmp('image/bmp', 'com.microsoft.bmp'),
  tga('image/x-tga', 'com.truevision.tga-image'),
  ico('image/vnd.microsoft.icon', 'com.microsoft.ico'),
  cur('image/x-icon', 'com.microsoft.cur'),
  pvr('image/x-pvr', 'public.data');

  const ExportFormat(this.mimeType, this.uniformTypeIdentifier);
  final String mimeType, uniformTypeIdentifier;
  String get label => this == webp ? 'WebP' : name.toUpperCase();
}

enum ExportRegion { view, page, area, custom }

enum ExportScope { view, page, area, allPages, pageAreas, allAreas }

/// An ordered export entry. Bounds belong to the entry, rendering settings can
/// be copied to other entries without replacing their regions.
class ExportItem {
  final String name, page;
  ExportRegion region;
  ExportOptions options;
  double rasterQuality;

  ExportItem(this.name, this.page, this.options, {this.region = .custom})
    : rasterQuality = options.toImageOptions().quality;

  ExportItem copy() =>
      ExportItem(name, page, options, region: region)
        ..rasterQuality = rasterQuality;
}

abstract class ExportSource {
  String get documentName;
  String get currentPage;
  List<ExportPreset> get presets;

  /// Display names and archive page IDs, in note order.
  List<(String, String)> get pages;
  ExportItem view();
  Future<ExportItem> page(String page);
  List<ExportItem> areas(String page);
  Future<Uint8List?> renderPng(ExportItem item, {bool preview = false});
  Future<String> renderSvg(ExportItem item);
  void savePreset(ExportPreset preset);
  void removePreset(String name);
  bool get canPin => false;
  void pin(ExportItem item) {}

  Future<List<ExportItem>> items(ExportScope scope) async => switch (scope) {
    .view => [view()],
    .page => [await page(currentPage)],
    .area || .pageAreas => areas(currentPage),
    .allPages => [for (final (_, id) in pages) await page(id)],
    .allAreas => [for (final (_, id) in pages) ...areas(id)],
  };

  List<ExportItem> fromPreset(ExportPreset preset) => [
    for (final entry in preset.areas)
      () {
        final id = entry.page.isEmpty
            ? currentPage
            : pages
                      .where((e) => e.$1 == entry.page || e.$2 == entry.page)
                      .firstOrNull
                      ?.$2 ??
                  entry.page;
        final area = entry.area;
        final ExportItem item;
        if (area != null) {
          item = ExportItem(
            entry.name,
            id,
            ImageExportOptions(
              width: area.width,
              height: area.height,
              x: area.position.x,
              y: area.position.y,
            ),
            region: .area,
          );
        } else {
          item =
              areas(id).where((e) => e.name == entry.name).firstOrNull ??
              (throw StateError('Area no longer exists: ${entry.name}'));
        }
        item.options = (entry.options ?? item.options)
            .toImageOptions()
            .copyWith(quality: entry.quality);
        item.rasterQuality = entry.quality;
        return item;
      }(),
  ];
}

/// Uses a snapshot so all entries in a batch see the same note, including the
/// active page's changes that have not yet been written to the archive.
class DocumentExportSource extends ExportSource {
  DocumentExportSource(this.bloc, this.state, this.viewOptions)
    : presets = List.of(state.info.exportPresets);

  final DocumentBloc bloc;
  final DocumentLoaded state;
  final ExportOptions viewOptions;
  final _lock = Lock();
  @override
  final List<ExportPreset> presets;
  @override
  String get documentName => state.metadata.name;
  @override
  String get currentPage => state.pageName;
  @override
  List<(String, String)> get pages {
    final entries = state.data.getPagesWithNames();
    return entries.any((e) => e.$2 == currentPage)
        ? entries
        : [...entries, (currentPage, currentPage)];
  }

  DocumentPage _page(String id) => id == currentPage
      ? state.page
      : state.data.getPage(id) ??
            (throw StateError('Page no longer exists: $id'));

  String _pageName(String id) =>
      pages.where((e) => e.$2 == id).firstOrNull?.$1 ?? id;

  @override
  ExportItem view() => ExportItem('', currentPage, viewOptions, region: .view);

  @override
  Future<ExportItem> page(String id) => _lock.synchronized(() async {
    final page = _page(id);
    CameraViewport? viewport;
    try {
      Rect? bounds;
      if (id == currentPage) {
        bounds = bloc.editorController.rendererCubit.getPageRect(
          invisibleLayers: state.invisibleLayers,
        );
      } else {
        viewport = await _viewport(page);
        for (final renderer in viewport.unbakedElements) {
          if (state.invisibleLayers.contains(renderer.layer)) continue;
          final rect = renderer.expandedRect;
          if (rect != null) bounds = bounds?.expandToInclude(rect) ?? rect;
        }
      }
      // Empty pages still have a useful export region.
      if (bounds == null || bounds.isEmpty) {
        bounds = Rect.fromLTWH(0, 0, viewOptions.width, viewOptions.height);
      }
      return ExportItem(
        _pageName(id),
        id,
        ImageExportOptions(
          width: math.max(1, bounds.width),
          height: math.max(1, bounds.height),
          x: bounds.left,
          y: bounds.top,
        ),
        region: .page,
      );
    } finally {
      _disposeViewport(viewport);
    }
  });

  @override
  List<ExportItem> areas(String id) => [
    for (final area in _page(id).areas)
      ExportItem(
        area.name,
        id,
        ImageExportOptions(
          width: area.width,
          height: area.height,
          x: area.position.x,
          y: area.position.y,
        ),
        region: .area,
      ),
  ];

  DocumentLoaded _renderState(String id, DocumentPage page) => id == currentPage
      ? state
      : DocumentLoadSuccess(
          state.data,
          page: page,
          pageName: id,
          info: state.info,
          metadata: state.metadata,
          assetService: state.assetService,
          fileSystem: state.fileSystem,
          windowCubit: state.windowCubit,
          absolute: state.absolute,
          invisibleLayers: state.invisibleLayers,
        );

  Future<CameraViewport> _viewport(DocumentPage page) => CameraViewport.build(
    bloc.editorController.transformCubit,
    state.data,
    state.assetService,
    page,
  );

  void _disposeViewport(CameraViewport? viewport) {
    if (viewport == null) return;
    for (final renderer in [
      ...viewport.backgrounds,
      ...viewport.unbakedElements,
    ]) {
      renderer.dispose();
    }
    viewport.disposeImages();
  }

  @override
  Future<Uint8List?> renderPng(ExportItem item, {bool preview = false}) =>
      _lock.synchronized(() async {
        final page = _page(item.page);
        CameraViewport? viewport;
        try {
          var options = item.options.toImageOptions();
          validateExportOptions(options);
          if (preview) {
            final side = math.max(
              options.width + options.padding.left + options.padding.right,
              options.height + options.padding.top + options.padding.bottom,
            );
            options = options.copyWith(
              quality: math.min(options.quality, 1000 / side),
            );
          }
          if (item.page != currentPage) viewport = await _viewport(page);
          final renderer = bloc.editorController.rendererCubit;
          // Keep the active-page path on its live viewport, including runtime assets.
          final bytes = viewport == null
              ? await renderer.render(
                  bloc.editorController,
                  state.data,
                  page,
                  state.info,
                  options,
                  invisibleLayers: state.invisibleLayers,
                  docState: _renderState(item.page, page),
                )
              : await renderer.render(
                  bloc.editorController,
                  state.data,
                  page,
                  state.info,
                  options,
                  cameraViewport: viewport,
                  invisibleLayers: state.invisibleLayers,
                  docState: _renderState(item.page, page),
                );
          return bytes?.buffer.asUint8List(
            bytes.offsetInBytes,
            bytes.lengthInBytes,
          );
        } finally {
          _disposeViewport(viewport);
        }
      });

  @override
  Future<String> renderSvg(ExportItem item) => _lock.synchronized(() async {
    validateExportOptions(item.options);
    final page = _page(item.page);
    CameraViewport? viewport;
    try {
      if (item.page != currentPage) viewport = await _viewport(page);
      final o = item.options;
      return bloc.editorController.rendererCubit
          .renderSVG(
            state.data,
            page,
            SvgExportOptions(
              width: o.width,
              height: o.height,
              x: o.x,
              y: o.y,
              scale: o.scale,
              rotation: o.rotation,
              padding: o.padding,
              renderBackground: o.renderBackground,
            ),
            cameraViewport: viewport,
            invisibleLayers: state.invisibleLayers,
          )
          .toXmlString();
    } finally {
      _disposeViewport(viewport);
    }
  });

  @override
  void savePreset(ExportPreset preset) {
    presets.add(preset);
    bloc.add(ExportPresetCreated(preset.name, preset.areas));
  }

  @override
  void removePreset(String name) {
    presets.removeWhere((e) => e.name == name);
    bloc.add(ExportPresetRemoved(name));
  }

  @override
  bool get canPin => true;
  @override
  void pin(ExportItem item) =>
      bloc.add(ToolCreated(ExportTool(options: item.options)));
}

void validateExportOptions(ExportOptions options) {
  final values = [
    options.width,
    options.height,
    options.x,
    options.y,
    options.scale,
    options.rotation,
    options.padding.top,
    options.padding.right,
    options.padding.bottom,
    options.padding.left,
    options.toImageOptions().quality,
  ];
  if (values.any((v) => !v.isFinite) ||
      options.width <= 0 ||
      options.height <= 0 ||
      options.scale <= 0 ||
      options.toImageOptions().quality <= 0) {
    throw const FormatException('Invalid export dimensions or resolution');
  }
}

/// Raster resolution is controlled by ExportOptions. Codec compression uses
/// sensible defaults and is deliberately separate from that resolution slider.
Uint8List encodeExportImage((Uint8List, ExportFormat) request) {
  final (png, format) = request;
  if (format == .png) return png;
  var image = img.decodePng(png);
  if (image == null) {
    throw const FormatException('Could not decode rendered image');
  }
  if (format == .jpg || format == .bmp) {
    final opaque = img.Image(
      width: image.width,
      height: image.height,
      numChannels: 3,
    );
    img.fill(opaque, color: img.ColorRgb8(255, 255, 255));
    img.compositeImage(opaque, image);
    image = opaque;
  }
  return switch (format) {
    .jpg => img.encodeJpg(image, quality: 90),
    .webp => img.encodeWebP(image),
    .tiff => img.encodeTiff(image),
    .gif => img.encodeGif(image),
    .bmp => img.encodeBmp(image),
    .tga => img.encodeTga(image),
    .ico => img.encodeIco(image),
    .cur => img.encodeCur(image),
    .pvr => img.encodePvr(image),
    _ => throw ArgumentError.value(
      format,
      'format',
      'Not a raster image format',
    ),
  };
}

class ExportOutput {
  const ExportOutput(
    this.bytes,
    this.fileName,
    this.mimeType,
    this.uniformTypeIdentifier,
  );
  final Uint8List bytes;
  final String fileName, mimeType, uniformTypeIdentifier;
}

String exportFileName(
  ExportSource source,
  List<ExportItem> items,
  ExportFormat format,
) {
  final multiple = items.length != 1 || format == .pdf;
  final name = multiple ? source.documentName : items.first.name;
  return '${sanitizeExportFileName(name.isEmpty ? source.documentName : name)}.${format != .pdf && items.length > 1 ? 'zip' : format.name}';
}

Future<ExportOutput> buildExport(
  ExportSource source,
  List<ExportItem> selection,
  ExportFormat format, {
  void Function(double progress)? onProgress,
}) async {
  if (selection.isEmpty) {
    throw const FormatException('No export entries selected');
  }
  final items = selection.map((e) => e.copy()).toList();
  for (final item in items) {
    validateExportOptions(item.options);
  }
  if (format == .pdf) return _buildPdf(source, items, onProgress);
  final files = <(String, Uint8List)>[];
  final names = <String>{};
  for (var i = 0; i < items.length; i++) {
    final item = items[i];
    final bytes = format == .svg
        ? Uint8List.fromList(utf8.encode(await source.renderSvg(item)))
        : await () async {
            final png = await source.renderPng(item);
            if (png == null) throw StateError('Could not render ${item.name}');
            return compute(encodeExportImage, (png, format));
          }();
    final base = sanitizeExportFileName(
      item.name.isEmpty ? source.documentName : item.name,
    );
    var name = '$base.${format.name}';
    var suffix = 2;
    while (!names.add(name.toLowerCase())) {
      name = '$base (${suffix++}).${format.name}';
    }
    files.add((name, bytes));
    onProgress?.call((i + 1) / items.length);
  }
  if (files.length == 1) {
    return ExportOutput(
      files.single.$2,
      exportFileName(source, items, format),
      format.mimeType,
      format.uniformTypeIdentifier,
    );
  }
  final zip = await compute(_zipExports, files);
  return ExportOutput(
    zip,
    exportFileName(source, items, format),
    'application/zip',
    'public.zip-archive',
  );
}

Uint8List _zipExports(List<(String, Uint8List)> files) {
  final archive = Archive();
  for (final (name, bytes) in files) {
    archive.add(ArchiveFile(name, bytes.length, bytes));
  }
  return Uint8List.fromList(ZipEncoder().encode(archive));
}

Future<ExportOutput> _buildPdf(
  ExportSource source,
  List<ExportItem> items,
  void Function(double)? onProgress,
) async {
  final pdf = await PdfDocument.createNew(
    sourceName: '${sanitizeExportFileName(source.documentName)}.pdf',
  );
  final imageDocuments = <PdfDocument>[];
  try {
    final pages = <PdfPage>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final png = await source.renderPng(item);
      if (png == null) throw StateError('Could not render ${item.name}');
      final jpeg = await compute(encodeExportImage, (png, ExportFormat.jpg));
      final o = item.options, p = o.padding;
      final doc = await PdfDocument.createFromJpegData(
        jpeg,
        sourceName: '${item.name}.jpg',
        width: canvasUnitsToPdfPoints(
          o.width + math.max(0, p.left) + math.max(0, p.right),
        ),
        height: canvasUnitsToPdfPoints(
          o.height + math.max(0, p.top) + math.max(0, p.bottom),
        ),
      );
      imageDocuments.add(doc);
      pages.addAll(doc.pages);
      onProgress?.call((i + 1) / items.length);
    }
    pdf.pages = pages;
    return ExportOutput(
      await pdf.encodePdf(),
      exportFileName(source, items, .pdf),
      ExportFormat.pdf.mimeType,
      ExportFormat.pdf.uniformTypeIdentifier,
    );
  } finally {
    await pdf.dispose();
    for (final doc in imageDocuments) {
      await doc.dispose();
    }
  }
}

Size exportPixelSize(ExportOptions o) => Size(
  ((o.width + math.max(0, o.padding.left) + math.max(0, o.padding.right)) *
          o.toImageOptions().quality)
      .ceilToDouble(),
  ((o.height + math.max(0, o.padding.top) + math.max(0, o.padding.bottom)) *
          o.toImageOptions().quality)
      .ceilToDouble(),
);
