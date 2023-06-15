// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageChanged _$$PageChangedFromJson(Map json) => _$PageChanged(
      json['pageName'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PageChangedToJson(_$PageChanged instance) =>
    <String, dynamic>{
      'pageName': instance.pageName,
      'type': instance.$type,
    };

_$ToolOptionChanged _$$ToolOptionChangedFromJson(Map json) =>
    _$ToolOptionChanged(
      json['option'] == null
          ? null
          : ToolOption.fromJson(
              Map<String, dynamic>.from(json['option'] as Map)),
      json['type'] as String?,
    );

Map<String, dynamic> _$$ToolOptionChangedToJson(_$ToolOptionChanged instance) =>
    <String, dynamic>{
      'option': instance.option?.toJson(),
      'type': instance.$type,
    };

_$ToolStateChanged _$$ToolStateChangedFromJson(Map json) => _$ToolStateChanged(
      json['state'] == null
          ? null
          : ToolState.fromJson(Map<String, dynamic>.from(json['state'] as Map)),
      json['type'] as String?,
    );

Map<String, dynamic> _$$ToolStateChangedToJson(_$ToolStateChanged instance) =>
    <String, dynamic>{
      'state': instance.state?.toJson(),
      'type': instance.$type,
    };

_$ElementsCreated _$$ElementsCreatedFromJson(Map json) => _$ElementsCreated(
      (json['elements'] as List<dynamic>)
          .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsCreatedToJson(_$ElementsCreated instance) =>
    <String, dynamic>{
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$ElementsChanged _$$ElementsChangedFromJson(Map json) => _$ElementsChanged(
      (json['elements'] as Map).map(
        (k, e) => MapEntry(
            int.parse(k as String),
            (e as List<dynamic>)
                .map((e) =>
                    PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList()),
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsChangedToJson(_$ElementsChanged instance) =>
    <String, dynamic>{
      'elements': instance.elements.map(
          (k, e) => MapEntry(k.toString(), e.map((e) => e.toJson()).toList())),
      'type': instance.$type,
    };

_$ElementsRemoved _$$ElementsRemovedFromJson(Map json) => _$ElementsRemoved(
      (json['elements'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsRemovedToJson(_$ElementsRemoved instance) =>
    <String, dynamic>{
      'elements': instance.elements,
      'type': instance.$type,
    };

_$ElementsArranged _$$ElementsArrangedFromJson(Map json) => _$ElementsArranged(
      $enumDecode(_$ArrangementEnumMap, json['arrangement']),
      (json['elements'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsArrangedToJson(_$ElementsArranged instance) =>
    <String, dynamic>{
      'arrangement': _$ArrangementEnumMap[instance.arrangement]!,
      'elements': instance.elements,
      'type': instance.$type,
    };

const _$ArrangementEnumMap = {
  Arrangement.forward: 'forward',
  Arrangement.backward: 'backward',
  Arrangement.front: 'front',
  Arrangement.back: 'back',
};

_$DocumentDescriptionChanged _$$DocumentDescriptionChangedFromJson(Map json) =>
    _$DocumentDescriptionChanged(
      name: json['name'] as String?,
      description: json['description'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentDescriptionChangedToJson(
        _$DocumentDescriptionChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.$type,
    };

_$DocumentPathChanged _$$DocumentPathChangedFromJson(Map json) =>
    _$DocumentPathChanged(
      json['path'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentPathChangedToJson(
        _$DocumentPathChanged instance) =>
    <String, dynamic>{
      'path': instance.path,
      'type': instance.$type,
    };

_$DocumentSaved _$$DocumentSavedFromJson(Map json) => _$DocumentSaved(
      json['location'] == null
          ? null
          : AssetLocation.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentSavedToJson(_$DocumentSaved instance) =>
    <String, dynamic>{
      'location': instance.location?.toJson(),
      'type': instance.$type,
    };

_$PainterCreated _$$PainterCreatedFromJson(Map json) => _$PainterCreated(
      Painter.fromJson(Map<String, dynamic>.from(json['painter'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PainterCreatedToJson(_$PainterCreated instance) =>
    <String, dynamic>{
      'painter': instance.painter.toJson(),
      'type': instance.$type,
    };

_$PaintersChanged _$$PaintersChangedFromJson(Map json) => _$PaintersChanged(
      (json['painters'] as Map).map(
        (k, e) => MapEntry(int.parse(k as String),
            Painter.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PaintersChangedToJson(_$PaintersChanged instance) =>
    <String, dynamic>{
      'painters':
          instance.painters.map((k, e) => MapEntry(k.toString(), e.toJson())),
      'type': instance.$type,
    };

_$PaintersRemoved _$$PaintersRemovedFromJson(Map json) => _$PaintersRemoved(
      (json['painters'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PaintersRemovedToJson(_$PaintersRemoved instance) =>
    <String, dynamic>{
      'painters': instance.painters,
      'type': instance.$type,
    };

_$PainterReordered _$$PainterReorderedFromJson(Map json) => _$PainterReordered(
      json['oldIndex'] as int,
      json['newIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PainterReorderedToJson(_$PainterReordered instance) =>
    <String, dynamic>{
      'oldIndex': instance.oldIndex,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

_$DocumentBackgroundChanged _$$DocumentBackgroundChangedFromJson(Map json) =>
    _$DocumentBackgroundChanged(
      Background.fromJson(Map<String, dynamic>.from(json['background'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentBackgroundChangedToJson(
        _$DocumentBackgroundChanged instance) =>
    <String, dynamic>{
      'background': instance.background.toJson(),
      'type': instance.$type,
    };

_$WaypointCreated _$$WaypointCreatedFromJson(Map json) => _$WaypointCreated(
      Waypoint.fromJson(Map<String, dynamic>.from(json['waypoint'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointCreatedToJson(_$WaypointCreated instance) =>
    <String, dynamic>{
      'waypoint': instance.waypoint.toJson(),
      'type': instance.$type,
    };

_$WaypointRemoved _$$WaypointRemovedFromJson(Map json) => _$WaypointRemoved(
      json['index'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointRemovedToJson(_$WaypointRemoved instance) =>
    <String, dynamic>{
      'index': instance.index,
      'type': instance.$type,
    };

_$LayerRenamed _$$LayerRenamedFromJson(Map json) => _$LayerRenamed(
      json['oldName'] as String,
      json['newName'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerRenamedToJson(_$LayerRenamed instance) =>
    <String, dynamic>{
      'oldName': instance.oldName,
      'newName': instance.newName,
      'type': instance.$type,
    };

_$LayerRemoved _$$LayerRemovedFromJson(Map json) => _$LayerRemoved(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerRemovedToJson(_$LayerRemoved instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$LayerElementsRemoved _$$LayerElementsRemovedFromJson(Map json) =>
    _$LayerElementsRemoved(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerElementsRemovedToJson(
        _$LayerElementsRemoved instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$LayerVisibilityChanged _$$LayerVisibilityChangedFromJson(Map json) =>
    _$LayerVisibilityChanged(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerVisibilityChangedToJson(
        _$LayerVisibilityChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$CurrentLayerChanged _$$CurrentLayerChangedFromJson(Map json) =>
    _$CurrentLayerChanged(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CurrentLayerChangedToJson(
        _$CurrentLayerChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$ElementsLayerChanged _$$ElementsLayerChangedFromJson(Map json) =>
    _$ElementsLayerChanged(
      json['layer'] as String,
      (json['elements'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsLayerChangedToJson(
        _$ElementsLayerChanged instance) =>
    <String, dynamic>{
      'layer': instance.layer,
      'elements': instance.elements,
      'type': instance.$type,
    };

_$TemplateCreated _$$TemplateCreatedFromJson(Map json) => _$TemplateCreated(
      json['directory'] as String,
      json['remote'] as String?,
      json['deleteDocument'] as bool? ?? true,
      json['type'] as String?,
    );

Map<String, dynamic> _$$TemplateCreatedToJson(_$TemplateCreated instance) =>
    <String, dynamic>{
      'directory': instance.directory,
      'remote': instance.remote,
      'deleteDocument': instance.deleteDocument,
      'type': instance.$type,
    };

_$AreasCreated _$$AreasCreatedFromJson(Map json) => _$AreasCreated(
      (json['areas'] as List<dynamic>)
          .map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreasCreatedToJson(_$AreasCreated instance) =>
    <String, dynamic>{
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$AreasRemoved _$$AreasRemovedFromJson(Map json) => _$AreasRemoved(
      (json['areas'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreasRemovedToJson(_$AreasRemoved instance) =>
    <String, dynamic>{
      'areas': instance.areas,
      'type': instance.$type,
    };

_$AreaChanged _$$AreaChangedFromJson(Map json) => _$AreaChanged(
      json['name'] as String,
      Area.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaChangedToJson(_$AreaChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'area': instance.area.toJson(),
      'type': instance.$type,
    };

_$CurrentAreaChanged _$$CurrentAreaChangedFromJson(Map json) =>
    _$CurrentAreaChanged(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CurrentAreaChangedToJson(
        _$CurrentAreaChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$ExportPresetCreated _$$ExportPresetCreatedFromJson(Map json) =>
    _$ExportPresetCreated(
      json['name'] as String,
      (json['areas'] as List<dynamic>?)
              ?.map((e) =>
                  AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      json['type'] as String?,
    );

Map<String, dynamic> _$$ExportPresetCreatedToJson(
        _$ExportPresetCreated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$ExportPresetUpdated _$$ExportPresetUpdatedFromJson(Map json) =>
    _$ExportPresetUpdated(
      json['name'] as String,
      (json['areas'] as List<dynamic>)
          .map((e) => AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ExportPresetUpdatedToJson(
        _$ExportPresetUpdated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$ExportPresetRemoved _$$ExportPresetRemovedFromJson(Map json) =>
    _$ExportPresetRemoved(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ExportPresetRemovedToJson(
        _$ExportPresetRemoved instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$PackAdded _$$PackAddedFromJson(Map json) => _$PackAdded(
      NoteData.fromJson(json['pack']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PackAddedToJson(_$PackAdded instance) =>
    <String, dynamic>{
      'pack': instance.pack.toJson(),
      'type': instance.$type,
    };

_$PackUpdated _$$PackUpdatedFromJson(Map json) => _$PackUpdated(
      json['name'] as String,
      NoteData.fromJson(json['pack']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PackUpdatedToJson(_$PackUpdated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pack': instance.pack.toJson(),
      'type': instance.$type,
    };

_$PackRemoved _$$PackRemovedFromJson(Map json) => _$PackRemoved(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PackRemovedToJson(_$PackRemoved instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$AnimationAdded _$$AnimationAddedFromJson(Map json) => _$AnimationAdded(
      AnimationTrack.fromJson(
          Map<String, dynamic>.from(json['animation'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AnimationAddedToJson(_$AnimationAdded instance) =>
    <String, dynamic>{
      'animation': instance.animation.toJson(),
      'type': instance.$type,
    };

_$AnimationUpdated _$$AnimationUpdatedFromJson(Map json) => _$AnimationUpdated(
      json['name'] as String,
      AnimationTrack.fromJson(
          Map<String, dynamic>.from(json['animation'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AnimationUpdatedToJson(_$AnimationUpdated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'animation': instance.animation.toJson(),
      'type': instance.$type,
    };

_$AnimationRemoved _$$AnimationRemovedFromJson(Map json) => _$AnimationRemoved(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AnimationRemovedToJson(_$AnimationRemoved instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$PresentationModeEntered _$$PresentationModeEnteredFromJson(Map json) =>
    _$PresentationModeEntered(
      AnimationTrack.fromJson(Map<String, dynamic>.from(json['track'] as Map)),
      json['fullScreen'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationModeEnteredToJson(
        _$PresentationModeEntered instance) =>
    <String, dynamic>{
      'track': instance.track.toJson(),
      'fullScreen': instance.fullScreen,
      'type': instance.$type,
    };

_$PresentationModeExited _$$PresentationModeExitedFromJson(Map json) =>
    _$PresentationModeExited(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationModeExitedToJson(
        _$PresentationModeExited instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$PresentationTick _$$PresentationTickFromJson(Map json) => _$PresentationTick(
      json['tick'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationTickToJson(_$PresentationTick instance) =>
    <String, dynamic>{
      'tick': instance.tick,
      'type': instance.$type,
    };
