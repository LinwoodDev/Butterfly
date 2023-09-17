// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteDataState _$$_NoteDataStateFromJson(Map json) => _$_NoteDataState(
      (json['added'] as Map?)?.map(
            (k, e) => MapEntry(k as String,
                const Uint8ListJsonConverter().fromJson(e as String)),
          ) ??
          const <String, Uint8List>{},
      (json['removed'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$_NoteDataStateToJson(_$_NoteDataState instance) =>
    <String, dynamic>{
      'added': instance.added
          .map((k, e) => MapEntry(k, const Uint8ListJsonConverter().toJson(e))),
      'removed': instance.removed,
    };
