// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InputConfigurationImpl _$$InputConfigurationImplFromJson(Map json) =>
    _$InputConfigurationImpl(
      leftMouse: (json['leftMouse'] as num?)?.toInt(),
      middleMouse: (json['middleMouse'] as num?)?.toInt() ?? -1,
      rightMouse: (json['rightMouse'] as num?)?.toInt() ?? 1,
      pen: (json['pen'] as num?)?.toInt(),
      firstPenButton: (json['firstPenButton'] as num?)?.toInt() ?? 2,
      secondPenButton: (json['secondPenButton'] as num?)?.toInt() ?? 1,
      touch: (json['touch'] as num?)?.toInt(),
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
