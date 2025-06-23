import 'dart:async';

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
    return backgrounds.whereType<SourcedElement>().any(
          (e) => e.source == source,
        ) ||
        layers.any(
          (e) => e.content.whereType<SourcedElement>().any(
            (e) => e.source == source,
          ),
        );
  }

  DocumentLayer getLayer(String id) {
    return layers.where((e) => e.id == id).firstOrNull ?? DocumentLayer(id: id);
  }

  DocumentPage mapLayer(
    String id,
    DocumentLayer Function(DocumentLayer) mapper,
  ) {
    var newLayers = layers.toList();
    if (!newLayers.any((e) => e.id == id)) {
      newLayers.add(mapper(DocumentLayer(id: id)));
    } else {
      newLayers = newLayers.map((e) => e.id == id ? mapper(e) : e).toList();
    }
    final newPage = copyWith(layers: newLayers);
    return newPage;
  }

  DocumentPage mapLayers(DocumentLayer Function(DocumentLayer) mapper) {
    final newLayers = layers.map(mapper).toList();
    return copyWith(layers: newLayers);
  }

  Future<DocumentPage> mapLayersAsync(
    FutureOr<DocumentLayer> Function(DocumentLayer) mapper,
  ) {
    return Future.wait(layers.map((e) => Future.value(mapper(e)))).then((
      newLayers,
    ) {
      return copyWith(layers: newLayers.toList());
    });
  }

  Waypoint? getWaypointByName(String? waypointName) {
    return waypoints.firstWhereOrNull(
      (waypoint) => waypoint.name == waypointName,
    );
  }

  Waypoint getOriginWaypoint() {
    return getWaypointByName(Waypoint.originName) ?? Waypoint.defaultOrigin;
  }
}

@freezed
sealed class DocumentLayer with _$DocumentLayer {
  const DocumentLayer._();

  const factory DocumentLayer({
    String? id,
    @Default('') String name,
    @Default([]) List<PadElement> content,
  }) = _DocumentLayer;

  factory DocumentLayer.fromJson(Map<String, dynamic> json) =>
      _$DocumentLayerFromJson(json);

  Set<String> getCollectionNames() {
    return content.map((e) => e.collection).toSet();
  }
}
