import 'dart:convert';

import 'package:butterfly_api/src/models/animation.dart';
import 'package:collection/collection.dart';

import 'area.dart';
import 'background.dart';
import 'converter.dart';
import 'export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'element.dart';
import 'pack.dart';
import 'painter.dart';
import 'tool.dart';
import 'waypoint.dart';

part 'document.freezed.dart';
part 'document.g.dart';

const kFileVersion = 7;
const kBreakingChangesVersion = 7;

@freezed
class NoteData with _$NoteData {
  const NoteData._();

  const factory NoteData.document({
    @Default('') String name,
    @Default('') String description,
    @Default('') String thumbnail,
    @Default([]) List<PadElement> content,
    @Default(Background.empty()) Background background,
    @Default([]) List<AnimationTrack> animations,
    @Default([]) List<Waypoint> waypoints,
    @Default([]) List<Area> areas,
    @Default([]) List<ExportPreset> exportPresets,
    @Default([]) List<ButterflyPack> packs,
    @DateTimeJsonConverter() required DateTime createdAt,
    @DateTimeJsonConverter() DateTime? updatedAt,
    @Default([]) List<Painter> painters,
    @Default(ToolOption()) ToolOption tool,
  }) = AppDocument;

  factory NoteData.fromJson(Map<String, dynamic> json) =>
      _$NoteDataFromJson(json);

  List<int> save() => utf8.encode(json.encode(toJson()));
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
