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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NetworkingInitMessage _$NetworkingInitMessageFromJson(
    Map<String, dynamic> json) {
  return _NetworkingInitMessage.fromJson(json);
}

/// @nodoc
mixin _$NetworkingInitMessage {
  List<int>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NetworkingInitMessageCopyWith<NetworkingInitMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkingInitMessageCopyWith<$Res> {
  factory $NetworkingInitMessageCopyWith(NetworkingInitMessage value,
          $Res Function(NetworkingInitMessage) then) =
      _$NetworkingInitMessageCopyWithImpl<$Res, NetworkingInitMessage>;
  @useResult
  $Res call({List<int>? data});
}

/// @nodoc
class _$NetworkingInitMessageCopyWithImpl<$Res,
        $Val extends NetworkingInitMessage>
    implements $NetworkingInitMessageCopyWith<$Res> {
  _$NetworkingInitMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkingInitMessageImplCopyWith<$Res>
    implements $NetworkingInitMessageCopyWith<$Res> {
  factory _$$NetworkingInitMessageImplCopyWith(
          _$NetworkingInitMessageImpl value,
          $Res Function(_$NetworkingInitMessageImpl) then) =
      __$$NetworkingInitMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? data});
}

/// @nodoc
class __$$NetworkingInitMessageImplCopyWithImpl<$Res>
    extends _$NetworkingInitMessageCopyWithImpl<$Res,
        _$NetworkingInitMessageImpl>
    implements _$$NetworkingInitMessageImplCopyWith<$Res> {
  __$$NetworkingInitMessageImplCopyWithImpl(_$NetworkingInitMessageImpl _value,
      $Res Function(_$NetworkingInitMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$NetworkingInitMessageImpl(
      freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NetworkingInitMessageImpl
    with DiagnosticableTreeMixin
    implements _NetworkingInitMessage {
  const _$NetworkingInitMessageImpl(final List<int>? data) : _data = data;

  factory _$NetworkingInitMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkingInitMessageImplFromJson(json);

  final List<int>? _data;
  @override
  List<int>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NetworkingInitMessage(data: $data)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NetworkingInitMessage'))
      ..add(DiagnosticsProperty('data', data));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkingInitMessageImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkingInitMessageImplCopyWith<_$NetworkingInitMessageImpl>
      get copyWith => __$$NetworkingInitMessageImplCopyWithImpl<
          _$NetworkingInitMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkingInitMessageImplToJson(
      this,
    );
  }
}

abstract class _NetworkingInitMessage implements NetworkingInitMessage {
  const factory _NetworkingInitMessage(final List<int>? data) =
      _$NetworkingInitMessageImpl;

  factory _NetworkingInitMessage.fromJson(Map<String, dynamic> json) =
      _$NetworkingInitMessageImpl.fromJson;

  @override
  List<int>? get data;
  @override
  @JsonKey(ignore: true)
  _$$NetworkingInitMessageImplCopyWith<_$NetworkingInitMessageImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NetworkingUser _$NetworkingUserFromJson(Map<String, dynamic> json) {
  return _NetworkingUser.fromJson(json);
}

/// @nodoc
mixin _$NetworkingUser {
  @DoublePointJsonConverter()
  Point<double>? get cursor => throw _privateConstructorUsedError;
  List<PadElement>? get foreground => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, cursor, const DeepCollectionEquality().hash(_foreground));

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$NetworkingUserImplCopyWith<_$NetworkingUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
