// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageAddedDetails _$PageAddedDetailsFromJson(Map json) => _PageAddedDetails(
  index: (json['index'] as num?)?.toInt(),
  page: json['page'] == null
      ? null
      : DocumentPage.fromJson(Map<String, dynamic>.from(json['page'] as Map)),
  addNumber: json['addNumber'] as bool? ?? true,
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$PageAddedDetailsToJson(_PageAddedDetails instance) =>
    <String, dynamic>{
      'index': instance.index,
      'page': instance.page?.toJson(),
      'addNumber': instance.addNumber,
      'name': instance.name,
    };

PagesAdded _$PagesAddedFromJson(Map json) => PagesAdded(
  (json['pages'] as List<dynamic>)
      .map(
        (e) => PageAddedDetails.fromJson(Map<String, dynamic>.from(e as Map)),
      )
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PagesAddedToJson(PagesAdded instance) =>
    <String, dynamic>{
      'pages': instance.pages.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

PageChanged _$PageChangedFromJson(Map json) =>
    PageChanged(json['pageName'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$PageChangedToJson(PageChanged instance) =>
    <String, dynamic>{'pageName': instance.pageName, 'type': instance.$type};

PageReordered _$PageReorderedFromJson(Map json) => PageReordered(
  json['page'] as String,
  (json['newIndex'] as num?)?.toInt(),
  json['type'] as String?,
);

Map<String, dynamic> _$PageReorderedToJson(PageReordered instance) =>
    <String, dynamic>{
      'page': instance.page,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

PageRenamed _$PageRenamedFromJson(Map json) => PageRenamed(
  json['oldName'] as String,
  json['newName'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PageRenamedToJson(PageRenamed instance) =>
    <String, dynamic>{
      'oldName': instance.oldName,
      'newName': instance.newName,
      'type': instance.$type,
    };

PageRemoved _$PageRemovedFromJson(Map json) =>
    PageRemoved(json['page'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$PageRemovedToJson(PageRemoved instance) =>
    <String, dynamic>{'page': instance.page, 'type': instance.$type};

ThumbnailCaptured _$ThumbnailCapturedFromJson(Map json) => ThumbnailCaptured(
  const Uint8ListJsonConverter().fromJson(json['data'] as String),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ThumbnailCapturedToJson(ThumbnailCaptured instance) =>
    <String, dynamic>{
      'data': const Uint8ListJsonConverter().toJson(instance.data),
      'type': instance.$type,
    };

ViewChanged _$ViewChangedFromJson(Map json) => ViewChanged(
  ViewOption.fromJson(Map<String, dynamic>.from(json['view'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ViewChangedToJson(ViewChanged instance) =>
    <String, dynamic>{'view': instance.view.toJson(), 'type': instance.$type};

UtilitiesChanged _$UtilitiesChangedFromJson(Map json) => UtilitiesChanged(
  UtilitiesState.fromJson(Map<String, dynamic>.from(json['state'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$UtilitiesChangedToJson(UtilitiesChanged instance) =>
    <String, dynamic>{'state': instance.state.toJson(), 'type': instance.$type};

ElementsCreated _$ElementsCreatedFromJson(Map json) => ElementsCreated(
  (json['elements'] as List<dynamic>)
      .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  assets:
      (json['assets'] as Map?)?.map(
        (k, e) => MapEntry(
          k as String,
          const Uint8ListJsonConverter().fromJson(e as String),
        ),
      ) ??
      const {},
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ElementsCreatedToJson(ElementsCreated instance) =>
    <String, dynamic>{
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'assets': instance.assets.map(
        (k, e) => MapEntry(k, const Uint8ListJsonConverter().toJson(e)),
      ),
      'type': instance.$type,
    };

ElementsChanged _$ElementsChangedFromJson(Map json) => ElementsChanged(
  (json['elements'] as Map).map(
    (k, e) => MapEntry(
      k as String,
      (e as List<dynamic>)
          .map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ElementsChangedToJson(ElementsChanged instance) =>
    <String, dynamic>{
      'elements': instance.elements.map(
        (k, e) => MapEntry(k, e.map((e) => e.toJson()).toList()),
      ),
      'type': instance.$type,
    };

ElementsRemoved _$ElementsRemovedFromJson(Map json) => ElementsRemoved(
  (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ElementsRemovedToJson(ElementsRemoved instance) =>
    <String, dynamic>{'elements': instance.elements, 'type': instance.$type};

ElementsArranged _$ElementsArrangedFromJson(Map json) => ElementsArranged(
  $enumDecode(_$ArrangementEnumMap, json['arrangement']),
  (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ElementsArrangedToJson(ElementsArranged instance) =>
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

DocumentDescriptionChanged _$DocumentDescriptionChangedFromJson(Map json) =>
    DocumentDescriptionChanged(
      name: json['name'] as String?,
      description: json['description'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DocumentDescriptionChangedToJson(
  DocumentDescriptionChanged instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'type': instance.$type,
};

ToolCreated _$ToolCreatedFromJson(Map json) => ToolCreated(
  Tool.fromJson(Map<String, dynamic>.from(json['tool'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ToolCreatedToJson(ToolCreated instance) =>
    <String, dynamic>{'tool': instance.tool.toJson(), 'type': instance.$type};

ToolsChanged _$ToolsChangedFromJson(Map json) => ToolsChanged(
  (json['tools'] as Map).map(
    (k, e) => MapEntry(
      int.parse(k as String),
      Tool.fromJson(Map<String, dynamic>.from(e as Map)),
    ),
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ToolsChangedToJson(ToolsChanged instance) =>
    <String, dynamic>{
      'tools': instance.tools.map((k, e) => MapEntry(k.toString(), e.toJson())),
      'type': instance.$type,
    };

ToolsRemoved _$ToolsRemovedFromJson(Map json) => ToolsRemoved(
  (json['tools'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ToolsRemovedToJson(ToolsRemoved instance) =>
    <String, dynamic>{'tools': instance.tools, 'type': instance.$type};

ToolReordered _$ToolReorderedFromJson(Map json) => ToolReordered(
  (json['oldIndex'] as num).toInt(),
  (json['newIndex'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ToolReorderedToJson(ToolReordered instance) =>
    <String, dynamic>{
      'oldIndex': instance.oldIndex,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

DocumentBackgroundsChanged _$DocumentBackgroundsChangedFromJson(Map json) =>
    DocumentBackgroundsChanged(
      (json['backgrounds'] as List<dynamic>)
          .map((e) => Background.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DocumentBackgroundsChangedToJson(
  DocumentBackgroundsChanged instance,
) => <String, dynamic>{
  'backgrounds': instance.backgrounds.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

WaypointCreated _$WaypointCreatedFromJson(Map json) => WaypointCreated(
  Waypoint.fromJson(Map<String, dynamic>.from(json['waypoint'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$WaypointCreatedToJson(WaypointCreated instance) =>
    <String, dynamic>{
      'waypoint': instance.waypoint.toJson(),
      'type': instance.$type,
    };

WaypointChanged _$WaypointChangedFromJson(Map json) => WaypointChanged(
  json['name'] as String?,
  Waypoint.fromJson(Map<String, dynamic>.from(json['waypoint'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$WaypointChangedToJson(WaypointChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'waypoint': instance.waypoint.toJson(),
      'type': instance.$type,
    };

WaypointRemoved _$WaypointRemovedFromJson(Map json) =>
    WaypointRemoved(json['name'] as String?, $type: json['type'] as String?);

Map<String, dynamic> _$WaypointRemovedToJson(WaypointRemoved instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.$type};

WaypointReordered _$WaypointReorderedFromJson(Map json) => WaypointReordered(
  json['name'] as String?,
  (json['newIndex'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$WaypointReorderedToJson(WaypointReordered instance) =>
    <String, dynamic>{
      'name': instance.name,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

CollectionRenamed _$CollectionRenamedFromJson(Map json) => CollectionRenamed(
  json['oldName'] as String,
  json['newName'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CollectionRenamedToJson(CollectionRenamed instance) =>
    <String, dynamic>{
      'oldName': instance.oldName,
      'newName': instance.newName,
      'type': instance.$type,
    };

CollectionElementsRemoved _$CollectionElementsRemovedFromJson(Map json) =>
    CollectionElementsRemoved(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CollectionElementsRemovedToJson(
  CollectionElementsRemoved instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.$type};

CurrentCollectionChanged _$CurrentCollectionChangedFromJson(Map json) =>
    CurrentCollectionChanged(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CurrentCollectionChangedToJson(
  CurrentCollectionChanged instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.$type};

CurrentLayerChanged _$CurrentLayerChangedFromJson(Map json) =>
    CurrentLayerChanged(json['name'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$CurrentLayerChangedToJson(
  CurrentLayerChanged instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.$type};

LayerCreated _$LayerCreatedFromJson(Map json) => LayerCreated(
  name: json['name'] as String? ?? '',
  id: json['id'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$LayerCreatedToJson(LayerCreated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'type': instance.$type,
    };

LayerChanged _$LayerChangedFromJson(Map json) => LayerChanged(
  json['id'] as String,
  name: json['name'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$LayerChangedToJson(LayerChanged instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.$type,
    };

LayerRemoved _$LayerRemovedFromJson(Map json) =>
    LayerRemoved(json['id'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$LayerRemovedToJson(LayerRemoved instance) =>
    <String, dynamic>{'id': instance.id, 'type': instance.$type};

LayersMerged _$LayersMergedFromJson(Map json) => LayersMerged(
  (json['layers'] as List<dynamic>).map((e) => e as String).toList(),
  json['duplicate'] as bool? ?? false,
  json['type'] as String?,
);

Map<String, dynamic> _$LayersMergedToJson(LayersMerged instance) =>
    <String, dynamic>{
      'layers': instance.layers,
      'duplicate': instance.duplicate,
      'type': instance.$type,
    };

LayerOrderChanged _$LayerOrderChangedFromJson(Map json) => LayerOrderChanged(
  json['id'] as String,
  (json['index'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$LayerOrderChangedToJson(LayerOrderChanged instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'type': instance.$type,
    };

LayerVisibilityChanged _$LayerVisibilityChangedFromJson(Map json) =>
    LayerVisibilityChanged(
      json['id'] as String,
      json['visible'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$LayerVisibilityChangedToJson(
  LayerVisibilityChanged instance,
) => <String, dynamic>{
  'id': instance.id,
  'visible': instance.visible,
  'type': instance.$type,
};

ElementsCollectionChanged _$ElementsCollectionChangedFromJson(Map json) =>
    ElementsCollectionChanged(
      (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
      json['collection'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ElementsCollectionChangedToJson(
  ElementsCollectionChanged instance,
) => <String, dynamic>{
  'elements': instance.elements,
  'collection': instance.collection,
  'type': instance.$type,
};

AreasCreated _$AreasCreatedFromJson(Map json) => AreasCreated(
  (json['areas'] as List<dynamic>)
      .map((e) => Area.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AreasCreatedToJson(AreasCreated instance) =>
    <String, dynamic>{
      'areas': instance.areas.map((e) => e.toJson()).toList(),
      'type': instance.$type,
    };

AreasRemoved _$AreasRemovedFromJson(Map json) => AreasRemoved(
  (json['areas'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AreasRemovedToJson(AreasRemoved instance) =>
    <String, dynamic>{'areas': instance.areas, 'type': instance.$type};

AreaChanged _$AreaChangedFromJson(Map json) => AreaChanged(
  json['name'] as String,
  Area.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AreaChangedToJson(AreaChanged instance) =>
    <String, dynamic>{
      'name': instance.name,
      'area': instance.area.toJson(),
      'type': instance.$type,
    };

AreaReordered _$AreaReorderedFromJson(Map json) => AreaReordered(
  json['name'] as String,
  (json['newIndex'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AreaReorderedToJson(AreaReordered instance) =>
    <String, dynamic>{
      'name': instance.name,
      'newIndex': instance.newIndex,
      'type': instance.$type,
    };

CurrentAreaChanged _$CurrentAreaChangedFromJson(Map json) =>
    CurrentAreaChanged(json['name'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$CurrentAreaChangedToJson(CurrentAreaChanged instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.$type};

ExportPresetCreated _$ExportPresetCreatedFromJson(Map json) =>
    ExportPresetCreated(
      json['name'] as String,
      (json['areas'] as List<dynamic>?)
              ?.map(
                (e) => AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          const [],
      json['type'] as String?,
    );

Map<String, dynamic> _$ExportPresetCreatedToJson(
  ExportPresetCreated instance,
) => <String, dynamic>{
  'name': instance.name,
  'areas': instance.areas.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

ExportPresetUpdated _$ExportPresetUpdatedFromJson(Map json) =>
    ExportPresetUpdated(
      json['name'] as String,
      (json['areas'] as List<dynamic>)
          .map((e) => AreaPreset.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ExportPresetUpdatedToJson(
  ExportPresetUpdated instance,
) => <String, dynamic>{
  'name': instance.name,
  'areas': instance.areas.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

ExportPresetRemoved _$ExportPresetRemovedFromJson(Map json) =>
    ExportPresetRemoved(json['name'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$ExportPresetRemovedToJson(
  ExportPresetRemoved instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.$type};

PackAdded _$PackAddedFromJson(Map json) =>
    PackAdded(NoteData.fromJson(json['pack']), $type: json['type'] as String?);

Map<String, dynamic> _$PackAddedToJson(PackAdded instance) => <String, dynamic>{
  'pack': instance.pack.toJson(),
  'type': instance.$type,
};

PackUpdated _$PackUpdatedFromJson(Map json) => PackUpdated(
  json['name'] as String,
  NoteData.fromJson(json['pack']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PackUpdatedToJson(PackUpdated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pack': instance.pack.toJson(),
      'type': instance.$type,
    };

PackRemoved _$PackRemovedFromJson(Map json) =>
    PackRemoved(json['name'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$PackRemovedToJson(PackRemoved instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.$type};

AnimationAdded _$AnimationAddedFromJson(Map json) => AnimationAdded(
  AnimationTrack.fromJson(Map<String, dynamic>.from(json['animation'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AnimationAddedToJson(AnimationAdded instance) =>
    <String, dynamic>{
      'animation': instance.animation.toJson(),
      'type': instance.$type,
    };

AnimationUpdated _$AnimationUpdatedFromJson(Map json) => AnimationUpdated(
  json['name'] as String,
  AnimationTrack.fromJson(Map<String, dynamic>.from(json['animation'] as Map)),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AnimationUpdatedToJson(AnimationUpdated instance) =>
    <String, dynamic>{
      'name': instance.name,
      'animation': instance.animation.toJson(),
      'type': instance.$type,
    };

AnimationRemoved _$AnimationRemovedFromJson(Map json) =>
    AnimationRemoved(json['name'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$AnimationRemovedToJson(AnimationRemoved instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.$type};

PresentationModeEntered _$PresentationModeEnteredFromJson(Map json) =>
    PresentationModeEntered(
      AnimationTrack.fromJson(Map<String, dynamic>.from(json['track'] as Map)),
      json['fullScreen'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PresentationModeEnteredToJson(
  PresentationModeEntered instance,
) => <String, dynamic>{
  'track': instance.track.toJson(),
  'fullScreen': instance.fullScreen,
  'type': instance.$type,
};

PresentationModeExited _$PresentationModeExitedFromJson(Map json) =>
    PresentationModeExited($type: json['type'] as String?);

Map<String, dynamic> _$PresentationModeExitedToJson(
  PresentationModeExited instance,
) => <String, dynamic>{'type': instance.$type};

PresentationTick _$PresentationTickFromJson(Map json) => PresentationTick(
  (json['tick'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PresentationTickToJson(PresentationTick instance) =>
    <String, dynamic>{'tick': instance.tick, 'type': instance.$type};

AssetUpdated _$AssetUpdatedFromJson(Map json) => AssetUpdated(
  json['path'] as String,
  (json['data'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$AssetUpdatedToJson(AssetUpdated instance) =>
    <String, dynamic>{
      'path': instance.path,
      'data': instance.data,
      'type': instance.$type,
    };

ElementsLayerConverted _$ElementsLayerConvertedFromJson(Map json) =>
    ElementsLayerConverted(
      (json['elements'] as List<dynamic>).map((e) => e as String).toList(),
      json['name'] as String? ?? '',
      json['type'] as String?,
    );

Map<String, dynamic> _$ElementsLayerConvertedToJson(
  ElementsLayerConverted instance,
) => <String, dynamic>{
  'elements': instance.elements,
  'name': instance.name,
  'type': instance.$type,
};

EncryptionChanged _$EncryptionChangedFromJson(Map json) => EncryptionChanged(
  json['password'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$EncryptionChangedToJson(EncryptionChanged instance) =>
    <String, dynamic>{'password': instance.password, 'type': instance.$type};

DocumentRebuilt _$DocumentRebuiltFromJson(Map json) => DocumentRebuilt(
  const Uint8ListJsonConverter().fromJson(json['data'] as String),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$DocumentRebuiltToJson(DocumentRebuilt instance) =>
    <String, dynamic>{
      'data': const Uint8ListJsonConverter().toJson(instance.data),
      'type': instance.$type,
    };
