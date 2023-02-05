import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';

import 'area.dart';
import 'background.dart';
import 'converter.dart';
import 'export.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'element.dart';
import 'pack.dart';
import 'painter.dart';
import 'palette.dart';
import 'tool.dart';
import 'waypoint.dart';

part 'document.freezed.dart';
part 'document.g.dart';

const kFileVersion = 7;
const kBreakingChangesVersion = 7;

enum AssetFileType { note, image, pdf, svg }

@freezed
class AssetLocation with _$AssetLocation {
  const factory AssetLocation({
    @Default('') String remote,
    required String path,
    @Default(false) bool absolute,
  }) = _AssetLocation;

  factory AssetLocation.local(String path, [bool absolute = false]) =>
      AssetLocation(path: path, absolute: absolute);

  factory AssetLocation.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationFromJson(json);

  const AssetLocation._();

  String get identifier =>
      remote == '' ? pathWithLeadingSlash : '$remote@$pathWithLeadingSlash';

  String get pathWithLeadingSlash => path.startsWith('/') ? path : '/$path';

  String get pathWithoutLeadingSlash =>
      path.startsWith('/') ? path.substring(1) : path;

  AssetFileType? get fileType {
    final ext = path.split('.').last;
    switch (ext) {
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'gif':
      case 'bmp':
      case 'ico':
        return AssetFileType.image;
      case 'pdf':
        return AssetFileType.pdf;
      case 'svg':
        return AssetFileType.svg;
      case 'bfly':
      case 'json':
      case '':
        return AssetFileType.note;
      default:
        return null;
    }
  }

  String get fileName => path.split('/').last.split('.').first;
}

@immutable
abstract class AppDocumentEntity {
  final AssetLocation location;
  final bool cached;

  const AppDocumentEntity(this.location, {this.cached = false});

  String get fileName => location.path.split('/').last;

  String get fileExtension =>
      fileName.contains('.') ? fileName.split('.').last : '';

  String get fileNameWithoutExtension => fileName.substring(0,
      fileName.contains('.') ? fileName.lastIndexOf('.') : fileName.length - 1);

  String get pathWithLeadingSlash => location.pathWithLeadingSlash;

  String get pathWithoutLeadingSlash => location.pathWithoutLeadingSlash;

  String get parent => pathWithLeadingSlash
      .split('/')
      .sublist(0, pathWithLeadingSlash.split('/').length - 1)
      .join('/');
}

@immutable
class AppDocumentFile extends AppDocumentEntity {
  final Uint8List data;

  const AppDocumentFile(super.path, this.data);

  factory AppDocumentFile.fromMap(
          AssetLocation path, Map<String, dynamic> map) =>
      AppDocumentFile(path, Uint8List.fromList(utf8.encode(json.encode(map))));

  AssetFileType? get fileType => location.fileType;

  DocumentInfo? getDocumentInfo() {
    try {
      if (fileType == AssetFileType.note) {
        return DocumentInfo(
            fileNameWithoutExtension, jsonDecode(utf8.decode(data)));
      }
    } catch (_) {}

    return null;
  }
}

@immutable
class DocumentInfo {
  final Map<String, dynamic> json;
  final String fileName;

  const DocumentInfo(this.fileName, this.json);
  int get fileVersion => json['fileVersion'] ?? -1;

  String get name => json['name'] ?? fileName;

  String get description => json['description'] ?? '';

  DateTime? get updatedAt =>
      json['updatedAt'] == null ? null : DateTime.tryParse(json['updatedAt']);

  DateTime? get createdAt =>
      json['createdAt'] == null ? null : DateTime.tryParse(json['createdAt']);

  AppDocument load() =>
      const DocumentJsonConverter().fromJson(Map<String, dynamic>.from(json));

  String get data => jsonEncode(json);
}

@immutable
class AppDocumentDirectory extends AppDocumentEntity {
  final List<AppDocumentEntity> assets;

  const AppDocumentDirectory(super.path, this.assets);

  @override
  String get fileNameWithoutExtension => fileName;

  @override
  String get fileExtension => '';
}

List<Painter> createDefaultPainters() => [
      HandPainter(),
      PenPainter(),
      PathEraserPainter(),
      UndoPainter(),
      RedoPainter()
    ];

@freezed
class AppDocument with _$AppDocument {
  const AppDocument._();

  const factory AppDocument({
    required String name,
    @Default('') String description,
    @Default([]) List<PadElement> content,
    @Default(Background.empty()) Background background,
    @Default([]) List<ColorPalette> palettes,
    @Default([]) List<Waypoint> waypoints,
    @Default([]) List<Area> areas,
    @Default([]) List<ExportPreset> exportPresets,
    @Default([]) List<ButterflyPack> packs,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default([]) List<Painter> painters,
    @Default(ToolOption()) ToolOption tool,
  }) = _AppDocument;

  factory AppDocument.fromJson(Map<String, dynamic> json) =>
      _$AppDocumentFromJson(json);

  Area? getArea(Offset offset) {
    return areas.firstWhereOrNull((e) => e.hit(offset));
  }

  Area? getAreaByRect(Rect rect) {
    return areas.firstWhereOrNull((e) => rect.overlaps(e.rect));
  }

  Area? getAreaByName(String value) {
    return areas.firstWhereOrNull((e) => e.name == value);
  }

  Set<String> getAreaNames() {
    return areas.map((e) => e.name).toSet();
  }

  Set<String> getLayerNames() {
    return content.map((e) => e.layer).toSet();
  }

  ColorPalette? getPalette(String name) {
    return palettes.firstWhereOrNull((e) => e.name == name);
  }

  ExportPreset? getExportPreset(String name) {
    return exportPresets.firstWhereOrNull((e) => e.name == name);
  }

  ButterflyPack? getPack(String name) {
    return packs.firstWhereOrNull((e) => e.name == name);
  }
}
