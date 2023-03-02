import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/dialogs/confirmation.dart';
import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dialogs/error.dart';
import '../dialogs/image_export.dart';
import '../dialogs/pages.dart';
import '../dialogs/pdf_export.dart';
import '../dialogs/svg_export.dart';

class ImportService {
  final DocumentBloc bloc;
  final BuildContext context;

  ImportService(this.bloc, this.context);

  Future<void> load([String type = '', Object? data]) async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final location = state.location;
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
    if (bytes == null || fileType == null) return;
    await import(fileType, bytes);
  }

  Future<void> import(AssetFileType type, Uint8List bytes,
      {Offset? position, bool meta = true}) async {
    switch (type) {
      case AssetFileType.note:
        return importBfly(bytes, position, meta);
      case AssetFileType.image:
        return importImage(bytes, position);
      case AssetFileType.svg:
        return importSvg(bytes, position);
      case AssetFileType.pdf:
        return importPdf(bytes, position, true);
      default:
        return Future.value();
    }
  }

  void importBfly(Uint8List bytes, [Offset? position, bool meta = true]) {
    try {
      final data = json.decode(
        String.fromCharCodes(bytes),
      );
      final type = data['type'];
      switch (type) {
        case 'document':
          _importDocument(data, position, meta);
          break;
        case 'template':
          _importTemplate(data, position, meta);
          break;
        case 'pack':
          _importPack(data, position, meta);
          break;
        default:
          showDialog(
            context: context,
            builder: (context) => UnknownImportConfirmationDialog(
                message: AppLocalizations.of(context).unknownImportType),
          );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
  }

  void _importDocument(Map<String, dynamic> data,
      [Offset? position, bool meta = true]) {
    final firstPos = position ?? Offset.zero;
    final doc = const DocumentJsonConverter().fromJson(data);
    if (meta) {
      bloc.add(DocumentUpdated(doc));
    }
    final areas = doc.areas
        .map((e) => e.copyWith(position: e.position + firstPos.toPoint()))
        .toList();
    final content = doc.content
        .map((e) =>
            Renderer.fromInstance(e)
                .transform(position: firstPos, relative: true)
                ?.element ??
            e)
        .toList();
    bloc
      ..add(AreasCreated(areas))
      ..add(ElementsCreated(content));
  }

  Future<void> _importTemplate(Map<String, dynamic> data,
      [Offset? position, bool meta = true]) async {
    final template = const TemplateJsonConverter().fromJson(data);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          TemplateImportConfirmationDialog(template: template),
    );
    if (result != true) return;
    if (context.mounted) {
      context.read<TemplateFileSystem>().updateTemplate(template);
    }
  }

  Future<void> _importPack(Map<String, dynamic> data,
      [Offset? position, bool meta = true]) async {
    final pack = const PackJsonConverter().fromJson(data);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PackImportConfirmationDialog(pack: pack),
    );
    if (result != true) return;
    if (context.mounted) {
      context.read<PackFileSystem>().updatePack(pack);
    }
  }

  Future<void> importImage(Uint8List bytes, [Offset? position]) async {
    try {
      final firstPos = position ?? Offset.zero;
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image.clone();

      final newBytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final state = bloc.state;
      if (state is! DocumentLoadSuccess) return;
      _submit(elements: [
        ImageElement(
            height: image.height.toDouble(),
            width: image.width.toDouble(),
            layer: state.currentLayer,
            pixels: newBytes?.buffer.asUint8List() ?? Uint8List(0),
            position: firstPos.toPoint())
      ], choosePosition: position == null);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
  }

  Future<void> importSvg(Uint8List bytes, [Offset? position]) async {
    try {
      final firstPos = position ?? Offset.zero;
      final contentString = String.fromCharCodes(bytes);
      try {
        var document =
            await vg.loadPicture(SvgStringLoader(contentString), null);
        final size = document.size;
        var height = size.height, width = size.width;
        if (!height.isFinite) height = 0;
        if (!width.isFinite) width = 0;
        _submit(elements: [
          SvgElement(
            width: width,
            height: height,
            data: contentString,
            position: firstPos.toPoint(),
          ),
        ], choosePosition: position == null);
      } catch (e, stackTrace) {
        showDialog<void>(
            context: context,
            builder: (context) => ErrorDialog(
                  error: e,
                  stackTrace: stackTrace,
                ));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
  }

  Future<void> importPdf(Uint8List bytes,
      [Offset? position, bool createAreas = false]) async {
    try {
      final firstPos = position ?? Offset.zero;
      final elements = <Uint8List>[];
      final localizations = AppLocalizations.of(context);
      await for (var page in Printing.raster(bytes)) {
        final png = await page.toPng();
        elements.add(png);
      }
      if (context.mounted) {
        final callback = await showDialog<PageDialogCallback>(
            context: context,
            builder: (context) => PagesDialog(pages: elements));
        if (callback == null) return;
        final selectedElements = <ImageElement>[];
        final areas = <Area>[];
        var y = firstPos.dx;
        await for (var page in Printing.raster(bytes,
            pages: callback.pages,
            dpi: PdfPageFormat.inch * callback.quality)) {
          final png = await page.toPng();
          final scale = 1 / callback.quality;
          final height = page.height;
          final width = page.width;
          selectedElements.add(ImageElement(
              height: height.toDouble(),
              width: width.toDouble(),
              pixels: png,
              constraints:
                  ElementConstraints.scaled(scaleX: scale, scaleY: scale),
              position: Point(firstPos.dx, y)));
          if (createAreas) {
            areas.add(Area(
              height: height * scale,
              width: width * scale,
              position: Point(firstPos.dx, y),
              name: localizations.pageIndex(areas.length + 1),
            ));
          }
          if (createAreas) {
            bloc.add(AreasCreated(areas));
          }
        }
        _submit(
          elements: selectedElements,
          areas: createAreas ? areas : [],
          choosePosition: position == null,
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
  }

  Future<void> export() async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final location = state.location;
    final fileType = location.fileType;
    final viewport = context.read<CurrentIndexCubit>().state.cameraViewport;
    switch (fileType) {
      case AssetFileType.note:
        final data =
            json.encode(const DocumentJsonConverter().toJson(state.document));
        final bytes = Uint8List.fromList(data.codeUnits);
        DocumentFileSystem.fromPlatform().saveAbsolute(location.path, bytes);
        break;
      case AssetFileType.image:
        return showDialog<void>(
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
        return showDialog<void>(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc,
                child: PdfExportDialog(
                    areas: state.document.getAreaNames().toList())));
      case AssetFileType.svg:
        return showDialog<void>(
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

  void _submit({
    required List<PadElement> elements,
    List<Area> areas = const [],
    bool choosePosition = false,
  }) {
    final state = bloc.state;
    if (choosePosition && state is DocumentLoadSuccess) {
      state.currentIndexCubit.changeTemporaryHandler(
          bloc, ImportPainter(elements: elements, areas: areas));
    } else {
      bloc
        ..add(ElementsCreated(elements))
        ..add(AreasCreated(areas));
    }
  }
}
