// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UtilitiesStateImpl _$$UtilitiesStateImplFromJson(Map json) =>
    _$UtilitiesStateImpl(
      lockCollection: json['lockCollection'] as bool? ?? false,
      lockZoom: json['lockZoom'] as bool? ?? false,
      lockHorizontal: json['lockHorizontal'] as bool? ?? false,
      lockVertical: json['lockVertical'] as bool? ?? false,
      fullSelection: json['fullSelection'] as bool? ?? false,
    );

Map<String, dynamic> _$$UtilitiesStateImplToJson(
        _$UtilitiesStateImpl instance) =>
    <String, dynamic>{
      'lockCollection': instance.lockCollection,
      'lockZoom': instance.lockZoom,
      'lockHorizontal': instance.lockHorizontal,
      'lockVertical': instance.lockVertical,
      'fullSelection': instance.fullSelection,
    };
