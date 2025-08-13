import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/image.dart';
import 'package:butterfly/helpers/asset.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
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
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:super_clipboard/super_clipboard.dart';

import '../api/save.dart';
import '../cubits/current_index.dart';
import '../cubits/settings.dart';
import '../dialogs/export/general.dart';
import '../dialogs/import/pages.dart';
import '../dialogs/export/pdf.dart';

class ImportService {
  final DocumentBloc? bloc;
  final BuildContext context;
  final ExternalStorage? storage;
  final bool useDefaultStorage;

  ImportService(
    this.context, {
    this.bloc,
    this.storage,
    this.useDefaultStorage = true,
  });

  DocumentLoadSuccess? _getState() => bloc?.state is DocumentLoadSuccess
      ? (bloc?.state as DocumentLoadSuccess)
      : null;
  CurrentIndexCubit? get currentIndexCubit => _getState()?.currentIndexCubit;
  SettingsCubit getSettingsCubit() => context.read<SettingsCubit>();
  ButterflySettings getSettings() => getSettingsCubit().state;
  ButterflyFileSystem getFileSystem() => context.read<ButterflyFileSystem>();
  DocumentFileSystem getDocumentSystem() => useDefaultStorage
      ? getFileSystem().buildDefaultDocumentSystem()
      : getFileSystem().buildDocumentSystem(storage);
  TemplateFileSystem getTemplateFileSystem() => useDefaultStorage
      ? getFileSystem().buildDefaultTemplateSystem()
      : getFileSystem().buildTemplateSystem(storage);
  PackFileSystem getPackFileSystem() => useDefaultStorage
      ? getFileSystem().buildDefaultPackSystem()
      : getFileSystem().buildPackSystem(storage);
  Future<NamedItem<text.TextStyleSheet>?> findStyleSheet() async {
    final fileSystem = getPackFileSystem();
    for (final pack in await fileSystem.getFiles()) {
      final styleSheet = pack.data!.getNamedStyles().firstOrNull;
      if (styleSheet != null) {
        return styleSheet;
      }
    }
    return null;
  }

  Future<NoteData?> load({
    String type = '',
    Object? data,
    NoteData? document,
  }) async {
    final state = bloc?.state is DocumentLoadSuccess
        ? (bloc?.state as DocumentLoadSuccess)
        : null;
    final location = state?.location;
    document ??= state?.data;
    document ??= DocumentDefaults.createDocument();
    Uint8List? bytes;
    final fs = getDocumentSystem();
    if (data is Uint8List) {
      bytes = data;
    } else if (data is String) {
      bytes = Uint8List.fromList(utf8.encode(data));
    } else if (data is FileSystemFile<NoteData>) {
      bytes = Uint8List.fromList(data.data?.exportAsBytes() ?? []);
    } else if (data is FileSystemFile<NoteFile>) {
      bytes = Uint8List.fromList(data.data?.data ?? []);
    } else if (location != null) {
      bytes = await fs.loadAbsolute(location.path);
    } else if (data is List) {
      bytes = Uint8List.fromList(List<int>.from(data));
    } else if (data is NoteData) {
      return data;
    } else if (data is NoteFile) {
      bytes = data.data;
    }
    if (type.isEmpty) type = 'note';
    final fileType = AssetFileType.values.firstWhereOrNull(
      (element) =>
          element.isMimeType(type) ||
          element.getFileExtensions().contains(type) ||
          element.name == type,
    );
    if (fileType == null) {
      await showDialog(
        context: context,
        builder: (context) => UnknownImportConfirmationDialog(
          message: AppLocalizations.of(context).unknownImportType,
        ),
      );
      return null;
    }
    if (bytes == null) return null;
    return import(fileType, bytes, document: document, advanced: false);
  }

  Future<NoteData?> import(
    AssetFileType type,
    Uint8List bytes, {
    NoteData? document,
    Offset? position,
    bool advanced = true,
    DocumentFileSystem? fileSystem,
    TemplateFileSystem? templateSystem,
    PackFileSystem? packSystem,
  }) async {
    final realDocument = document ?? DocumentDefaults.createDocument();
    return switch (type) {
      AssetFileType.note || AssetFileType.textNote => importBfly(
        bytes,
        document: document,
        position: position,
        advanced: advanced,
        templateSystem: templateSystem,
        packSystem: packSystem,
      ),
      AssetFileType.image => importImage(
        bytes,
        realDocument,
        position: position,
      ),
      AssetFileType.svg => importSvg(bytes, realDocument, position: position),
      AssetFileType.markdown => importText(
        bytes,
        realDocument,
        position: position,
        isMarkdown: true,
      ),
      AssetFileType.pdf => importPdf(
        bytes,
        realDocument,
        position: position,
        advanced: advanced,
      ),
      AssetFileType.page => importPage(bytes, realDocument, position: position),
      AssetFileType.xopp => importXopp(bytes, realDocument, position: position),
      AssetFileType.archive => importArchive(
        bytes,
        fileSystem: fileSystem,
      ).then((value) => null),
      AssetFileType.rawText => importText(
        bytes,
        realDocument,
        position: position,
        isMarkdown: false,
      ),
    };
  }

  Future<Uint8List?>? _readFileFromClipboard(
    DataReader reader,
    FileFormat format,
  ) {
    final c = Completer<Uint8List?>();
    final progress = reader.getFile(
      format,
      (file) async {
        try {
          final all = await file.readAll();
          c.complete(all);
        } catch (e) {
          c.completeError(e);
        }
      },
      onError: (e) {
        c.completeError(e);
      },
    );
    if (progress == null) {
      c.complete(null);
    }
    return c.future;
  }

  Future<NoteData?> importClipboard(
    NoteData document, {
    Offset? position,
    bool advanced = true,
  }) async {
    Uint8List? data;
    AssetFileType? type;
    final clipboard = SystemClipboard.instance;
    if (clipboard != null) {
      final reader = await clipboard.read();
      final result = AssetFileType.values
          .map((e) {
            final format = e.getClipboardFormats().firstWhereOrNull(
              (f) => reader.canProvide(f),
            );
            return format == null ? null : (e, format);
          })
          .nonNulls
          .firstOrNull;
      if (result == null) return null;
      if (result.$2 is FileFormat) {
        data = await _readFileFromClipboard(reader, result.$2 as FileFormat);
      } else if (result.$2 is ValueFormat<Uint8List>) {
        data = await reader.readValue(result.$2 as ValueFormat<Uint8List>);
      }
      type = result.$1;
    } else {
      final clipboard = context.read<ClipboardManager>();
      final content = clipboard.getContent();
      data = content?.data;
      try {
        type = AssetFileType.values.byName(content?.type ?? '');
      } catch (e) {
        await showDialog(
          context: context,
          builder: (context) =>
              UnknownImportConfirmationDialog(message: e.toString()),
        );
      }
    }
    if (data == null || type == null) return null;
    return import(
      type,
      data,
      document: document,
      position: position,
      advanced: advanced,
    );
  }

  Future<NoteData?> importBfly(
    Uint8List bytes, {
    NoteData? document,
    Offset? position,
    bool advanced = true,
    TemplateFileSystem? templateSystem,
    PackFileSystem? packSystem,
  }) async {
    try {
      final documentOpened = document != null;
      final realDocument = document ?? DocumentDefaults.createDocument();
      final file = NoteFile(bytes);
      String? password;
      if (file.isEncrypted()) {
        password = await showDialog<String>(
          context: context,
          builder: (context) => NameDialog(
            title: AppLocalizations.of(context).encrypted,
            hint: AppLocalizations.of(context).password,
            button: AppLocalizations.of(context).open,
            obscureText: true,
          ),
        );
        if (password == null) return null;
      }
      final data = file.load(password: password);
      if (data == null) {
        return showDialog(
          context: context,
          builder: (context) => UnknownImportConfirmationDialog(
            message: AppLocalizations.of(context).unknownImportType,
          ),
        ).then((value) => null);
      }
      if (!data.isValid) {
        await importArchive(bytes);
        return null;
      }
      final type = data.getMetadata()?.type;
      return switch (type) {
        NoteFileType.document => _importDocument(
          data,
          realDocument,
          advanced: advanced,
        ),
        NoteFileType.template when documentOpened => _importTemplate(
          data,
          templateSystem,
        ),
        NoteFileType.pack when documentOpened => _importPack(
          data,
          document,
          packSystem,
        ).then((value) => null),
        _ => showDialog(
          context: context,
          builder: (context) => UnknownImportConfirmationDialog(
            message: AppLocalizations.of(context).unknownImportType,
          ),
        ).then((value) => null),
      };
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<NoteData>? _importDocument(
    NoteData data,
    NoteData document, {
    bool advanced = true,
  }) async {
    var pages = data.getPages();
    var packs = data.getBundledPacks().toList();
    if (advanced) {
      final callback = await showDialog<NoteDialogCallback>(
        context: context,
        builder: (context) => NoteImportDialog(pages: pages, packs: packs),
      );
      if (callback == null) return document;
      pages = callback.pages;
      packs = callback.packs;
    } else if (bloc == null) {
      return data;
    }
    for (final page in pages.map((e) => data.getPage(e)).nonNulls) {
      if (advanced) {
        document = document.addPage(page).$1;
      } else {
        document = document.setPage(page);
      }
      bloc?.add(PageAdded(null, page));
    }
    for (final packs in packs.map((e) => data.getBundledPack(e)).nonNulls) {
      document = document.setBundledPack(packs);
      bloc?.add(PackAdded(packs));
    }
    return document;
  }

  Future<NoteData?> importPage(
    Uint8List bytes,
    NoteData document, {
    Offset? position,
  }) async {
    try {
      final page = DocumentPage.fromJson(json.decode(utf8.decode(bytes)));
      return _importPage(page, document, position);
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  NoteData? _importPage(
    DocumentPage? page,
    NoteData document, [
    Offset? position,
  ]) {
    final firstPos = position ?? Offset.zero;
    if (page == null) return null;
    final areas = page.areas
        .map((e) => e.copyWith(position: e.position + firstPos.toPoint()))
        .toList();

    final content = page.content
        .map((e) => e.copyWith(id: createUniqueId()))
        .map(
          (e) =>
              Renderer.fromInstance(
                e,
              ).transform(position: firstPos, relative: true)?.element ??
              e,
        )
        .toList();
    return _submit(
      context,
      document,
      elements: content,
      areas: areas,
      choosePosition: position == null,
    );
  }

  Future<NoteData?> _importTemplate(
    NoteData template, [
    TemplateFileSystem? templateSystem,
  ]) async {
    final metadata = template.getMetadata();
    templateSystem ??= getTemplateFileSystem();
    if (metadata == null) return null;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          TemplateImportConfirmationDialog(template: metadata),
    );
    if (context.mounted && result == true) {
      templateSystem.createFile(template.name ?? '', template);
    }
    return template.createDocument();
  }

  Future<bool> _importPack(
    NoteData pack, [
    NoteData? document,
    PackFileSystem? packSystem,
  ]) async {
    packSystem ??= getPackFileSystem();
    final metadata = pack.getMetadata();
    if (metadata == null) return false;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => PackImportConfirmationDialog(pack: metadata),
    );
    if (result != true) return false;
    if (context.mounted) {
      if (document != null) {
        document = document.setBundledPack(pack);
      } else {
        packSystem.createFile(pack.name ?? '', pack);
      }
    }
    return true;
  }

  Future<NoteData?> importImage(
    Uint8List bytes,
    NoteData document, {
    Offset? position,
  }) async {
    try {
      final screen = MediaQuery.of(context).size;
      final firstPos = position ?? Offset.zero;
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      final newBytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final state = _getState();
      if (newBytes == null) return null;
      final newData = newBytes.buffer.asUint8List();
      final dataPath = Uri.dataFromBytes(
        newData,
        mimeType: 'image/png',
      ).toString();
      final height = image.height.toDouble(), width = image.width.toDouble();
      image.dispose();
      final settingsScale = getSettingsCubit().state.imageScale;
      ElementConstraints? constraints;
      if (position == null && currentIndexCubit != null && settingsScale > 0) {
        final scale =
            min(
              (screen.width * settingsScale) / width,
              (screen.height * settingsScale) / height,
            ) /
            currentIndexCubit!.state.cameraViewport.scale;
        constraints = ElementConstraints.scaled(scaleX: scale, scaleY: scale);
      }
      return _submit(
        context,
        document,
        elements: [
          ImageElement(
            height: height,
            width: width,
            collection: state?.currentCollection ?? '',
            source: dataPath,
            constraints: constraints,
            position: firstPos.toPoint(),
          ),
        ],
        choosePosition: position == null,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<NoteData?> importXopp(
    Uint8List bytes,
    NoteData document, {
    Offset? position,
  }) async {
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

  Future<NoteData?> importSvg(
    Uint8List bytes,
    NoteData document, {
    Offset? position,
  }) async {
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
          dataPath = Uri.dataFromBytes(
            bytes,
            mimeType: 'image/svg+xml',
          ).toString();
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
          final scale =
              min(
                (screen.width * settingsScale) / width,
                (screen.height * settingsScale) / height,
              ) /
              currentIndexCubit!.state.cameraViewport.scale;
          constraints = ElementConstraints.scaled(scaleX: scale, scaleY: scale);
        }
        return _submit(
          context,
          document,
          elements: [
            SvgElement(
              width: width,
              height: height,
              source: dataPath,
              constraints: constraints,
              position: firstPos.toPoint(),
            ),
          ],
          choosePosition: position == null,
        );
      } catch (e) {
        showDialog<void>(
          context: context,
          builder: (context) =>
              UnknownImportConfirmationDialog(message: e.toString()),
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

  Future<NoteData?> importText(
    Uint8List bytes,
    NoteData document, {
    Offset? position,
    required bool isMarkdown,
  }) async {
    try {
      final firstPos = position ?? Offset.zero;
      final contentString = String.fromCharCodes(bytes);
      final state = _getState();
      final background =
          state?.page.backgrounds.firstOrNull?.defaultColor ?? SRGBColor.white;
      final foreground = background.toColor().isDark()
          ? SRGBColor.white
          : SRGBColor.black;
      final styleSheet = await findStyleSheet();
      return _submit(
        context,
        document,
        elements: [
          isMarkdown
              ? MarkdownElement(
                  position: firstPos.toPoint(),
                  text: contentString,
                  foreground: foreground,
                  styleSheet: styleSheet,
                )
              : TextElement(
                  area: text.TextArea(
                    paragraph: text.TextParagraph(
                      textSpans: [text.TextSpan(text: contentString)],
                    ),
                  ),
                  styleSheet: styleSheet,
                  foreground: foreground,
                ),
        ],
        choosePosition: position == null,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
    }
    return null;
  }

  Future<NoteData?> importPdf(
    Uint8List bytes,
    NoteData document, {
    Offset? position,
    bool advanced = true,
  }) async {
    final dialog = showLoadingDialog(context);
    try {
      final firstPos = position ?? Offset.zero;
      final elements = <Uint8List>[];
      final localizations = AppLocalizations.of(context);
      // Define the compression value
      int level = 5;
      // Define the lot size
      const batchSize = 200;
      List<Uint8List> batch = [];
      // Create a counter for decoded images
      int decodedImagesCount = 0;
      // Get the total number of pages
      int totalPages = await Printing.raster(bytes).length;
      double quality = context.read<SettingsCubit>().state.pdfQuality;
      double dpi = PdfPageFormat.inch * quality;
      await for (var page in Printing.raster(bytes, dpi: dpi)) {
        final image = page.asImage();
        try {
          decodedImagesCount++;
          await Future.delayed(const Duration(milliseconds: 100));
          dialog?.setProgress(decodedImagesCount / totalPages);
          //compress image
          List<int> compressedPng = img.encodePng(image, level: level);
          // Add the compressed image to the current batch
          batch.add(Uint8List.fromList(compressedPng));
          // If the lot has reached the lot size, process the lot and empty the lot
          if (batch.length == batchSize) {
            elements.addAll(batch);
            batch = [];
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) =>
                UnknownImportConfirmationDialog(message: e.toString()),
          );
        }
      }
      dialog?.close();
      // Process any image left in the batch
      if (batch.isNotEmpty) {
        elements.addAll(batch);
      }
      if (context.mounted) {
        List<int> pages = List.generate(elements.length, (index) => index);
        bool spreadToPages = false,
            createAreas = false,
            background = true,
            invert = false;
        if (advanced) {
          final callback = await showDialog<PageDialogCallback>(
            context: context,
            builder: (context) => PagesDialog(pages: elements),
          );
          if (callback == null) return document;
          pages = callback.pages;
          quality = callback.quality;
          spreadToPages = callback.spreadToPages;
          createAreas = callback.createAreas;
          background = callback.background;
          invert = callback.invert;
        }
        final dialog = showLoadingDialog(context);
        final selectedElements = <ImageElement>[];
        final areas = <Area>[];
        final documentPages = <DocumentPage>[];
        var y = firstPos.dy;
        var current = 0;

        for (var i = 0; i < elements.length; i++) {
          var modifiedPng = elements[i];
          try {
            await Future.delayed(const Duration(milliseconds: 1));
            dialog?.setProgress(current / pages.length);
            current++;
            var image = img.decodePng(modifiedPng);
            final cmd = img.Command()..image(image!);
            if (background) cmd.filter(updateImageBackground());
            if (invert) cmd.invert();
            cmd.encodePng();
            final png = await cmd.getBytes();
            if (png == null) continue;
            final scale = 2.0 / quality;
            final height = image.height;
            final width = image.width;
            final dataPath = Uri.dataFromBytes(png).toString();
            final element = ImageElement(
              height: height.toDouble(),
              width: width.toDouble(),
              source: dataPath,
              constraints: ElementConstraints.scaled(
                scaleX: scale,
                scaleY: scale,
              ),
              position: Point(firstPos.dx, y),
            );
            final area = Area(
              height: height * scale,
              width: width * scale,
              position: Point(firstPos.dx, y),
              name: localizations.pageIndex(areas.length + 1),
            );
            if (spreadToPages) {
              documentPages.add(
                DocumentPage(
                  layers: [
                    DocumentLayer(content: [element], id: createUniqueId()),
                  ],
                  areas: [if (createAreas) area],
                ),
              );
            } else {
              selectedElements.add(element);
              areas.add(area);
            }
            y += height * scale;
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) =>
                  UnknownImportConfirmationDialog(message: e.toString()),
            );
          }
        }
        dialog?.close();
        return _submit(
          context,
          document,
          elements: selectedElements,
          pages: documentPages,
          areas: spreadToPages ? [] : areas,
          choosePosition: position == null,
        );
      }
    } catch (e) {
      dialog?.close();
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
        exportData(context, await state.saveData());
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
            ),
          ),
        );
      case AssetFileType.pdf:
        return showDialog<void>(
          context: context,
          builder: (context) => BlocProvider.value(
            value: bloc!,
            child: PdfExportDialog(
              areas: state.page.areas
                  .map((e) => AreaPreset(name: e.name, area: e))
                  .toList(),
            ),
          ),
        );
      case AssetFileType.svg:
        return showDialog<void>(
          context: context,
          builder: (context) => BlocProvider.value(
            value: bloc!,
            child: GeneralExportDialog(
              options: SvgExportOptions(
                width: (viewport.width ?? 1000) / viewport.scale,
                height: (viewport.height ?? 1000) / viewport.scale,
                x: viewport.x,
                y: viewport.y,
              ),
            ),
          ),
        );
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
    List<NoteData> packs = const [],
    bool choosePosition = false,
  }) {
    final state = _getState();
    DocumentPage page =
        state?.page ?? document.getPage() ?? DocumentDefaults.createPage();
    if (choosePosition &&
        state != null &&
        (elements.isNotEmpty || areas.isNotEmpty)) {
      state.currentIndexCubit.changeTemporaryHandler(
        context,
        ImportTool(elements: elements, areas: areas),
        bloc: bloc!,
        temporaryState: TemporaryState.removeAfterRelease,
      );
    } else {
      bloc
        ?..add(AreasCreated(areas))
        ..add(ElementsCreated(elements));
    }
    for (final page in pages) {
      bloc?.add(PageAdded(null, page));
    }
    for (final pack in packs) {
      bloc?.add(PackAdded(pack));
    }
    page = page.copyWith(
      layers: [
        DocumentLayer(
          content: [...page.content, ...elements],
          id: createUniqueId(),
        ),
      ],
    );
    document = document.setPage(page);
    for (final page in pages) {
      (document, _) = document.addPage(page);
    }
    for (final pack in packs) {
      document = document.setBundledPack(pack);
    }
    return document;
  }

  Future<bool> importArchive(
    Uint8List bytes, {
    DocumentFileSystem? fileSystem,
  }) async {
    try {
      fileSystem ??= getDocumentSystem();
      final archive = ZipDecoder().decodeBytes(bytes);
      final data = NoteData.fromArchive(archive);
      if (data.isValid) {
        final document = await importBfly(bytes);
        if (document != null) {
          fileSystem.createFile(document.name ?? '', document.toFile());
        }
        return document != null;
      }
      for (final file in archive) {
        const fileExtension = '.bfly';
        if (!file.name.endsWith(fileExtension)) continue;
        final document = await importBfly(file.content, advanced: false);
        if (document != null) {
          fileSystem.createFile(file.name, document.toFile());
        }
      }
      return true;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) =>
            UnknownImportConfirmationDialog(message: e.toString()),
      );
      return false;
    }
  }
}
