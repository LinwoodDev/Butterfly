// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NetworkingUser _$NetworkingUserFromJson(Map<String, dynamic> json) {
  return _NetworkingUser.fromJson(json);
}

/// @nodoc
mixin _$NetworkingUser {
  @DoublePointJsonConverter()
  Point<double>? get cursor => throw _privateConstructorUsedError;
  List<PadElement>? get foreground => throw _privateConstructorUsedError;

  /// Serializes this NetworkingUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NetworkingUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NetworkingUserCopyWith<NetworkingUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkingUserCopyWith<$Res> {
  factory $NetworkingUserCopyWith(
          NetworkingUser value, $Res Function(NetworkingUser) then) =
      _$NetworkingUserCopyWithImpl<$Res, NetworkingUser>;
  @useResult
  $Res call(
      {@DoublePointJsonConverter() Point<double>? cursor,
      List<PadElement>? foreground});
}

/// @nodoc
class _$NetworkingUserCopyWithImpl<$Res, $Val extends NetworkingUser>
    implements $NetworkingUserCopyWith<$Res> {
  _$NetworkingUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkingUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cursor = freezed,
    Object? foreground = freezed,
  }) {
    return _then(_value.copyWith(
      cursor: freezed == cursor
          ? _value.cursor
          : cursor // ignore: cast_nullable_to_non_nullable
              as Point<double>?,
      foreground: freezed == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as List<PadElement>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkingUserImplCopyWith<$Res>
    implements $NetworkingUserCopyWith<$Res> {
  factory _$$NetworkingUserImplCopyWith(_$NetworkingUserImpl value,
          $Res Function(_$NetworkingUserImpl) then) =
      __$$NetworkingUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DoublePointJsonConverter() Point<double>? cursor,
      List<PadElement>? foreground});
}

/// @nodoc
class __$$NetworkingUserImplCopyWithImpl<$Res>
    extends _$NetworkingUserCopyWithImpl<$Res, _$NetworkingUserImpl>
    implements _$$NetworkingUserImplCopyWith<$Res> {
  __$$NetworkingUserImplCopyWithImpl(
      _$NetworkingUserImpl _value, $Res Function(_$NetworkingUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of NetworkingUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cursor = freezed,
    Object? foreground = freezed,
  }) {
    return _then(_$NetworkingUserImpl(
      cursor: freezed == cursor
          ? _value.cursor
          : cursor // ignore: cast_nullable_to_non_nullable
              as Point<double>?,
      foreground: freezed == foreground
          ? _value._foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as List<PadElement>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkingUserImpl
    with DiagnosticableTreeMixin
    implements _NetworkingUser {
  const _$NetworkingUserImpl(
      {@DoublePointJsonConverter() this.cursor,
      final List<PadElement>? foreground})
      : _foreground = foreground;

  factory _$NetworkingUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkingUserImplFromJson(json);

  @override
  @DoublePointJsonConverter()
  final Point<double>? cursor;
  final List<PadElement>? _foreground;
  @override
  List<PadElement>? get foreground {
    final value = _foreground;
    if (value == null) return null;
    if (_foreground is EqualUnmodifiableListView) return _foreground;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkingUser(cursor: $cursor, foreground: $foreground)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkingUser'))
      ..add(DiagnosticsProperty('cursor', cursor))
      ..add(DiagnosticsProperty('foreground', foreground));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkingUserImpl &&
            (identical(other.cursor, cursor) || other.cursor == cursor) &&
            const DeepCollectionEquality()
                .equals(other._foreground, _foreground));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, cursor, const DeepCollectionEquality().hash(_foreground));

  /// Create a copy of NetworkingUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkingUserImplCopyWith<_$NetworkingUserImpl> get copyWith =>
      __$$NetworkingUserImplCopyWithImpl<_$NetworkingUserImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkingUserImplToJson(
      this,
    );
  }
}

abstract class _NetworkingUser implements NetworkingUser {
  const factory _NetworkingUser(
      {@DoublePointJsonConverter() final Point<double>? cursor,
      final List<PadElement>? foreground}) = _$NetworkingUserImpl;

  factory _NetworkingUser.fromJson(Map<String, dynamic> json) =
      _$NetworkingUserImpl.fromJson;

  @override
  @DoublePointJsonConverter()
  Point<double>? get cursor;
  @override
  List<PadElement>? get foreground;

  /// Create a copy of NetworkingUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkingUserImplCopyWith<_$NetworkingUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
