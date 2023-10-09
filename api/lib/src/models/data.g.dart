// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteDataStateImpl _$$NoteDataStateImplFromJson(Map json) =>
    _$NoteDataStateImpl(
      (json['added'] as Map?)?.map(
            (k, e) => MapEntry(k as String,
                const Uint8ListJsonConverter().fromJson(e as String)),
          ) ??
          const <String, Uint8List>{},
      (json['removed'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$NoteDataStateImplToJson(_$NoteDataStateImpl instance) =>
    <String, dynamic>{
      'added': instance.added
          .map((k, e) => MapEntry(k, const Uint8ListJsonConverter().toJson(e))),
      'removed': instance.removed,
    };
