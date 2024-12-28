// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ViewOption _$ViewOptionFromJson(Map<String, dynamic> json) {
  return _ViewOption.fromJson(json);
}

/// @nodoc
mixin _$ViewOption {
  /// Serializes this ViewOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ViewOptionCopyWith<$Res> {
  factory $ViewOptionCopyWith(
          ViewOption value, $Res Function(ViewOption) then) =
      _$ViewOptionCopyWithImpl<$Res, ViewOption>;
}

/// @nodoc
class _$ViewOptionCopyWithImpl<$Res, $Val extends ViewOption>
    implements $ViewOptionCopyWith<$Res> {
  _$ViewOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ViewOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ViewOptionImplCopyWith<$Res> {
  factory _$$ViewOptionImplCopyWith(
          _$ViewOptionImpl value, $Res Function(_$ViewOptionImpl) then) =
      __$$ViewOptionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ViewOptionImplCopyWithImpl<$Res>
    extends _$ViewOptionCopyWithImpl<$Res, _$ViewOptionImpl>
    implements _$$ViewOptionImplCopyWith<$Res> {
  __$$ViewOptionImplCopyWithImpl(
      _$ViewOptionImpl _value, $Res Function(_$ViewOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ViewOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ViewOptionImpl implements _ViewOption {
  const _$ViewOptionImpl();

  factory _$ViewOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ViewOptionImplFromJson(json);

  @override
  String toString() {
    return 'ViewOption()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ViewOptionImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewOptionImplToJson(
      this,
    );
  }
}

abstract class _ViewOption implements ViewOption {
  const factory _ViewOption() = _$ViewOptionImpl;

  factory _ViewOption.fromJson(Map<String, dynamic> json) =
      _$ViewOptionImpl.fromJson;
}
