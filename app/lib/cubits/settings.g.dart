// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DavRemoteStorageImpl _$$DavRemoteStorageImplFromJson(Map json) =>
    _$DavRemoteStorageImpl(
      username: json['username'] as String? ?? '',
      url: json['url'] as String? ?? '',
      path: json['path'] as String? ?? '',
      documentsPath: json['documentsPath'] as String? ?? '',
      templatesPath: json['templatesPath'] as String? ?? '',
      packsPath: json['packsPath'] as String? ?? '',
      cachedDocuments: (json['cachedDocuments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      starred: (json['starred'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      icon: _$JsonConverterFromJson<String, Uint8List>(
          json['icon'], const Uint8ListJsonConverter().fromJson),
      lastSynced: json['lastSynced'] == null
          ? null
          : DateTime.parse(json['lastSynced'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DavRemoteStorageImplToJson(
        _$DavRemoteStorageImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'url': instance.url,
      'path': instance.path,
      'documentsPath': instance.documentsPath,
      'templatesPath': instance.templatesPath,
      'packsPath': instance.packsPath,
      'cachedDocuments': instance.cachedDocuments,
      'starred': instance.starred,
      'icon': _$JsonConverterToJson<String, Uint8List>(
          instance.icon, const Uint8ListJsonConverter().toJson),
      'lastSynced': instance.lastSynced?.toIso8601String(),
      'type': instance.$type,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$LocalRemoteStorageImpl _$$LocalRemoteStorageImplFromJson(Map json) =>
    _$LocalRemoteStorageImpl(
      path: json['path'] as String? ?? '',
      documentsPath: json['documentsPath'] as String? ?? '',
      templatesPath: json['templatesPath'] as String? ?? '',
      packsPath: json['packsPath'] as String? ?? '',
      icon: _$JsonConverterFromJson<String, Uint8List>(
          json['icon'], const Uint8ListJsonConverter().fromJson),
      starred: (json['starred'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LocalRemoteStorageImplToJson(
        _$LocalRemoteStorageImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'documentsPath': instance.documentsPath,
      'templatesPath': instance.templatesPath,
      'packsPath': instance.packsPath,
      'icon': _$JsonConverterToJson<String, Uint8List>(
          instance.icon, const Uint8ListJsonConverter().toJson),
      'starred': instance.starred,
      'type': instance.$type,
    };

_$InputConfigurationImpl _$$InputConfigurationImplFromJson(Map json) =>
    _$InputConfigurationImpl(
      leftMouse: json['leftMouse'] as int?,
      middleMouse: json['middleMouse'] as int? ?? -1,
      rightMouse: json['rightMouse'] as int? ?? 1,
      pen: json['pen'] as int?,
      firstPenButton: json['firstPenButton'] as int? ?? 2,
      secondPenButton: json['secondPenButton'] as int? ?? 1,
      touch: json['touch'] as int?,
    );

Map<String, dynamic> _$$InputConfigurationImplToJson(
        _$InputConfigurationImpl instance) =>
    <String, dynamic>{
      'leftMouse': instance.leftMouse,
      'middleMouse': instance.middleMouse,
      'rightMouse': instance.rightMouse,
      'pen': instance.pen,
      'firstPenButton': instance.firstPenButton,
      'secondPenButton': instance.secondPenButton,
      'touch': instance.touch,
    };
