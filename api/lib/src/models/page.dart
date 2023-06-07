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
class DocumentPage with _$DocumentPage {
  const DocumentPage._();

  const factory DocumentPage({
    @Default([]) List<AnimationTrack> animations,
    @Default([]) List<PadElement> content,
    @Default(Background.empty()) Background background,
    @Default([]) List<Waypoint> waypoints,
    @Default([]) List<Area> areas,
  }) = _DocumentPage;

  factory DocumentPage.fromJson(Map<String, dynamic> json) =>
      _$DocumentPageFromJson(json);

  Area? getAreaByName(String value) {
    return areas.firstWhereOrNull((e) => e.name == value);
  }

  Set<String> getAreaNames() {
    return areas.map((e) => e.name).toSet();
  }

  Set<String> getLayerNames() {
    return content.map((e) => e.layer).toSet();
  }

  AnimationTrack? getAnimation(String name) {
    return animations.firstWhereOrNull((e) => e.name == name);
  }

  bool usesSource(String source) {
    return content.whereType<SourcedElement>().any((e) => e.source == source);
  }
}
