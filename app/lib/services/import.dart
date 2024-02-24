import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import/confirmation.dart';
import 'package:butterfly/dialogs/import/note.dart';
import 'package:butterfly/dialogs/load.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_leap/material_leap.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../api/save.dart';
import '../cubits/current_index.dart';
import '../cubits/settings.dart';
import '../dialogs/error.dart';
import '../dialogs/export/general.dart';
import '../dialogs/import/pages.dart';
import '../dialogs/export/pdf.dart';

class ImportService {
  final DocumentBloc? bloc;
  final BuildContext context;

  ImportService(this.context, [this.bloc]);

  DocumentLoadSuccess? _getState() => bloc?.state is DocumentLoadSuccess
      ? (bloc?.state as DocumentLoadSuccess)
      : null;
  CurrentIndexCubit? get currentIndexCubit => _getState()?.currentIndexCubit;
  DocumentFileSystem getFileSystem() => context.read<DocumentFileSystem>();
  TemplateFileSystem getTemplateFileSystem() =>
      context.read<TemplateFileSystem>();
  PackFileSystem getPackFileSystem() => context.read<PackFileSystem>();
  SettingsCubit getSettingsCubit() => context.read<SettingsCubit>();

  Future<NoteData?> load(
      {String type = '', Object? data, NoteData? document}) async {
    final state = bloc?.state is DocumentLoadSuccess
        ? (bloc?.state as DocumentLoadSuccess)
        : null;
    final location = state?.location;
    document ??= state?.data;
    document ??= DocumentDefaults.createDocument();
    Uint8List? bytes;
    if (data is Uint8List) {
      bytes = data;
    } else if (data is String) {
      bytes = Uint8List.fromList(utf8.encode(data));
    } else if (data is AppDocumentFile) {
      bytes = Uint8List.fromList(data.data);
    } else if (location != null) {
      bytes = await getFileSystem().loadAbsolute(location.path);
    } else if (data is List) {
      bytes = Uint8List.fromList(List<int>.from(data));
    } else if (data is NoteData) {
      return data;
    }
    if (type.isEmpty) type = 'note';
    AssetFileType? fileType;
    try {
      fileType = type.isNotEmpty
          ? AssetFileType.values.byName(type)
          : location?.fileType;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
      return null;
    }
    if (bytes == null) return null;
    return import(fileType ?? AssetFileType.note, bytes, document,
        advanced: false);
  }

  Future<NoteData?> import(
          AssetFileType type, Uint8List bytes, NoteData document,
          {Offset? position, bool advanced = true}) async =>
      switch (type) {
        AssetFileType.note => importBfly(bytes,
            document: document, position: position, advanced: advanced),
        AssetFileType.image => importImage(bytes, document, position: position),
        AssetFileType.svg => importSvg(bytes, document, position: position),
        AssetFileType.markdown =>
          importMarkdown(bytes, document, position: position),
        AssetFileType.pdf =>
          importPdf(bytes, document, position: position, advanced: advanced),
        AssetFileType.page => importPage(bytes, document, position: position),
        AssetFileType.xopp => importXopp(bytes, document, position: position),
      };

  FutureOr<NoteData?> importBfly(Uint8List bytes,
      {NoteData? document, Offset? position, bool advanced = true}) async {
    try {
      document ??= DocumentDefaults.createDocument();
      final data = NoteData.fromData(bytes);
      final type = data.getMetadata()?.type;
      switch (type) {
        case NoteFileType.document:
          return _importDocument(data, document, advanced: advanced);
        case NoteFileType.template:
          return _importTemplate(data);
        case NoteFileType.pack:
          await _importPack(data);
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
    return null;
  }

  Future<NoteData>? _importDocument(NoteData data, NoteData document,
      {bool advanced = true}) async {
    var pages = data.getPages();
    var packs = data.getPacks().toList();
    if (advanced) {
      final callback = await showDialog<NoteDialogCallback>(
          context: context,
          builder: (context) => NoteImportDialog(
                pages: pages,
                packs: packs,
              ));
      if (callback == null) return document;
      pages = callback.pages;
      packs = callback.packs;
    } else if (bloc == null) {
      return data;
    }
    for (final page in pages.map((e) => data.getPage(e)).whereNotNull()) {
      if (advanced) {
        document = document.addPage(page).$1;
      } else {
        document = document.setPage(page);
      }
      bloc?.add(PageAdded(null, page));
    }
    for (final packs in packs.map((e) => data.getPack(e)).whereNotNull()) {
      document = document.setPack(packs);
      bloc?.add(PackAdded(packs));
    }
    return document;
  }

  NoteData? importPage(Uint8List bytes, NoteData document, {Offset? position}) {
    try {
      final page = DocumentPage.fromJson(json.decode(utf8.decode(bytes)));
      return _importPage(page, document, position);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  NoteData? _importPage(DocumentPage? page, NoteData document,
      [Offset? position]) {
    final firstPos = position ?? Offset.zero;
    if (page == null) return null;
    final areas = page.areas
        .map((e) => e.copyWith(position: e.position + firstPos.toPoint()))
        .toList();

    final content = page.content
        .map((e) =>
            Renderer.fromInstance(e)
                .transform(position: firstPos, relative: true)
                ?.element ??
            e)
        .toList();
    return _submit(context, document,
        elements: content, areas: areas, choosePosition: position == null);
  }

  Future<NoteData?> _importTemplate(NoteData template) async {
    final metadata = template.getMetadata();
    if (metadata == null) return null;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          TemplateImportConfirmationDialog(template: metadata),
    );
    if (context.mounted && result == true) {
      getTemplateFileSystem().createTemplate(template);
    }
    return template.createDocument();
  }

  Future<bool> _importPack(NoteData pack) async {
    final metadata = pack.getMetadata();
    if (metadata == null) return false;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PackImportConfirmationDialog(pack: metadata),
    );
    if (result != true) return false;
    if (context.mounted) {
      getPackFileSystem().createPack(pack);
    }
    return true;
  }

  Future<NoteData?> importImage(Uint8List bytes, NoteData document,
      {Offset? position}) async {
    try {
      final screen = MediaQuery.of(context).size;
      final firstPos = position ?? Offset.zero;
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final newBytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final state = _getState();
      String dataPath;
      if (newBytes == null) return null;
      final newData = newBytes.buffer.asUint8List();
      dataPath = Uri.dataFromBytes(newData, mimeType: 'image/png').toString();
      final height = image.height.toDouble(), width = image.width.toDouble();
      image.dispose();
      final settingsScale = getSettingsCubit().state.imageScale;
      ElementConstraints? constraints;
      if (position == null && currentIndexCubit != null && settingsScale > 0) {
        final scale = min((screen.width * settingsScale) / width,
                (screen.height * settingsScale) / height) /
            currentIndexCubit!.state.cameraViewport.scale;
        constraints = ElementConstraints.scaled(scaleX: scale, scaleY: scale);
      }
      return _submit(context, document,
          elements: [
            ImageElement(
                height: height,
                width: width,
                layer: state?.currentLayer ?? '',
                source: dataPath,
                constraints: constraints,
                position: firstPos.toPoint())
          ],
          choosePosition: position == null);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<NoteData?> importXopp(Uint8List bytes, NoteData document,
      {Offset? position}) async {
    try {
      final data = xoppMigrator(bytes);
      return _importDocument(data, document);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<NoteData?> importSvg(Uint8List bytes, NoteData document,
      {Offset? position}) async {
    try {
      final screen = MediaQuery.of(context).size;
      final firstPos = position ?? Offset.zero;
      final contentString = String.fromCharCodes(bytes);
      try {
        var info = await vg.loadPicture(SvgStringLoader(contentString), null);
        final size = info.size;
        var height = size.height, width = size.width;
        if (!height.isFinite) height = 0;
        if (!width.isFinite) width = 0;
        final state = _getState();
        String dataPath;
        if (state != null) {
          dataPath =
              Uri.dataFromBytes(bytes, mimeType: 'image/svg+xml').toString();
        } else {
          dataPath = UriData.fromBytes(
            bytes,
            mimeType: 'image/svg+xml',
          ).toString();
        }
        final settingsScale = getSettingsCubit().state.imageScale;
        ElementConstraints? constraints;
        if (position == null &&
            currentIndexCubit != null &&
            settingsScale > 0) {
          final scale = min((screen.width * settingsScale) / width,
                  (screen.height * settingsScale) / height) /
              currentIndexCubit!.state.cameraViewport.scale;
          constraints = ElementConstraints.scaled(scaleX: scale, scaleY: scale);
        }
        return _submit(context, document,
            elements: [
              SvgElement(
                width: width,
                height: height,
                source: dataPath,
                constraints: constraints,
                position: firstPos.toPoint(),
              ),
            ],
            choosePosition: position == null);
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

  Future<NoteData?> importMarkdown(Uint8List bytes, NoteData document,
      {Offset? position}) async {
    try {
      final firstPos = position ?? Offset.zero;
      final contentString = String.fromCharCodes(bytes);
      final styleSheet = document.findStyle();
      final state = _getState();
      final background = state?.page.backgrounds.firstOrNull?.defaultColor ??
          BasicColors.white;
      final foreground = isDarkColor(Color(background))
          ? BasicColors.white
          : BasicColors.black;
      return _submit(context, document,
          elements: [
            MarkdownElement(
              position: firstPos.toPoint(),
              text: contentString,
              styleSheet: styleSheet,
              foreground: foreground,
            ),
          ],
          choosePosition: position == null);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<NoteData?> importPdf(Uint8List bytes, NoteData document,
      {Offset? position, bool advanced = true}) async {
    try {
      final firstPos = position ?? Offset.zero;
      final elements = <Uint8List>[];
      final localizations = AppLocalizations.of(context);
      await for (var page in Printing.raster(bytes)) {
        final png = await page.toPng();
        elements.add(png);
      }
      if (context.mounted) {
        List<int> pages = List.generate(elements.length, (index) => index);
        double quality = context.read<SettingsCubit>().state.pdfQuality;
        bool spreadToPages = false, createAreas = false;
        if (advanced) {
          final callback = await showDialog<PageDialogCallback>(
              context: context,
              builder: (context) => PagesDialog(pages: elements));
          if (callback == null) return document;
          pages = callback.pages;
          quality = callback.quality;
          spreadToPages = callback.spreadToPages;
          createAreas = callback.createAreas;
        }
        final dialog = showLoadingDialog(context);
        final selectedElements = <ImageElement>[];
        final areas = <Area>[];
        final documentPages = <DocumentPage>[];
        var y = firstPos.dx;
        var current = 0;
        await for (final page in Printing.raster(bytes,
            pages: pages, dpi: PdfPageFormat.inch * quality)) {
          await Future.delayed(const Duration(milliseconds: 100));
          dialog?.setProgress(current / pages.length);
          current++;
          final png = await page.toPng();
          final scale = 1 / quality;
          final height = page.height;
          final width = page.width;
          final dataPath = Uri.dataFromBytes(png).toString();
          final element = ImageElement(
              height: height.toDouble(),
              width: width.toDouble(),
              source: dataPath,
              constraints:
                  ElementConstraints.scaled(scaleX: scale, scaleY: scale),
              position: Point(firstPos.dx, y));
          final area = Area(
            height: height * scale,
            width: width * scale,
            position: Point(firstPos.dx, y),
            name: localizations.pageIndex(areas.length + 1),
          );
          if (spreadToPages) {
            documentPages.add(DocumentPage(
              content: [element],
              areas: [if (createAreas) area],
            ));
          } else {
            selectedElements.add(element);
            if (createAreas) {
              areas.add(area);
            }
          }
          y += height * scale;
        }
        dialog?.close();
        return _submit(
          context,
          document,
          elements: selectedElements,
          pages: documentPages,
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
    return null;
  }

  Future<void> export() async {
    final state = _getState();
    if (state == null) return;
    final location = state.location;
    final fileType = location.fileType;
    final currentIndexCubit = state.currentIndexCubit;
    final viewport = currentIndexCubit.state.cameraViewport;
    switch (fileType) {
      case AssetFileType.note:
        exportData(context, Uint8List.fromList(state.saveData().save()));
        break;
      case AssetFileType.image:
        return showDialog<void>(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc!,
                child: GeneralExportDialog(
                  options: ImageExportOptions(
                    height: viewport.height?.toDouble() ?? 1000.0,
                    width: viewport.width?.toDouble() ?? 1000.0,
                    scale: viewport.scale,
                    x: viewport.x,
                    y: viewport.y,
                  ),
                )));
      case AssetFileType.pdf:
        return showDialog<void>(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc!,
                child: PdfExportDialog(
                    areas: state.page.areas
                        .map((e) => AreaPreset(name: e.name, area: e))
                        .toList())));
      case AssetFileType.svg:
        return showDialog<void>(
            context: context,
            builder: (context) => BlocProvider.value(
                value: bloc!,
                child: GeneralExportDialog(
                    options: SVGExportOptions(
                  width: (viewport.width ?? 1000) / viewport.scale,
                  height: (viewport.height ?? 1000) / viewport.scale,
                  x: viewport.x,
                  y: viewport.y,
                ))));
      default:
        return;
    }
  }

  NoteData? _submit(
    BuildContext context,
    NoteData document, {
    required List<PadElement> elements,
    List<DocumentPage> pages = const [],
    List<Area> areas = const [],
    bool choosePosition = false,
  }) {
    final state = _getState();
    DocumentPage page =
        state?.page ?? document.getPage() ?? DocumentDefaults.createPage();
    if (choosePosition &&
        state != null &&
        (elements.isNotEmpty || areas.isNotEmpty)) {
      state.currentIndexCubit.changeTemporaryHandler(
          context, ImportTool(elements: elements, areas: areas));
    } else {
      bloc
        ?..add(ElementsCreated(elements))
        ..add(AreasCreated(areas));
    }
    for (final page in pages) {
      bloc?.add(PageAdded(null, page));
    }
    page = page.copyWith(content: [...page.content, ...elements]);
    document = document.setPage(page);
    for (final page in pages) {
      (document, _) = document.addPage(page);
    }
    return document;
  }
}
