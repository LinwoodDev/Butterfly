import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/models/area.dart';
import 'package:butterfly/models/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/parser.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dialogs/error.dart';
import '../dialogs/image_export.dart';
import '../dialogs/pages.dart';
import '../dialogs/pdf_export.dart';
import '../dialogs/svg_export.dart';
import '../models/converter.dart';
import '../models/document.dart';

class ImportService {
  final BuildContext context;

  ImportService(this.context, [String type = '', Object? data]) {
    _load(type, data);
  }

  Future<void> _load([String type = '', Object? data]) async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final location = state.location;
    if (!location.absolute || location.remote.isNotEmpty) return;
    Uint8List? bytes;
    if (data is Uint8List) {
      bytes = data;
    } else if (data is String) {
      bytes = Uint8List.fromList(utf8.encode(data));
    } else {
      bytes =
          await DocumentFileSystem.fromPlatform().loadAbsolute(location.path);
    }
    final fileType =
        type.isNotEmpty ? AssetFileType.values.byName(type) : location.fileType;
    // ignore: avoid_print
    print('ImportService._load: $fileType: $bytes');
    if (bytes == null || fileType == null) return;
    await import(fileType, location.fileName, bytes);
  }

  DocumentBloc get bloc => context.read<DocumentBloc>();

  Future<void> import(AssetFileType type, String name, Uint8List bytes) async {
    switch (type) {
      case AssetFileType.note:
        return importNote(bytes);
      case AssetFileType.image:
        return importImage(bytes);
      case AssetFileType.svg:
        return importSvg(bytes);
      case AssetFileType.pdf:
        return importPdf(bytes, Offset.zero, true);
      default:
        return Future.value();
    }
  }

  void importNote(Uint8List bytes) {
    final doc = const DocumentJsonConverter().fromJson(
      json.decode(
        String.fromCharCodes(bytes),
      ),
    );
    bloc.add(DocumentUpdated(doc));
  }

  Future<void> importImage(Uint8List bytes,
      [Offset position = Offset.zero]) async {
    var codec = await ui.instantiateImageCodec(bytes);
    var frame = await codec.getNextFrame();
    var image = frame.image.clone();

    var newBytes = await image.toByteData(format: ui.ImageByteFormat.png);
    var state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    _submit([
      ImageElement(
          height: image.height,
          width: image.width,
          layer: state.currentLayer,
          pixels: newBytes?.buffer.asUint8List() ?? Uint8List(0),
          position: position)
    ]);
  }

  Future<void> importSvg(Uint8List bytes,
      [Offset position = Offset.zero]) async {
    var contentString = String.fromCharCodes(bytes);
    final SvgParser parser = SvgParser();
    try {
      var document = await parser.parse(contentString,
          warningsAsErrors: true, key: contentString);
      final size = document.viewport.viewBox;
      var height = size.height, width = size.width;
      if (!height.isFinite) height = 0;
      if (!width.isFinite) width = 0;
      _submit([
        SvgElement(
          width: width,
          height: height,
          data: contentString,
          position: position,
        ),
      ]);
    } catch (e, stackTrace) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                error: e,
                stackTrace: stackTrace,
              ));
    }
  }

  Future<void> importPdf(Uint8List bytes,
      [Offset position = Offset.zero, bool createAreas = false]) async {
    final elements = <Uint8List>[];
    final localizations = AppLocalizations.of(context)!;
    await for (var page in Printing.raster(bytes)) {
      final png = await page.toPng();
      elements.add(png);
    }
    final callback = await showDialog<PageDialogCallback>(
        context: context, builder: (context) => PagesDialog(pages: elements));
    if (callback == null) return;
    final selectedElements = <ImageElement>[];
    final areas = <Area>[];
    var y = position.dx;
    await for (var page in Printing.raster(bytes,
        pages: callback.pages, dpi: PdfPageFormat.inch * callback.quality)) {
      final png = await page.toPng();
      final scale = 1 / callback.quality;
      final height = page.height;
      final width = page.width;
      selectedElements.add(ImageElement(
          height: height,
          width: width,
          pixels: png,
          constraints: ElementConstraints.scaled(scale),
          position: Offset(position.dx, y)));
      if (createAreas) {
        areas.add(Area(
          height: height * scale,
          width: width * scale,
          position: Offset(position.dx, y),
          name: localizations.pageIndex(areas.length + 1),
        ));
      }
      y += page.height;
    }
    if (createAreas) {
      bloc.add(AreasCreated(areas));
    }
    _submit(selectedElements);
  }

  Future<void> export() async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final location = state.location;
    final fileType = location.fileType;
    final viewport = context.read<CurrentIndexCubit>().state.cameraViewport;
    switch (fileType) {
      case AssetFileType.note:
        final data = json.encode(state.document.toJson());
        final bytes = Uint8List.fromList(data.codeUnits);
        DocumentFileSystem.fromPlatform().saveAbsolute(location.path, bytes);
        break;
      case AssetFileType.image:
        return showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc,
                child: ImageExportDialog(
                  height: viewport.height ?? 1000,
                  width: viewport.width ?? 1000,
                  scale: viewport.scale,
                  x: viewport.x,
                  y: viewport.y,
                )));
      case AssetFileType.pdf:
        return showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc,
                child: PdfExportDialog(
                    areas: state.document.getAreaNames().toList())));
      case AssetFileType.svg:
        return showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc,
                child: SvgExportDialog(
                    width: ((viewport.width ?? 1000) / viewport.scale).round(),
                    height:
                        ((viewport.height ?? 1000) / viewport.scale).round(),
                    x: viewport.x,
                    y: viewport.y)));
      default:
        return;
    }
  }

  void _submit(List<PadElement> elements) =>
      bloc.add(ElementsCreated(elements));
}
