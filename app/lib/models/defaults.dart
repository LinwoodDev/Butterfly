import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentDefaults {
  static NoteData? _corePack;

  DocumentDefaults._();

  static Future<Uint8List> _createPlainThumnail(Color color) async {
    final size = Size(kThumbnailWidth.toDouble(), kThumbnailHeight.toDouble());
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = color);
    final picture = recorder.endRecording();
    final image =
        await picture.toImage(size.width.toInt(), size.height.toInt());
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List();
  }

  static List<Painter> createPainters([int? background]) => [
        HandPainter(),
        PenPainter(),
        PathEraserPainter(),
        UndoPainter(),
        RedoPainter()
      ]
          .map((e) =>
              background == null ? e : updatePainterDefaultColor(e, background))
          .toList();

  static Future<List<NoteData>> getDefaults(BuildContext context) async {
    return Future.wait([
      (
        AppLocalizations.of(context).light,
        BackgroundTemplate.plain.create(),
      ),
      (
        AppLocalizations.of(context).dark,
        BackgroundTemplate.plainDark.create(),
      ),
    ].map((e) async {
      final bg = e.$2;
      final color = bg.defaultColor;
      return createTemplate(
        name: e.$1,
        thumbnail: await _createPlainThumnail(Color(color)),
        background: bg,
      );
    }).toList());
  }

  static Future<NoteData> getCorePack() async {
    _corePack ??= NoteData.fromData(
        Uint8List.sublistView(await rootBundle.load('defaults/pack.bfly')));
    return _corePack!;
  }

  static String translate(String key, Map<String, String> translations) {
    if (key.startsWith('\\/')) return key.substring(1);
    if (!key.startsWith('\$')) return key;
    final keyWithoutDollar = key.substring(1);
    return translations[keyWithoutDollar] ?? keyWithoutDollar;
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
  }) {
    page ??= createPage();
    final data = NoteData(Archive());
    final metadata = createMetadata(name: name);
    data.setMetadata(metadata);
    data.setPage(page);
    data.setInfo(createInfo());
    return data;
  }

  static DocumentPage createPage() {
    return const DocumentPage();
  }

  static DocumentInfo createInfo([int? background]) {
    return DocumentInfo(painters: createPainters(background));
  }

  static NoteData createPack() {
    final data = NoteData(Archive());
    final metadata = createMetadata(
      type: NoteFileType.pack,
    );
    data.setMetadata(metadata);
    return data;
  }

  static Future<NoteData> createTemplate(
      {String name = '',
      Uint8List? thumbnail,
      Background background = const Background.box()}) async {
    final data = NoteData(Archive());
    final metadata = createMetadata(
      type: NoteFileType.template,
      name: name,
    );
    data.setMetadata(metadata);
    final page = DocumentPage(
      background: background,
    );
    data.setInfo(createInfo(background.defaultColor));
    data.setPage(page);
    data.setPack(await getCorePack());
    if (thumbnail != null) data.setThumbnail(thumbnail);
    return data;
  }

  static createMetadata(
          {NoteFileType type = NoteFileType.document, String name = ''}) =>
      FileMetadata(
        name: name,
        createdAt: DateTime.now().toUtc(),
        type: type,
        fileVersion: kFileVersion,
        updatedAt: DateTime.now().toUtc(),
      );
}
