import 'package:butterfly/models/area.dart';
import 'package:butterfly/models/background.dart';
import 'package:butterfly/models/converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

import 'element.dart';
import 'painter.dart';
import 'palette.dart';
import 'property.dart';
import 'waypoint.dart';

part 'document.g.dart';
part 'document.freezed.dart';

@immutable
abstract class AppDocumentAsset {
  final String path;

  const AppDocumentAsset(this.path);

  String get fileName => path.split('/').last;

  String get fileExtension => fileName.split('.').last;

  String get fileNameWithoutExtension =>
      fileName.substring(0, fileName.length - fileExtension.length - 1);

  String get parent =>
      path.split('/').sublist(0, path.split('/').length - 1).join('/');
}

@immutable
class AppDocumentFile extends AppDocumentAsset {
  final Map<String, dynamic> json;

  const AppDocumentFile(super.path, this.json);

  int get fileVersion => json['fileVersion'];

  String get name => json['name'];

  String get description => json['description'];

  DateTime? get updatedAt =>
      json['updatedAt'] == null ? null : DateTime.tryParse(json['updatedAt']);

  DateTime? get createdAt =>
      json['createdAt'] == null ? null : DateTime.tryParse(json['createdAt']);

  AppDocument load() =>
      const DocumentJsonConverter().fromJson(Map<String, dynamic>.from(json));
}

@immutable
class AppDocumentDirectory extends AppDocumentAsset {
  final List<AppDocumentAsset> assets;

  const AppDocumentDirectory(super.path, this.assets);

  @override
  String get fileNameWithoutExtension => fileName;
  @override
  String get fileExtension => '';
}

@freezed
class AppDocument with _$AppDocument {
  const AppDocument._();
  const factory AppDocument(
      {required String name,
      @Default('')
          String description,
      @Default([])
          List<PadElement> content,
      @Default(Background.empty())
          Background background,
      @Default([])
          List<ColorPalette> palettes,
      @Default([])
          List<Waypoint> waypoints,
      @Default([])
          List<Area> areas,
      required DateTime createdAt,
      @Default(HandProperty())
          HandProperty handProperty,
      DateTime? updatedAt,
      @Default([
        PenPainter(),
        PathEraserPainter(),
        LabelPainter(),
      ])
          List<Painter> painters}) = _AppDocument;

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
}
