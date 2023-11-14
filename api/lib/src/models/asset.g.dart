// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssetLocationImpl _$$AssetLocationImplFromJson(Map json) =>
    _$AssetLocationImpl(
      remote: json['remote'] as String? ?? '',
      path: json['path'] as String,
      absolute: json['absolute'] as bool? ?? false,
    );

Map<String, dynamic> _$$AssetLocationImplToJson(_$AssetLocationImpl instance) =>
    <String, dynamic>{
      'remote': instance.remote,
      'path': instance.path,
      'absolute': instance.absolute,
    };
