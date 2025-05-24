// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkingUser _$NetworkingUserFromJson(Map json) => _NetworkingUser(
  cursor: _$JsonConverterFromJson<Map<dynamic, dynamic>, Point<double>>(
    json['cursor'],
    const DoublePointJsonConverter().fromJson,
  ),
  foreground: (json['foreground'] as List<dynamic>?)
      ?.map((e) => PadElement.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$NetworkingUserToJson(_NetworkingUser instance) =>
    <String, dynamic>{
      'cursor': _$JsonConverterToJson<Map<dynamic, dynamic>, Point<double>>(
        instance.cursor,
        const DoublePointJsonConverter().toJson,
      ),
      'foreground': instance.foreground?.map((e) => e.toJson()).toList(),
      'name': instance.name,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
