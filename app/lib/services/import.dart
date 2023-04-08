import 'dart:async';
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
  final DocumentBloc? bloc;
  final BuildContext context;

  ImportService(this.context, [this.bloc]);

  DocumentLoadSuccess? _getState() => bloc?.state is DocumentLoadSuccess
      ? (bloc?.state as DocumentLoadSuccess)
      : null;
  DocumentFileSystem getFileSystem() => context.read<DocumentFileSystem>();
  TemplateFileSystem getTemplateFileSystem() =>
      context.read<TemplateFileSystem>();
  PackFileSystem getPackFileSystem() => context.read<PackFileSystem>();

  Future<NoteData?> load(
      {String type = '', Object? data, AppDocument? document}) async {
    final state = bloc?.state is DocumentLoadSuccess
        ? (bloc?.state as DocumentLoadSuccess)
        : null;
    final location = state?.location;
    document ??= state?.document;
    Uint8List? bytes;
    if (data is Uint8List) {
      bytes = data;
    } else if (data is String) {
      bytes = Uint8List.fromList(utf8.encode(data));
    } else if (location != null) {
      bytes = await getFileSystem().loadAbsolute(location.path);
    }
    final fileType = type.isNotEmpty
        ? AssetFileType.values.byName(type)
        : location?.fileType;
    if (bytes == null || fileType == null) return null;
    return import(fileType, bytes, document: document);
  }

  Future<NoteData?> import(AssetFileType type, Uint8List bytes,
      {Offset? position, AppDocument? document}) async {
    switch (type) {
      case AssetFileType.note:
        return importBfly(bytes, position, document);
      case AssetFileType.image:
        return importImage(bytes, position, document);
      case AssetFileType.svg:
        return importSvg(bytes, position, document);
      case AssetFileType.pdf:
        return importPdf(bytes, position, true, document);
      default:
        return Future.value();
    }
  }

  FutureOr<NoteData?> importBfly(Uint8List bytes,
      [Offset? position, AppDocument? document]) {
    try {
      final data = json.decode(
        String.fromCharCodes(bytes),
      );
      final type = data['type'];
      switch (type) {
        case 'document':
          return _importDocument(data, position, document);
        case 'template':
          return _importTemplate(data);
        case 'pack':
          return _importPack(data);
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
    return null;
  }

  AppDocument? _importDocument(Map<String, dynamic> data,
      [Offset? position, AppDocument? document]) {
    final firstPos = position ?? Offset.zero;
    final doc = const DocumentJsonConverter().fromJson(data);
    if (document != null) {
      bloc?.add(DocumentUpdated(doc));
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
    return _submit(
            elements: content,
            areas: areas,
            document: document,
            choosePosition: position == null) ??
        doc;
  }

  Future<DocumentTemplate?> _importTemplate(Map<String, dynamic> data) async {
    final template = const TemplateJsonConverter().fromJson(data);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          TemplateImportConfirmationDialog(template: template),
    );
    if (result != true) return null;
    if (context.mounted) {
      context.read<TemplateFileSystem>().createTemplate(template);
    }
    return template;
  }

  Future<ButterflyPack?> _importPack(Map<String, dynamic> data) async {
    final pack = const PackJsonConverter().fromJson(data);
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PackImportConfirmationDialog(pack: pack),
    );
    if (result != true) return null;
    if (context.mounted) {
      getPackFileSystem().createPack(pack);
    }
    return pack;
  }

  Future<AppDocument?> importImage(Uint8List bytes,
      [Offset? position, AppDocument? document]) async {
    try {
      final firstPos = position ?? Offset.zero;
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image.clone();

      final newBytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final state = _getState();
      _submit(elements: [
        ImageElement(
            height: image.height.toDouble(),
            width: image.width.toDouble(),
            layer: state?.currentLayer ?? '',
            source: UriData.fromBytes(
              newBytes?.buffer.asUint8List() ?? Uint8List(0),
              mimeType: 'image/png',
            ).toString(),
            position: firstPos.toPoint())
      ], choosePosition: position == null);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<AppDocument?> importSvg(Uint8List bytes,
      [Offset? position, AppDocument? document]) async {
    try {
      final firstPos = position ?? Offset.zero;
      final contentString = String.fromCharCodes(bytes);
      try {
        var info = await vg.loadPicture(SvgStringLoader(contentString), null);
        final size = info.size;
        var height = size.height, width = size.width;
        if (!height.isFinite) height = 0;
        if (!width.isFinite) width = 0;
        return _submit(elements: [
          SvgElement(
            width: width,
            height: height,
            data: contentString,
            position: firstPos.toPoint(),
          ),
        ], choosePosition: position == null, document: document);
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
    return null;
  }

  Future<AppDocument?> importPdf(Uint8List bytes,
      [Offset? position,
      bool createAreas = false,
      AppDocument? document]) async {
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
        if (callback == null) return document;
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
              source: UriData.fromBytes(png, mimeType: 'image/png').toString(),
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
        }
        return _submit(
          elements: selectedElements,
          areas: createAreas ? areas : [],
          choosePosition: position == null,
          document: document,
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<void> export() async {
    final state = _getState();
    if (state == null) return;
    final location = state.location;
    final fileType = location.fileType;
    final viewport = context.read<CurrentIndexCubit>().state.cameraViewport;
    switch (fileType) {
      case AssetFileType.note:
        final data =
            json.encode(const DocumentJsonConverter().toJson(state.document));
        final bytes = Uint8List.fromList(data.codeUnits);
        getFileSystem().saveAbsolute(location.path, bytes);
        break;
      case AssetFileType.image:
        return showDialog<void>(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc!,
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
                value: bloc!,
                child: PdfExportDialog(
                    areas: state.document.areas
                        .map((e) => AreaPreset(name: e.name, area: e))
                        .toList())));
      case AssetFileType.svg:
        return showDialog<void>(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc!,
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

  AppDocument? _submit({
    required List<PadElement> elements,
    List<Area> areas = const [],
    bool choosePosition = false,
    AppDocument? document,
  }) {
    final state = _getState();
    if (choosePosition && state is DocumentLoadSuccess) {
      state.currentIndexCubit.changeTemporaryHandler(
          bloc!, ImportPainter(elements: elements, areas: areas));
    } else {
      bloc
        ?..add(ElementsCreated(elements))
        ..add(AreasCreated(areas));
    }
    document ??= state?.document;
    if (document != null) {
      return document.copyWith(
        content: [...document.content, ...elements],
        areas: [...document.areas, ...areas],
      );
    }
    return null;
  }
}
