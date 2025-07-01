// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtilitiesState _$UtilitiesStateFromJson(Map json) => UtilitiesState(
  lockCollection: json['lockCollection'] as bool? ?? false,
  lockLayer: json['lockLayer'] as bool? ?? false,
  lockZoom: json['lockZoom'] as bool? ?? false,
  lockHorizontal: json['lockHorizontal'] as bool? ?? false,
  lockVertical: json['lockVertical'] as bool? ?? false,
  fullSelection: json['fullSelection'] as bool? ?? false,
);

Map<String, dynamic> _$UtilitiesStateToJson(UtilitiesState instance) =>
    <String, dynamic>{
      'lockCollection': instance.lockCollection,
      'lockLayer': instance.lockLayer,
      'lockZoom': instance.lockZoom,
      'lockHorizontal': instance.lockHorizontal,
      'lockVertical': instance.lockVertical,
      'fullSelection': instance.fullSelection,
    };
