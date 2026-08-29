// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkingUser implements DiagnosticableTreeMixin {

@DoublePointJsonConverter() Point<double>? get cursor; List<PadElement>? get foreground; String get name;
/// Create a copy of NetworkingUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkingUserCopyWith<NetworkingUser> get copyWith => _$NetworkingUserCopyWithImpl<NetworkingUser>(this as NetworkingUser, _$identity);

  /// Serializes this NetworkingUser to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as NetworkingUser;
  properties
    ..add(DiagnosticsProperty('type', 'NetworkingUser'))
    ..add(DiagnosticsProperty('cursor', _this.cursor))..add(DiagnosticsProperty('foreground', _this.foreground))..add(DiagnosticsProperty('name', _this.name));
}

@override
bool operator ==(Object other) {
  final _this = this as NetworkingUser;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkingUser&&(identical(other.cursor, _this.cursor) || other.cursor == _this.cursor)&&const DeepCollectionEquality().equals(other.foreground, _this.foreground)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NetworkingUser;
  return Object.hash(runtimeType,_this.cursor,const DeepCollectionEquality().hash(_this.foreground),_this.name);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as NetworkingUser;
  return 'NetworkingUser(cursor: ${_this.cursor}, foreground: ${_this.foreground}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $NetworkingUserCopyWith<$Res>  {
  factory $NetworkingUserCopyWith(NetworkingUser value, $Res Function(NetworkingUser) _then) = _$NetworkingUserCopyWithImpl;
@useResult
$Res call({
@DoublePointJsonConverter() Point<double>? cursor, List<PadElement>? foreground, String name
});




}
/// @nodoc
class _$NetworkingUserCopyWithImpl<$Res>
    implements $NetworkingUserCopyWith<$Res> {
  _$NetworkingUserCopyWithImpl(this._self, this._then);

  final NetworkingUser _self;
  final $Res Function(NetworkingUser) _then;

/// Create a copy of NetworkingUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cursor = freezed,Object? foreground = freezed,Object? name = null,}) {
  return _then(NetworkingUser(
cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Point<double>?,foreground: freezed == foreground ? _self.foreground : foreground // ignore: cast_nullable_to_non_nullable
as List<PadElement>?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _NetworkingUser with DiagnosticableTreeMixin implements NetworkingUser {
  const _NetworkingUser({@DoublePointJsonConverter() this.cursor,  List<PadElement>? foreground, this.name = ''}): _foreground = foreground;
  factory _NetworkingUser.fromJson(Map<String, dynamic> json) => _$NetworkingUserFromJson(json);

@override@DoublePointJsonConverter() final  Point<double>? cursor;
 final  List<PadElement>? _foreground;
@override List<PadElement>? get foreground {
  final value = _foreground;
  if (value == null) return null;
  if (_foreground is EqualUnmodifiableListView) return _foreground;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  String name;

/// Create a copy of NetworkingUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkingUserCopyWith<_NetworkingUser> get copyWith => __$NetworkingUserCopyWithImpl<_NetworkingUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkingUserToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'NetworkingUser'))
    ..add(DiagnosticsProperty('cursor', cursor))..add(DiagnosticsProperty('foreground', foreground))..add(DiagnosticsProperty('name', name));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkingUser&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other.foreground, _foreground)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,cursor,const DeepCollectionEquality().hash(_foreground),name);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'NetworkingUser(cursor: $cursor, foreground: $foreground, name: $name)';
}


}

/// @nodoc
abstract mixin class _$NetworkingUserCopyWith<$Res> implements $NetworkingUserCopyWith<$Res> {
  factory _$NetworkingUserCopyWith(_NetworkingUser value, $Res Function(_NetworkingUser) _then) = __$NetworkingUserCopyWithImpl;
@override @useResult
$Res call({
@DoublePointJsonConverter() Point<double>? cursor, List<PadElement>? foreground, String name
});




}
/// @nodoc
class __$NetworkingUserCopyWithImpl<$Res>
    implements _$NetworkingUserCopyWith<$Res> {
  __$NetworkingUserCopyWithImpl(this._self, this._then);

  final _NetworkingUser _self;
  final $Res Function(_NetworkingUser) _then;

/// Create a copy of NetworkingUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cursor = freezed,Object? foreground = freezed,Object? name = null,}) {
  return _then(_NetworkingUser(
cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as Point<double>?,foreground: freezed == foreground ? _self._foreground : foreground // ignore: cast_nullable_to_non_nullable
as List<PadElement>?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
