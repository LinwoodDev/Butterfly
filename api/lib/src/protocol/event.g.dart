// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PageAddedImpl _$$PageAddedImplFromJson(Map json) => _$PageAddedImpl(
      json['index'] as int?,
      json['page'] == null
          ? null
          : DocumentPage.fromJson(
              Map<String, dynamic>.from(json['page'] as Map)),
      json['type'] as String?,
    );

Map<String, dynamic> _$$PageAddedImplToJson(_$PageAddedImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'page': instance.page?.toJson(),
      'type': instance.$type,
    };

_$PageChangedImpl _$$PageChangedImplFromJson(Map json) => _$PageChangedImpl(
      json['pageName'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PageChangedImplToJson(_$PageChangedImpl instance) =>
    <String, dynamic>{
      'pageName': instance.pageName,
      'type': instance.$type,
    };

_$PageReorderedImpl _$$PageReorderedImplFromJson(Map json) =>
    _$PageReorderedImpl(
      json['page'] as String,
      json['newIndex'] as int?,
      json['type'] as String?,
    );

Map<String, dynamic> _$$PageReorderedImplToJson(_$PageReorderedImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

_$PageRenamedImpl _$$PageRenamedImplFromJson(Map json) => _$PageRenamedImpl(
      json['oldName'] as String,
      json['newName'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PageRenamedImplToJson(_$PageRenamedImpl instance) =>
    <String, dynamic>{
      'oldName': instance.oldName,
      'newName': instance.newName,
      'type': instance.$type,
    };

_$PageRemovedImpl _$$PageRemovedImplFromJson(Map json) => _$PageRemovedImpl(
      json['page'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PageRemovedImplToJson(_$PageRemovedImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'type': instance.$type,
    };

_$ThumbnailCapturedImpl _$$ThumbnailCapturedImplFromJson(Map json) =>
    _$ThumbnailCapturedImpl(
      const Uint8ListJsonConverter().fromJson(json['data'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ThumbnailCapturedImplToJson(
        _$ThumbnailCapturedImpl instance) =>
    <String, dynamic>{
      'data': const Uint8ListJsonConverter().toJson(instance.data),
      'type': instance.$type,
    };

_$ViewChangedImpl _$$ViewChangedImplFromJson(Map json) => _$ViewChangedImpl(
      ViewOption.fromJson(Map<String, dynamic>.from(json['view'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ViewChangedImplToJson(_$ViewChangedImpl instance) =>
    <String, dynamic>{
      'view': instance.view.toJson(),
      'type': instance.$type,
    };

_$UtilitiesChangedImpl _$$UtilitiesChangedImplFromJson(Map json) =>
    _$UtilitiesChangedImpl(
      UtilitiesState.fromJson(Map<String, dynamic>.from(json['state'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UtilitiesChangedImplToJson(
        _$UtilitiesChangedImpl instance) =>
    <String, dynamic>{
      'state': instance.state.toJson(),
      'type': instance.$type,
    };

_$ElementsCreatedImpl _$$ElementsCreatedImplFromJson(Map json) =>
    _$ElementsCreatedImpl(
      (json['elements'] as List<dynamic>)
          .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsCreatedImplToJson(
        _$ElementsCreatedImpl instance) =>
    <String, dynamic>{
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$ElementsChangedImpl _$$ElementsChangedImplFromJson(Map json) =>
    _$ElementsChangedImpl(
      (json['elements'] as Map).map(
        (k, e) => MapEntry(
            k as String,
            (e as List<dynamic>)
                .map((e) =>
                    PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
                .toList()),
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsChangedImplToJson(
        _$ElementsChangedImpl instance) =>
    <String, dynamic>{
      'elements': instance.elements
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'type': instance.$type,
    };

_$ElementsRemovedImpl _$$ElementsRemovedImplFromJson(Map json) =>
    _$ElementsRemovedImpl(
      (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsRemovedImplToJson(
        _$ElementsRemovedImpl instance) =>
    <String, dynamic>{
      'elements': instance.elements,
      'type': instance.$type,
    };

_$ElementsArrangedImpl _$$ElementsArrangedImplFromJson(Map json) =>
    _$ElementsArrangedImpl(
      $enumDecode(_$ArrangementEnumMap, json['arrangement']),
      (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsArrangedImplToJson(
        _$ElementsArrangedImpl instance) =>
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

_$DocumentDescriptionChangedImpl _$$DocumentDescriptionChangedImplFromJson(
        Map json) =>
    _$DocumentDescriptionChangedImpl(
      name: json['name'] as String?,
      description: json['description'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentDescriptionChangedImplToJson(
        _$DocumentDescriptionChangedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.$type,
    };

_$DocumentSavedImpl _$$DocumentSavedImplFromJson(Map json) =>
    _$DocumentSavedImpl(
      json['location'] == null
          ? null
          : AssetLocation.fromJson(
              Map<String, dynamic>.from(json['location'] as Map)),
      json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentSavedImplToJson(_$DocumentSavedImpl instance) =>
    <String, dynamic>{
      'location': instance.location?.toJson(),
      'type': instance.$type,
    };

_$ToolCreatedImpl _$$ToolCreatedImplFromJson(Map json) => _$ToolCreatedImpl(
      Tool.fromJson(Map<String, dynamic>.from(json['tool'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ToolCreatedImplToJson(_$ToolCreatedImpl instance) =>
    <String, dynamic>{
      'tool': instance.tool.toJson(),
      'type': instance.$type,
    };

_$ToolsChangedImpl _$$ToolsChangedImplFromJson(Map json) => _$ToolsChangedImpl(
      (json['tools'] as Map).map(
        (k, e) => MapEntry(int.parse(k as String),
            Tool.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ToolsChangedImplToJson(_$ToolsChangedImpl instance) =>
    <String, dynamic>{
      'tools': instance.tools.map((k, e) => MapEntry(k.toString(), e.toJson())),
      'type': instance.$type,
    };

_$ToolsRemovedImpl _$$ToolsRemovedImplFromJson(Map json) => _$ToolsRemovedImpl(
      (json['tools'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ToolsRemovedImplToJson(_$ToolsRemovedImpl instance) =>
    <String, dynamic>{
      'tools': instance.tools,
      'type': instance.$type,
    };

_$ToolReorderedImpl _$$ToolReorderedImplFromJson(Map json) =>
    _$ToolReorderedImpl(
      json['oldIndex'] as int,
      json['newIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ToolReorderedImplToJson(_$ToolReorderedImpl instance) =>
    <String, dynamic>{
      'oldIndex': instance.oldIndex,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

_$DocumentBackgroundsChangedImpl _$$DocumentBackgroundsChangedImplFromJson(
        Map json) =>
    _$DocumentBackgroundsChangedImpl(
      (json['backgrounds'] as List<dynamic>)
          .map((e) => Background.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DocumentBackgroundsChangedImplToJson(
        _$DocumentBackgroundsChangedImpl instance) =>
    <String, dynamic>{
      'backgrounds': instance.backgrounds.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$WaypointCreatedImpl _$$WaypointCreatedImplFromJson(Map json) =>
    _$WaypointCreatedImpl(
      Waypoint.fromJson(Map<String, dynamic>.from(json['waypoint'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointCreatedImplToJson(
        _$WaypointCreatedImpl instance) =>
    <String, dynamic>{
      'waypoint': instance.waypoint.toJson(),
      'type': instance.$type,
    };

_$WaypointChangedImpl _$$WaypointChangedImplFromJson(Map json) =>
    _$WaypointChangedImpl(
      json['name'] as String,
      Waypoint.fromJson(Map<String, dynamic>.from(json['waypoint'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointChangedImplToJson(
        _$WaypointChangedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'waypoint': instance.waypoint.toJson(),
      'type': instance.$type,
    };

_$WaypointRemovedImpl _$$WaypointRemovedImplFromJson(Map json) =>
    _$WaypointRemovedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointRemovedImplToJson(
        _$WaypointRemovedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$WaypointReorderedImpl _$$WaypointReorderedImplFromJson(Map json) =>
    _$WaypointReorderedImpl(
      json['name'] as String,
      json['newIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaypointReorderedImplToJson(
        _$WaypointReorderedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

_$LayerRenamedImpl _$$LayerRenamedImplFromJson(Map json) => _$LayerRenamedImpl(
      json['oldName'] as String,
      json['newName'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerRenamedImplToJson(_$LayerRenamedImpl instance) =>
    <String, dynamic>{
      'oldName': instance.oldName,
      'newName': instance.newName,
      'type': instance.$type,
    };

_$LayerRemovedImpl _$$LayerRemovedImplFromJson(Map json) => _$LayerRemovedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerRemovedImplToJson(_$LayerRemovedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$LayerElementsRemovedImpl _$$LayerElementsRemovedImplFromJson(Map json) =>
    _$LayerElementsRemovedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerElementsRemovedImplToJson(
        _$LayerElementsRemovedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$LayerVisibilityChangedImpl _$$LayerVisibilityChangedImplFromJson(Map json) =>
    _$LayerVisibilityChangedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LayerVisibilityChangedImplToJson(
        _$LayerVisibilityChangedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$CurrentLayerChangedImpl _$$CurrentLayerChangedImplFromJson(Map json) =>
    _$CurrentLayerChangedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CurrentLayerChangedImplToJson(
        _$CurrentLayerChangedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$ElementsLayerChangedImpl _$$ElementsLayerChangedImplFromJson(Map json) =>
    _$ElementsLayerChangedImpl(
      json['layer'] as String,
      (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ElementsLayerChangedImplToJson(
        _$ElementsLayerChangedImpl instance) =>
    <String, dynamic>{
      'layer': instance.layer,
      'elements': instance.elements,
      'type': instance.$type,
    };

_$AreasCreatedImpl _$$AreasCreatedImplFromJson(Map json) => _$AreasCreatedImpl(
      (json['areas'] as List<dynamic>)
          .map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreasCreatedImplToJson(_$AreasCreatedImpl instance) =>
    <String, dynamic>{
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$AreasRemovedImpl _$$AreasRemovedImplFromJson(Map json) => _$AreasRemovedImpl(
      (json['areas'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreasRemovedImplToJson(_$AreasRemovedImpl instance) =>
    <String, dynamic>{
      'areas': instance.areas,
      'type': instance.$type,
    };

_$AreaChangedImpl _$$AreaChangedImplFromJson(Map json) => _$AreaChangedImpl(
      json['name'] as String,
      Area.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaChangedImplToJson(_$AreaChangedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'area': instance.area.toJson(),
      'type': instance.$type,
    };

_$AreaReorderedImpl _$$AreaReorderedImplFromJson(Map json) =>
    _$AreaReorderedImpl(
      json['name'] as String,
      json['newIndex'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AreaReorderedImplToJson(_$AreaReorderedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

_$CurrentAreaChangedImpl _$$CurrentAreaChangedImplFromJson(Map json) =>
    _$CurrentAreaChangedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CurrentAreaChangedImplToJson(
        _$CurrentAreaChangedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$ExportPresetCreatedImpl _$$ExportPresetCreatedImplFromJson(Map json) =>
    _$ExportPresetCreatedImpl(
      json['name'] as String,
      (json['areas'] as List<dynamic>?)
              ?.map((e) =>
                  AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      json['type'] as String?,
    );

Map<String, dynamic> _$$ExportPresetCreatedImplToJson(
        _$ExportPresetCreatedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$ExportPresetUpdatedImpl _$$ExportPresetUpdatedImplFromJson(Map json) =>
    _$ExportPresetUpdatedImpl(
      json['name'] as String,
      (json['areas'] as List<dynamic>)
          .map((e) => AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ExportPresetUpdatedImplToJson(
        _$ExportPresetUpdatedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

_$ExportPresetRemovedImpl _$$ExportPresetRemovedImplFromJson(Map json) =>
    _$ExportPresetRemovedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ExportPresetRemovedImplToJson(
        _$ExportPresetRemovedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$PackAddedImpl _$$PackAddedImplFromJson(Map json) => _$PackAddedImpl(
      NoteData.fromJson(json['pack']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PackAddedImplToJson(_$PackAddedImpl instance) =>
    <String, dynamic>{
      'pack': instance.pack.toJson(),
      'type': instance.$type,
    };

_$PackUpdatedImpl _$$PackUpdatedImplFromJson(Map json) => _$PackUpdatedImpl(
      json['name'] as String,
      NoteData.fromJson(json['pack']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PackUpdatedImplToJson(_$PackUpdatedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pack': instance.pack.toJson(),
      'type': instance.$type,
    };

_$PackRemovedImpl _$$PackRemovedImplFromJson(Map json) => _$PackRemovedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PackRemovedImplToJson(_$PackRemovedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$AnimationAddedImpl _$$AnimationAddedImplFromJson(Map json) =>
    _$AnimationAddedImpl(
      AnimationTrack.fromJson(
          Map<String, dynamic>.from(json['animation'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AnimationAddedImplToJson(
        _$AnimationAddedImpl instance) =>
    <String, dynamic>{
      'animation': instance.animation.toJson(),
      'type': instance.$type,
    };

_$AnimationUpdatedImpl _$$AnimationUpdatedImplFromJson(Map json) =>
    _$AnimationUpdatedImpl(
      json['name'] as String,
      AnimationTrack.fromJson(
          Map<String, dynamic>.from(json['animation'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AnimationUpdatedImplToJson(
        _$AnimationUpdatedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'animation': instance.animation.toJson(),
      'type': instance.$type,
    };

_$AnimationRemovedImpl _$$AnimationRemovedImplFromJson(Map json) =>
    _$AnimationRemovedImpl(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AnimationRemovedImplToJson(
        _$AnimationRemovedImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$PresentationModeEnteredImpl _$$PresentationModeEnteredImplFromJson(
        Map json) =>
    _$PresentationModeEnteredImpl(
      AnimationTrack.fromJson(Map<String, dynamic>.from(json['track'] as Map)),
      json['fullScreen'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationModeEnteredImplToJson(
        _$PresentationModeEnteredImpl instance) =>
    <String, dynamic>{
      'track': instance.track.toJson(),
      'fullScreen': instance.fullScreen,
      'type': instance.$type,
    };

_$PresentationModeExitedImpl _$$PresentationModeExitedImplFromJson(Map json) =>
    _$PresentationModeExitedImpl(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationModeExitedImplToJson(
        _$PresentationModeExitedImpl instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$PresentationTickImpl _$$PresentationTickImplFromJson(Map json) =>
    _$PresentationTickImpl(
      json['tick'] as int,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PresentationTickImplToJson(
        _$PresentationTickImpl instance) =>
    <String, dynamic>{
      'tick': instance.tick,
      'type': instance.$type,
    };

_$AssetUpdatedImpl _$$AssetUpdatedImplFromJson(Map json) => _$AssetUpdatedImpl(
      json['path'] as String,
      (json['data'] as List<dynamic>).map((e) => e as int).toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AssetUpdatedImplToJson(_$AssetUpdatedImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'data': instance.data,
      'type': instance.$type,
    };
