// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoteDataState _$NoteDataStateFromJson(Map<String, dynamic> json) {
  return _NoteDataState.fromJson(json);
}

/// @nodoc
mixin _$NoteDataState {
  @Uint8ListJsonConverter()
  Map<String, Uint8List> get added => throw _privateConstructorUsedError;
  List<String> get removed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteDataStateCopyWith<NoteDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteDataStateCopyWith<$Res> {
  factory $NoteDataStateCopyWith(
          NoteDataState value, $Res Function(NoteDataState) then) =
      _$NoteDataStateCopyWithImpl<$Res, NoteDataState>;
  @useResult
  $Res call(
      {@Uint8ListJsonConverter() Map<String, Uint8List> added,
      List<String> removed});
}

/// @nodoc
class _$NoteDataStateCopyWithImpl<$Res, $Val extends NoteDataState>
    implements $NoteDataStateCopyWith<$Res> {
  _$NoteDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? added = null,
    Object? removed = null,
  }) {
    return _then(_value.copyWith(
      added: null == added
          ? _value.added
          : added // ignore: cast_nullable_to_non_nullable
              as Map<String, Uint8List>,
      removed: null == removed
          ? _value.removed
          : removed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteDataStateCopyWith<$Res>
    implements $NoteDataStateCopyWith<$Res> {
  factory _$$_NoteDataStateCopyWith(
          _$_NoteDataState value, $Res Function(_$_NoteDataState) then) =
      __$$_NoteDataStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Uint8ListJsonConverter() Map<String, Uint8List> added,
      List<String> removed});
}

/// @nodoc
class __$$_NoteDataStateCopyWithImpl<$Res>
    extends _$NoteDataStateCopyWithImpl<$Res, _$_NoteDataState>
    implements _$$_NoteDataStateCopyWith<$Res> {
  __$$_NoteDataStateCopyWithImpl(
      _$_NoteDataState _value, $Res Function(_$_NoteDataState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? added = null,
    Object? removed = null,
  }) {
    return _then(_$_NoteDataState(
      null == added
          ? _value._added
          : added // ignore: cast_nullable_to_non_nullable
              as Map<String, Uint8List>,
      null == removed
          ? _value._removed
          : removed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NoteDataState implements _NoteDataState {
  const _$_NoteDataState(
      [@Uint8ListJsonConverter()
      final Map<String, Uint8List> added = const <String, Uint8List>{},
      final List<String> removed = const <String>[]])
      : _added = added,
        _removed = removed;

  factory _$_NoteDataState.fromJson(Map<String, dynamic> json) =>
      _$$_NoteDataStateFromJson(json);

  final Map<String, Uint8List> _added;
  @override
  @JsonKey()
  @Uint8ListJsonConverter()
  Map<String, Uint8List> get added {
    if (_added is EqualUnmodifiableMapView) return _added;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_added);
  }

  final List<String> _removed;
  @override
  @JsonKey()
  List<String> get removed {
    if (_removed is EqualUnmodifiableListView) return _removed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_removed);
  }

  @override
  String toString() {
    return 'NoteDataState(added: $added, removed: $removed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NoteDataState &&
            const DeepCollectionEquality().equals(other._added, _added) &&
            const DeepCollectionEquality().equals(other._removed, _removed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_added),
      const DeepCollectionEquality().hash(_removed));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteDataStateCopyWith<_$_NoteDataState> get copyWith =>
      __$$_NoteDataStateCopyWithImpl<_$_NoteDataState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteDataStateToJson(
      this,
    );
  }
}

abstract class _NoteDataState implements NoteDataState {
  const factory _NoteDataState(
      [@Uint8ListJsonConverter() final Map<String, Uint8List> added,
      final List<String> removed]) = _$_NoteDataState;

  factory _NoteDataState.fromJson(Map<String, dynamic> json) =
      _$_NoteDataState.fromJson;

  @override
  @Uint8ListJsonConverter()
  Map<String, Uint8List> get added;
  @override
  List<String> get removed;
  @override
  @JsonKey(ignore: true)
  _$$_NoteDataStateCopyWith<_$_NoteDataState> get copyWith =>
      throw _privateConstructorUsedError;
}
