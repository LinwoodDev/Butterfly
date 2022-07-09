// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'waypoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Waypoint _$WaypointFromJson(Map<String, dynamic> json) {
  return _Waypoint.fromJson(json);
}

/// @nodoc
mixin _$Waypoint {
  String get name => throw _privateConstructorUsedError;
  @OffsetJsonConverter()
  Offset get position => throw _privateConstructorUsedError;
  double? get scale => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaypointCopyWith<Waypoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaypointCopyWith<$Res> {
  factory $WaypointCopyWith(Waypoint value, $Res Function(Waypoint) then) =
      _$WaypointCopyWithImpl<$Res>;
  $Res call(
      {String name, @OffsetJsonConverter() Offset position, double? scale});
}

/// @nodoc
class _$WaypointCopyWithImpl<$Res> implements $WaypointCopyWith<$Res> {
  _$WaypointCopyWithImpl(this._value, this._then);

  final Waypoint _value;
  // ignore: unused_field
  final $Res Function(Waypoint) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? position = freezed,
    Object? scale = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$$_WaypointCopyWith<$Res> implements $WaypointCopyWith<$Res> {
  factory _$$_WaypointCopyWith(
          _$_Waypoint value, $Res Function(_$_Waypoint) then) =
      __$$_WaypointCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, @OffsetJsonConverter() Offset position, double? scale});
}

/// @nodoc
class __$$_WaypointCopyWithImpl<$Res> extends _$WaypointCopyWithImpl<$Res>
    implements _$$_WaypointCopyWith<$Res> {
  __$$_WaypointCopyWithImpl(
      _$_Waypoint _value, $Res Function(_$_Waypoint) _then)
      : super(_value, (v) => _then(v as _$_Waypoint));

  @override
  _$_Waypoint get _value => super._value as _$_Waypoint;

  @override
  $Res call({
    Object? name = freezed,
    Object? position = freezed,
    Object? scale = freezed,
  }) {
    return _then(_$_Waypoint(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Waypoint with DiagnosticableTreeMixin implements _Waypoint {
  const _$_Waypoint(this.name, @OffsetJsonConverter() this.position,
      [this.scale]);

  factory _$_Waypoint.fromJson(Map<String, dynamic> json) =>
      _$$_WaypointFromJson(json);

  @override
  final String name;
  @override
  @OffsetJsonConverter()
  final Offset position;
  @override
  final double? scale;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Waypoint(name: $name, position: $position, scale: $scale)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Waypoint'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('scale', scale));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Waypoint &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.scale, scale));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(scale));

  @JsonKey(ignore: true)
  @override
  _$$_WaypointCopyWith<_$_Waypoint> get copyWith =>
      __$$_WaypointCopyWithImpl<_$_Waypoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WaypointToJson(this);
  }
}

abstract class _Waypoint implements Waypoint {
  const factory _Waypoint(
      final String name, @OffsetJsonConverter() final Offset position,
      [final double? scale]) = _$_Waypoint;

  factory _Waypoint.fromJson(Map<String, dynamic> json) = _$_Waypoint.fromJson;

  @override
  String get name;
  @override
  @OffsetJsonConverter()
  Offset get position;
  @override
  double? get scale;
  @override
  @JsonKey(ignore: true)
  _$$_WaypointCopyWith<_$_Waypoint> get copyWith =>
      throw _privateConstructorUsedError;
}
