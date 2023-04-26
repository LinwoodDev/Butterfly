import 'dart:convert';

import 'package:butterfly_api/src/models/animation.dart';
import 'package:collection/collection.dart';

import '../../butterfly_text.dart';
import 'area.dart';
import 'background.dart';
import 'converter.dart';
import 'export.dart';
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

// 16:9
const kThumbnailWidth = 640;
const kThumbnailHeight = 360;

@Freezed(equal: false)
class NoteData with _$NoteData {
  const NoteData._();

  const factory NoteData.document({
    @Default('') String name,
    @Default('') String description,
    @Default('') String thumbnail,
    @Default([]) List<AnimationTrack> animations,
    @Default([]) List<PadElement> content,
    @Default(Background.empty()) Background background,
    @Default([]) List<Waypoint> waypoints,
    @Default([]) List<Area> areas,
    @Default([]) List<ExportPreset> exportPresets,
    @Default([]) List<ButterflyPack> packs,
    @DateTimeJsonConverter() required DateTime createdAt,
    @DateTimeJsonConverter() DateTime? updatedAt,
    @Default([]) List<Painter> painters,
    @Default(ToolOption()) ToolOption tool,
  }) = AppDocument;

  const factory NoteData.template(
      {required AppDocument document,
      @Default('/') String directory}) = DocumentTemplate;

  const factory NoteData.pack({
    @Default('') String name,
    @Default('') String description,
    @Default('') String author,
    @Default(<ButterflyComponent>[]) List<ButterflyComponent> components,
    @Default(<TextStyleSheet>[]) List<TextStyleSheet> styles,
    @Default(<ColorPalette>[]) List<ColorPalette> palettes,
    @DateTimeJsonConverter() required DateTime createdAt,
    @DateTimeJsonConverter() required DateTime updatedAt,
  }) = ButterflyPack;

  factory NoteData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataFromJson(noteDataJsonMigrator(json));

  List<int> save() => utf8.encode(json.encode(toJson()));

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'fileVersion': kFileVersion,
      };
}

extension AppDocumentGetter on AppDocument {
  Area? getAreaByName(String value) {
    return areas.firstWhereOrNull((e) => e.name == value);
  }

  Set<String> getAreaNames() {
    return areas.map((e) => e.name).toSet();
  }

  Set<String> getLayerNames() {
    return content.map((e) => e.layer).toSet();
  }

  ExportPreset? getExportPreset(String name) {
    return exportPresets.firstWhereOrNull((e) => e.name == name);
  }

  ButterflyPack? getPack(String name) {
    return packs.firstWhereOrNull((e) => e.name == name);
  }

  AnimationTrack? getAnimation(String name) {
    return animations.firstWhereOrNull((e) => e.name == name);
  }
}

extension DocumentTemplateGetter on DocumentTemplate {
  String get name => document.name;
  String get description => document.description;
}

extension ButterflyPackGetter on ButterflyPack {
  ButterflyComponent? getComponent(String name) {
    return components.firstWhereOrNull((e) => e.name == name);
  }

  TextStyleSheet? getStyle(String name) {
    return styles.firstWhereOrNull((e) => e.name == name);
  }

  ColorPalette? getPalette(String name) {
    return palettes.firstWhereOrNull((e) => e.name == name);
  }
}
