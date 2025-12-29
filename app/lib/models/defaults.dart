import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/helpers/color.dart';
import 'package:butterfly/visualizer/preset.dart';
import 'package:flutter/material.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';

class DocumentDefaults {
  static NoteData? _corePack;

  DocumentDefaults._();

  // ignore: unused_element
  static Future<Uint8List> _createPlainThumnail(SRGBColor color) async {
    final size = Size(kThumbnailWidth.toDouble(), kThumbnailHeight.toDouble());
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = color.toColor(),
    );
    final picture = recorder.endRecording();
    final image = await picture.toImage(
      size.width.toInt(),
      size.height.toInt(),
    );
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    picture.dispose();
    return bytes!.buffer.asUint8List();
  }

  static List<Tool> createTools([SRGBColor? background]) =>
      [
            SelectTool(mode: SelectMode.lasso),
            PenTool(),
            PathEraserTool(),
            UndoTool(),
            RedoTool(),
            HandTool(),
          ]
          .map(
            (e) =>
                background == null ? e : updateToolDefaultColor(e, background),
          )
          .toList();

  static Future<List<NoteData>> getCoreTemplates(
    BuildContext context, {
    PatternBackground? background,
  }) async {
    return Future.wait([
      ...PatternTemplate.values
          .where((e) => background == null || e.background == background)
          .map((e) async {
            final bg = Background.texture(texture: e.create());
            return createTemplate(
              name: e.getLocalizedName(context),
              thumbnail: Uint8List.sublistView(await rootBundle.load(e.asset)),
              backgrounds: [bg],
            );
          }),
    ]);
  }

  static Future<NoteData> _loadNoteData(String name) async => NoteData.fromData(
    Uint8List.sublistView(await rootBundle.load('defaults/$name.tbfly')),
  );

  static Future<NoteData> getCorePack() async {
    return _corePack ??= await _loadNoteData('defaults/pack.tbfly');
  }

  static String translate(String key, Map<String, String> translations) {
    if (key.startsWith('\\/')) return key.substring(1);
    if (key.startsWith('\$')) {
      final keyWithoutDollar = key.substring(1);
      return translations[keyWithoutDollar] ?? keyWithoutDollar;
    }
    return translations[key] ?? key;
  }

  static Map<String, String> getParagraphTranslations(BuildContext context) => {
    'h1': AppLocalizations.of(context).headline(1),
    'h2': AppLocalizations.of(context).headline(2),
    'h3': AppLocalizations.of(context).headline(3),
    'h4': AppLocalizations.of(context).headline(4),
    'h5': AppLocalizations.of(context).headline(5),
    'h6': AppLocalizations.of(context).headline(6),
    'p': AppLocalizations.of(context).paragraph,
    'blockquote': AppLocalizations.of(context).quote,
    'math': AppLocalizations.of(context).math,
  };

  static String translateParagraph(String key, BuildContext context) =>
      translate(key, getParagraphTranslations(context));

  static Map<String, String> getSpanTranslations(BuildContext context) => {
    'a': AppLocalizations.of(context).link,
    'checkbox': AppLocalizations.of(context).checkbox,
    'del': AppLocalizations.of(context).deleted,
    'em': AppLocalizations.of(context).emphasis,
    'img': AppLocalizations.of(context).image,
    'listBullet': AppLocalizations.of(context).listBullet,
    'strong': AppLocalizations.of(context).strong,
    'code': AppLocalizations.of(context).code,
  };

  static String translateBlock(String key, BuildContext context) =>
      translate(key, getSpanTranslations(context));

  static NoteData createDocument({
    String name = '',
    DocumentPage? page,
    bool createDefaultPage = true,
  }) {
    final metadata = createMetadata(name: name);
    var data = NoteData(Archive()).setMetadata(metadata).setInfo(createInfo());
    if (createDefaultPage) {
      page ??= createPage();
      data = data.setPage(page).$1;
    }
    return data;
  }

  static DocumentPage createPage() {
    return DocumentPage(
      backgrounds: [
        Background.texture(texture: PatternTemplate.plain.create()),
      ],
    );
  }

  static DocumentInfo createInfo([SRGBColor? background]) {
    return DocumentInfo(tools: createTools(background));
  }

  static NoteData createPack() {
    final metadata = createMetadata(type: NoteFileType.pack);
    final data = NoteData(Archive()).setMetadata(metadata);
    return data;
  }

  static Future<NoteData> createTemplate({
    String name = '',
    Uint8List? thumbnail,
    List<Background> backgrounds = const [],
  }) async {
    final metadata = createMetadata(type: NoteFileType.template, name: name);
    final page = DocumentPage(backgrounds: backgrounds);
    var data = NoteData(Archive())
        .setMetadata(metadata)
        .setInfo(createInfo(backgrounds.firstOrNull?.defaultColor))
        .setPage(page)
        .$1;
    if (thumbnail != null) data = data.setThumbnail(thumbnail);
    return data;
  }

  static FileMetadata createMetadata({
    NoteFileType type = NoteFileType.document,
    String name = '',
  }) => FileMetadata(
    name: name,
    createdAt: DateTime.now().toUtc(),
    type: type,
    fileVersion: kFileVersion,
    updatedAt: DateTime.now().toUtc(),
  );
}
