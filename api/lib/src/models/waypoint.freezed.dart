// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waypoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Waypoint {


/// Create a copy of Waypoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointCopyWith<Waypoint> get copyWith => _$WaypointCopyWithImpl<Waypoint>(this as Waypoint, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Waypoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Waypoint&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.scale, _this.scale) || other.scale == _this.scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Waypoint;
  return Object.hash(runtimeType,_this.name,_this.position,_this.scale);
}

@override
String toString() {
  final _this = this as Waypoint;
  return 'Waypoint(name: ${_this.name}, position: ${_this.position}, scale: ${_this.scale})';
}


}

/// @nodoc
abstract mixin class $WaypointCopyWith<$Res>  {
  factory $WaypointCopyWith(Waypoint value, $Res Function(Waypoint) _then) = _$WaypointCopyWithImpl;
@useResult
$Res call({
 String? name, Point<double> position, double? scale
});




}
/// @nodoc
class _$WaypointCopyWithImpl<$Res>
    implements $WaypointCopyWith<$Res> {
  _$WaypointCopyWithImpl(this._self, this._then);

  final Waypoint _self;
  final $Res Function(Waypoint) _then;

/// Create a copy of Waypoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? position = null,Object? scale = freezed,}) {
  return _then(Waypoint(
freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,freezed == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}



// dart format on
