// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NetworkingUserImpl _$$NetworkingUserImplFromJson(Map json) =>
    _$NetworkingUserImpl(
      cursor: _$JsonConverterFromJson<Map<dynamic, dynamic>, Point<double>>(
          json['cursor'], const DoublePointJsonConverter().fromJson),
      foreground: (json['foreground'] as List<dynamic>?)
          ?.map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$NetworkingUserImplToJson(
        _$NetworkingUserImpl instance) =>
    <String, dynamic>{
      'cursor': _$JsonConverterToJson<Map<dynamic, dynamic>, Point<double>>(
          instance.cursor, const DoublePointJsonConverter().toJson),
      'foreground': instance.foreground?.map((e) => e.toJson()).toList(),
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
