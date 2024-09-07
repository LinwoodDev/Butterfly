import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'animation.dart';
import 'area.dart';
import 'background.dart';
import 'element.dart';
import 'waypoint.dart';

part 'page.g.dart';
part 'page.freezed.dart';

@freezed
sealed class DocumentPage with _$DocumentPage {
  const DocumentPage._();

  const factory DocumentPage({
    @Default([]) List<AnimationTrack> animations,
    @Default([]) List<DocumentLayer> layers,
    @Default([]) List<Background> backgrounds,
    @Default([]) List<Waypoint> waypoints,
    @Default([]) List<Area> areas,
    @Default({}) Map<String, dynamic> extra,
  }) = _DocumentPage;

  factory DocumentPage.fromJson(Map<String, dynamic> json) =>
      _$DocumentPageFromJson(json);

  List<PadElement> get content => layers.expand((e) => e.content).toList();

  Area? getAreaByName(String value) {
    return areas.firstWhereOrNull((e) => e.name == value);
  }

  Set<String> getAreaNames() {
    return areas.map((e) => e.name).toSet();
  }

  AnimationTrack? getAnimation(String name) {
    return animations.firstWhereOrNull((e) => e.name == name);
  }

  bool usesSource(String source) {
    return layers.any((e) =>
        e.content.whereType<SourcedElement>().any((e) => e.source == source));
  }
}

@freezed
sealed class DocumentLayer with _$DocumentLayer {
  const DocumentLayer._();

  const factory DocumentLayer({
    @Default('') String name,
    @Default([]) List<PadElement> content,
  }) = _DocumentLayer;

  factory DocumentLayer.fromJson(Map<String, dynamic> json) =>
      _$DocumentLayerFromJson(json);

  Set<String> getCollectionNames() {
    return content.map((e) => e.collection).toSet();
  }
}
