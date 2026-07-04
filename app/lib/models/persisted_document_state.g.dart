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

_PersistentLockState _$PersistentLockStateFromJson(Map json) =>
    _PersistentLockState(
      lockCollection: json['lockCollection'] as bool? ?? false,
      lockLayer: json['lockLayer'] as bool? ?? false,
      lockZoom: json['lockZoom'] as bool? ?? false,
      lockHorizontal: json['lockHorizontal'] as bool? ?? false,
      lockVertical: json['lockVertical'] as bool? ?? false,
    );

Map<String, dynamic> _$PersistentLockStateToJson(
  _PersistentLockState instance,
) => <String, dynamic>{
  'lockCollection': instance.lockCollection,
  'lockLayer': instance.lockLayer,
  'lockZoom': instance.lockZoom,
  'lockHorizontal': instance.lockHorizontal,
  'lockVertical': instance.lockVertical,
};

_PersistedNavigatorState _$PersistedNavigatorStateFromJson(Map json) =>
    _PersistedNavigatorState(
      enabled: json['enabled'] as bool? ?? false,
      page: json['page'] as String? ?? 'waypoints',
    );

Map<String, dynamic> _$PersistedNavigatorStateToJson(
  _PersistedNavigatorState instance,
) => <String, dynamic>{'enabled': instance.enabled, 'page': instance.page};

_PersistedLayerState _$PersistedLayerStateFromJson(Map json) =>
    _PersistedLayerState(
      currentLayer: json['currentLayer'] as String? ?? '',
      currentCollection: json['currentCollection'] as String? ?? '',
      invisibleLayers:
          (json['invisibleLayers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$PersistedLayerStateToJson(
  _PersistedLayerState instance,
) => <String, dynamic>{
  'currentLayer': instance.currentLayer,
  'currentCollection': instance.currentCollection,
  'invisibleLayers': instance.invisibleLayers.toList(),
};

_PersistedAreaNavigatorState _$PersistedAreaNavigatorStateFromJson(Map json) =>
    _PersistedAreaNavigatorState(
      create: json['create'] as bool? ?? true,
      exact: json['exact'] as bool? ?? true,
      ask: json['ask'] as bool? ?? false,
    );

Map<String, dynamic> _$PersistedAreaNavigatorStateToJson(
  _PersistedAreaNavigatorState instance,
) => <String, dynamic>{
  'create': instance.create,
  'exact': instance.exact,
  'ask': instance.ask,
};

_PersistedDocumentState _$PersistedDocumentStateFromJson(
  Map json,
) => _PersistedDocumentState(
  version: (json['version'] as num?)?.toInt() ?? kPersistedDocumentStateVersion,
  pageName: json['pageName'] as String?,
  camera: json['camera'] == null
      ? const PersistedCameraState()
      : PersistedCameraState.fromJson(
          Map<String, dynamic>.from(json['camera'] as Map),
        ),
  locks: _readLocks(json, 'locks') == null
      ? const PersistentLockState()
      : PersistentLockState.fromJson(
          Map<String, dynamic>.from(_readLocks(json, 'locks') as Map),
        ),
  selectedTool: json['selectedTool'] == null
      ? const PersistedToolSelection()
      : PersistedToolSelection.fromJson(
          Map<String, dynamic>.from(json['selectedTool'] as Map),
        ),
  navigator: _readNavigator(json, 'navigator') == null
      ? const PersistedNavigatorState()
      : PersistedNavigatorState.fromJson(
          Map<String, dynamic>.from(_readNavigator(json, 'navigator') as Map),
        ),
  layers: _readLayers(json, 'layers') == null
      ? const PersistedLayerState()
      : PersistedLayerState.fromJson(
          Map<String, dynamic>.from(_readLayers(json, 'layers') as Map),
        ),
  areaNavigator: _readAreaNavigator(json, 'areaNavigator') == null
      ? const PersistedAreaNavigatorState()
      : PersistedAreaNavigatorState.fromJson(
          Map<String, dynamic>.from(
            _readAreaNavigator(json, 'areaNavigator') as Map,
          ),
        ),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PersistedDocumentStateToJson(
  _PersistedDocumentState instance,
) => <String, dynamic>{
  'version': instance.version,
  'pageName': instance.pageName,
  'camera': instance.camera.toJson(),
  'locks': instance.locks.toJson(),
  'selectedTool': instance.selectedTool.toJson(),
  'navigator': instance.navigator.toJson(),
  'layers': instance.layers.toJson(),
  'areaNavigator': instance.areaNavigator.toJson(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
