// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persisted_document_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersistedToolSelection _$PersistedToolSelectionFromJson(Map json) =>
    _PersistedToolSelection(
      toolId: json['toolId'] as String?,
      toolIndex: (json['toolIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersistedToolSelectionToJson(
  _PersistedToolSelection instance,
) => <String, dynamic>{
  'toolId': instance.toolId,
  'toolIndex': instance.toolIndex,
};

_PersistedCameraState _$PersistedCameraStateFromJson(Map json) =>
    _PersistedCameraState(
      positionX: (json['positionX'] as num?)?.toDouble() ?? 0,
      positionY: (json['positionY'] as num?)?.toDouble() ?? 0,
      zoom: (json['zoom'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$PersistedCameraStateToJson(
  _PersistedCameraState instance,
) => <String, dynamic>{
  'positionX': instance.positionX,
  'positionY': instance.positionY,
  'zoom': instance.zoom,
};

_PersistedDocumentState _$PersistedDocumentStateFromJson(Map json) =>
    _PersistedDocumentState(
      version:
          (json['version'] as num?)?.toInt() ?? kPersistedDocumentStateVersion,
      pathKey: json['pathKey'] as String?,
      contentHash: json['contentHash'] as String?,
      pageName: json['pageName'] as String?,
      camera: json['camera'] == null
          ? const PersistedCameraState()
          : PersistedCameraState.fromJson(
              Map<String, dynamic>.from(json['camera'] as Map),
            ),
      utilities: json['utilities'] == null
          ? const UtilitiesState()
          : UtilitiesState.fromJson(
              Map<String, dynamic>.from(json['utilities'] as Map),
            ),
      selectedTool: json['selectedTool'] == null
          ? const PersistedToolSelection()
          : PersistedToolSelection.fromJson(
              Map<String, dynamic>.from(json['selectedTool'] as Map),
            ),
      navigatorEnabled: json['navigatorEnabled'] as bool? ?? false,
      navigatorPage: json['navigatorPage'] as String? ?? 'waypoints',
      currentLayer: json['currentLayer'] as String? ?? '',
      currentCollection: json['currentCollection'] as String? ?? '',
      invisibleLayers:
          (json['invisibleLayers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
      areaNavigatorCreate: json['areaNavigatorCreate'] as bool? ?? true,
      areaNavigatorExact: json['areaNavigatorExact'] as bool? ?? true,
      areaNavigatorAsk: json['areaNavigatorAsk'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PersistedDocumentStateToJson(
  _PersistedDocumentState instance,
) => <String, dynamic>{
  'version': instance.version,
  'pathKey': instance.pathKey,
  'contentHash': instance.contentHash,
  'pageName': instance.pageName,
  'camera': instance.camera.toJson(),
  'utilities': instance.utilities.toJson(),
  'selectedTool': instance.selectedTool.toJson(),
  'navigatorEnabled': instance.navigatorEnabled,
  'navigatorPage': instance.navigatorPage,
  'currentLayer': instance.currentLayer,
  'currentCollection': instance.currentCollection,
  'invisibleLayers': instance.invisibleLayers.toList(),
  'areaNavigatorCreate': instance.areaNavigatorCreate,
  'areaNavigatorExact': instance.areaNavigatorExact,
  'areaNavigatorAsk': instance.areaNavigatorAsk,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
