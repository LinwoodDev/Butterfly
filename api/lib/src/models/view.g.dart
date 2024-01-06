// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ViewOptionImpl _$$ViewOptionImplFromJson(Map json) => _$ViewOptionImpl(
      gridColor: json['gridColor'] as int? ?? BasicColors.black,
      gridXSize: (json['gridXSize'] as num?)?.toDouble() ?? 20,
      gridYSize: (json['gridYSize'] as num?)?.toDouble() ?? 20,
    );

Map<String, dynamic> _$$ViewOptionImplToJson(_$ViewOptionImpl instance) =>
    <String, dynamic>{
      'gridColor': instance.gridColor,
      'gridXSize': instance.gridXSize,
      'gridYSize': instance.gridYSize,
    };
