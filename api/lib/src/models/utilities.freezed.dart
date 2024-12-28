// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'utilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UtilitiesState _$UtilitiesStateFromJson(Map<String, dynamic> json) {
  return _UtilitiesState.fromJson(json);
}

/// @nodoc
mixin _$UtilitiesState {
  bool get lockCollection => throw _privateConstructorUsedError;
  bool get lockZoom => throw _privateConstructorUsedError;
  bool get lockHorizontal => throw _privateConstructorUsedError;
  bool get lockVertical => throw _privateConstructorUsedError;
  bool get fullSelection => throw _privateConstructorUsedError;

  /// Serializes this UtilitiesState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UtilitiesStateCopyWith<UtilitiesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UtilitiesStateCopyWith<$Res> {
  factory $UtilitiesStateCopyWith(
          UtilitiesState value, $Res Function(UtilitiesState) then) =
      _$UtilitiesStateCopyWithImpl<$Res, UtilitiesState>;
  @useResult
  $Res call(
      {bool lockCollection,
      bool lockZoom,
      bool lockHorizontal,
      bool lockVertical,
      bool fullSelection});
}

/// @nodoc
class _$UtilitiesStateCopyWithImpl<$Res, $Val extends UtilitiesState>
    implements $UtilitiesStateCopyWith<$Res> {
  _$UtilitiesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockCollection = null,
    Object? lockZoom = null,
    Object? lockHorizontal = null,
    Object? lockVertical = null,
    Object? fullSelection = null,
  }) {
    return _then(_value.copyWith(
      lockCollection: null == lockCollection
          ? _value.lockCollection
          : lockCollection // ignore: cast_nullable_to_non_nullable
              as bool,
      lockZoom: null == lockZoom
          ? _value.lockZoom
          : lockZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      lockHorizontal: null == lockHorizontal
          ? _value.lockHorizontal
          : lockHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
      lockVertical: null == lockVertical
          ? _value.lockVertical
          : lockVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      fullSelection: null == fullSelection
          ? _value.fullSelection
          : fullSelection // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UtilitiesStateImplCopyWith<$Res>
    implements $UtilitiesStateCopyWith<$Res> {
  factory _$$UtilitiesStateImplCopyWith(_$UtilitiesStateImpl value,
          $Res Function(_$UtilitiesStateImpl) then) =
      __$$UtilitiesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool lockCollection,
      bool lockZoom,
      bool lockHorizontal,
      bool lockVertical,
      bool fullSelection});
}

/// @nodoc
class __$$UtilitiesStateImplCopyWithImpl<$Res>
    extends _$UtilitiesStateCopyWithImpl<$Res, _$UtilitiesStateImpl>
    implements _$$UtilitiesStateImplCopyWith<$Res> {
  __$$UtilitiesStateImplCopyWithImpl(
      _$UtilitiesStateImpl _value, $Res Function(_$UtilitiesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockCollection = null,
    Object? lockZoom = null,
    Object? lockHorizontal = null,
    Object? lockVertical = null,
    Object? fullSelection = null,
  }) {
    return _then(_$UtilitiesStateImpl(
      lockCollection: null == lockCollection
          ? _value.lockCollection
          : lockCollection // ignore: cast_nullable_to_non_nullable
              as bool,
      lockZoom: null == lockZoom
          ? _value.lockZoom
          : lockZoom // ignore: cast_nullable_to_non_nullable
              as bool,
      lockHorizontal: null == lockHorizontal
          ? _value.lockHorizontal
          : lockHorizontal // ignore: cast_nullable_to_non_nullable
              as bool,
      lockVertical: null == lockVertical
          ? _value.lockVertical
          : lockVertical // ignore: cast_nullable_to_non_nullable
              as bool,
      fullSelection: null == fullSelection
          ? _value.fullSelection
          : fullSelection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UtilitiesStateImpl implements _UtilitiesState {
  const _$UtilitiesStateImpl(
      {this.lockCollection = false,
      this.lockZoom = false,
      this.lockHorizontal = false,
      this.lockVertical = false,
      this.fullSelection = false});

  factory _$UtilitiesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UtilitiesStateImplFromJson(json);

  @override
  @JsonKey()
  final bool lockCollection;
  @override
  @JsonKey()
  final bool lockZoom;
  @override
  @JsonKey()
  final bool lockHorizontal;
  @override
  @JsonKey()
  final bool lockVertical;
  @override
  @JsonKey()
  final bool fullSelection;

  @override
  String toString() {
    return 'UtilitiesState(lockCollection: $lockCollection, lockZoom: $lockZoom, lockHorizontal: $lockHorizontal, lockVertical: $lockVertical, fullSelection: $fullSelection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UtilitiesStateImpl &&
            (identical(other.lockCollection, lockCollection) ||
                other.lockCollection == lockCollection) &&
            (identical(other.lockZoom, lockZoom) ||
                other.lockZoom == lockZoom) &&
            (identical(other.lockHorizontal, lockHorizontal) ||
                other.lockHorizontal == lockHorizontal) &&
            (identical(other.lockVertical, lockVertical) ||
                other.lockVertical == lockVertical) &&
            (identical(other.fullSelection, fullSelection) ||
                other.fullSelection == fullSelection));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lockCollection, lockZoom,
      lockHorizontal, lockVertical, fullSelection);

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UtilitiesStateImplCopyWith<_$UtilitiesStateImpl> get copyWith =>
      __$$UtilitiesStateImplCopyWithImpl<_$UtilitiesStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UtilitiesStateImplToJson(
      this,
    );
  }
}

abstract class _UtilitiesState implements UtilitiesState {
  const factory _UtilitiesState(
      {final bool lockCollection,
      final bool lockZoom,
      final bool lockHorizontal,
      final bool lockVertical,
      final bool fullSelection}) = _$UtilitiesStateImpl;

  factory _UtilitiesState.fromJson(Map<String, dynamic> json) =
      _$UtilitiesStateImpl.fromJson;

  @override
  bool get lockCollection;
  @override
  bool get lockZoom;
  @override
  bool get lockHorizontal;
  @override
  bool get lockVertical;
  @override
  bool get fullSelection;

  /// Create a copy of UtilitiesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UtilitiesStateImplCopyWith<_$UtilitiesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
