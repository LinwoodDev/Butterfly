// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssetLocation _$$_AssetLocationFromJson(Map json) => _$_AssetLocation(
      remote: json['remote'] as String? ?? '',
      path: json['path'] as String,
      absolute: json['absolute'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AssetLocationToJson(_$_AssetLocation instance) =>
    <String, dynamic>{
      'remote': instance.remote,
      'path': instance.path,
      'absolute': instance.absolute,
    };
