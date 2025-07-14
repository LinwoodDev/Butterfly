// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waypoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Waypoint {
  String? get name;
  @DoublePointJsonConverter()
  Point<double> get position;
  double? get scale;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WaypointCopyWith<Waypoint> get copyWith =>
      _$WaypointCopyWithImpl<Waypoint>(this as Waypoint, _$identity);

  /// Serializes this Waypoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Waypoint &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.scale, scale) || other.scale == scale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, position, scale);

  @override
  String toString() {
    return 'Waypoint(name: $name, position: $position, scale: $scale)';
  }
}

/// @nodoc
abstract mixin class $WaypointCopyWith<$Res> {
  factory $WaypointCopyWith(Waypoint value, $Res Function(Waypoint) _then) =
      _$WaypointCopyWithImpl;
  @useResult
  $Res call(
      {String? name,
      @DoublePointJsonConverter() Point<double> position,
      double? scale});
}

/// @nodoc
class _$WaypointCopyWithImpl<$Res> implements $WaypointCopyWith<$Res> {
  _$WaypointCopyWithImpl(this._self, this._then);

  final Waypoint _self;
  final $Res Function(Waypoint) _then;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? position = null,
    Object? scale = freezed,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      scale: freezed == scale
          ? _self.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Waypoint implements Waypoint {
  const _Waypoint(this.name, @DoublePointJsonConverter() this.position,
      [this.scale]);
  factory _Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);

  @override
  final String? name;
  @override
  @DoublePointJsonConverter()
  final Point<double> position;
  @override
  final double? scale;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WaypointCopyWith<_Waypoint> get copyWith =>
      __$WaypointCopyWithImpl<_Waypoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WaypointToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Waypoint &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.scale, scale) || other.scale == scale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, position, scale);

  @override
  String toString() {
    return 'Waypoint(name: $name, position: $position, scale: $scale)';
  }
}

/// @nodoc
abstract mixin class _$WaypointCopyWith<$Res>
    implements $WaypointCopyWith<$Res> {
  factory _$WaypointCopyWith(_Waypoint value, $Res Function(_Waypoint) _then) =
      __$WaypointCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? name,
      @DoublePointJsonConverter() Point<double> position,
      double? scale});
}

/// @nodoc
class __$WaypointCopyWithImpl<$Res> implements _$WaypointCopyWith<$Res> {
  __$WaypointCopyWithImpl(this._self, this._then);

  final _Waypoint _self;
  final $Res Function(_Waypoint) _then;

  /// Create a copy of Waypoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? position = null,
    Object? scale = freezed,
  }) {
    return _then(_Waypoint(
      freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      freezed == scale
          ? _self.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
