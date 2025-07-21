// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentPage {

 List<AnimationTrack> get animations; List<DocumentLayer> get layers; List<Background> get backgrounds; List<Waypoint> get waypoints; List<Area> get areas; Map<String, dynamic> get extra;
/// Create a copy of DocumentPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentPageCopyWith<DocumentPage> get copyWith => _$DocumentPageCopyWithImpl<DocumentPage>(this as DocumentPage, _$identity);

  /// Serializes this DocumentPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentPage&&const DeepCollectionEquality().equals(other.animations, animations)&&const DeepCollectionEquality().equals(other.layers, layers)&&const DeepCollectionEquality().equals(other.backgrounds, backgrounds)&&const DeepCollectionEquality().equals(other.waypoints, waypoints)&&const DeepCollectionEquality().equals(other.areas, areas)&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(animations),const DeepCollectionEquality().hash(layers),const DeepCollectionEquality().hash(backgrounds),const DeepCollectionEquality().hash(waypoints),const DeepCollectionEquality().hash(areas),const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'DocumentPage(animations: $animations, layers: $layers, backgrounds: $backgrounds, waypoints: $waypoints, areas: $areas, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $DocumentPageCopyWith<$Res>  {
  factory $DocumentPageCopyWith(DocumentPage value, $Res Function(DocumentPage) _then) = _$DocumentPageCopyWithImpl;
@useResult
$Res call({
 List<AnimationTrack> animations, List<DocumentLayer> layers, List<Background> backgrounds, List<Waypoint> waypoints, List<Area> areas, Map<String, dynamic> extra
});




}
/// @nodoc
class _$DocumentPageCopyWithImpl<$Res>
    implements $DocumentPageCopyWith<$Res> {
  _$DocumentPageCopyWithImpl(this._self, this._then);

  final DocumentPage _self;
  final $Res Function(DocumentPage) _then;

/// Create a copy of DocumentPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? animations = null,Object? layers = null,Object? backgrounds = null,Object? waypoints = null,Object? areas = null,Object? extra = null,}) {
  return _then(_self.copyWith(
animations: null == animations ? _self.animations : animations // ignore: cast_nullable_to_non_nullable
as List<AnimationTrack>,layers: null == layers ? _self.layers : layers // ignore: cast_nullable_to_non_nullable
as List<DocumentLayer>,backgrounds: null == backgrounds ? _self.backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<Background>,waypoints: null == waypoints ? _self.waypoints : waypoints // ignore: cast_nullable_to_non_nullable
as List<Waypoint>,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _DocumentPage extends DocumentPage {
  const _DocumentPage({final  List<AnimationTrack> animations = const [], final  List<DocumentLayer> layers = const [], final  List<Background> backgrounds = const [], final  List<Waypoint> waypoints = const [], final  List<Area> areas = const [], final  Map<String, dynamic> extra = const {}}): _animations = animations,_layers = layers,_backgrounds = backgrounds,_waypoints = waypoints,_areas = areas,_extra = extra,super._();
  factory _DocumentPage.fromJson(Map<String, dynamic> json) => _$DocumentPageFromJson(json);

 final  List<AnimationTrack> _animations;
@override@JsonKey() List<AnimationTrack> get animations {
  if (_animations is EqualUnmodifiableListView) return _animations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_animations);
}

 final  List<DocumentLayer> _layers;
@override@JsonKey() List<DocumentLayer> get layers {
  if (_layers is EqualUnmodifiableListView) return _layers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layers);
}

 final  List<Background> _backgrounds;
@override@JsonKey() List<Background> get backgrounds {
  if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgrounds);
}

 final  List<Waypoint> _waypoints;
@override@JsonKey() List<Waypoint> get waypoints {
  if (_waypoints is EqualUnmodifiableListView) return _waypoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waypoints);
}

 final  List<Area> _areas;
@override@JsonKey() List<Area> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}

 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


/// Create a copy of DocumentPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentPageCopyWith<_DocumentPage> get copyWith => __$DocumentPageCopyWithImpl<_DocumentPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentPageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentPage&&const DeepCollectionEquality().equals(other._animations, _animations)&&const DeepCollectionEquality().equals(other._layers, _layers)&&const DeepCollectionEquality().equals(other._backgrounds, _backgrounds)&&const DeepCollectionEquality().equals(other._waypoints, _waypoints)&&const DeepCollectionEquality().equals(other._areas, _areas)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_animations),const DeepCollectionEquality().hash(_layers),const DeepCollectionEquality().hash(_backgrounds),const DeepCollectionEquality().hash(_waypoints),const DeepCollectionEquality().hash(_areas),const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'DocumentPage(animations: $animations, layers: $layers, backgrounds: $backgrounds, waypoints: $waypoints, areas: $areas, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$DocumentPageCopyWith<$Res> implements $DocumentPageCopyWith<$Res> {
  factory _$DocumentPageCopyWith(_DocumentPage value, $Res Function(_DocumentPage) _then) = __$DocumentPageCopyWithImpl;
@override @useResult
$Res call({
 List<AnimationTrack> animations, List<DocumentLayer> layers, List<Background> backgrounds, List<Waypoint> waypoints, List<Area> areas, Map<String, dynamic> extra
});




}
/// @nodoc
class __$DocumentPageCopyWithImpl<$Res>
    implements _$DocumentPageCopyWith<$Res> {
  __$DocumentPageCopyWithImpl(this._self, this._then);

  final _DocumentPage _self;
  final $Res Function(_DocumentPage) _then;

/// Create a copy of DocumentPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? animations = null,Object? layers = null,Object? backgrounds = null,Object? waypoints = null,Object? areas = null,Object? extra = null,}) {
  return _then(_DocumentPage(
animations: null == animations ? _self._animations : animations // ignore: cast_nullable_to_non_nullable
as List<AnimationTrack>,layers: null == layers ? _self._layers : layers // ignore: cast_nullable_to_non_nullable
as List<DocumentLayer>,backgrounds: null == backgrounds ? _self._backgrounds : backgrounds // ignore: cast_nullable_to_non_nullable
as List<Background>,waypoints: null == waypoints ? _self._waypoints : waypoints // ignore: cast_nullable_to_non_nullable
as List<Waypoint>,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$DocumentLayer {

 String? get id; String get name; List<PadElement> get content;
/// Create a copy of DocumentLayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentLayerCopyWith<DocumentLayer> get copyWith => _$DocumentLayerCopyWithImpl<DocumentLayer>(this as DocumentLayer, _$identity);

  /// Serializes this DocumentLayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentLayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.content, content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(content));

@override
String toString() {
  return 'DocumentLayer(id: $id, name: $name, content: $content)';
}


}

/// @nodoc
abstract mixin class $DocumentLayerCopyWith<$Res>  {
  factory $DocumentLayerCopyWith(DocumentLayer value, $Res Function(DocumentLayer) _then) = _$DocumentLayerCopyWithImpl;
@useResult
$Res call({
 String? id, String name, List<PadElement> content
});




}
/// @nodoc
class _$DocumentLayerCopyWithImpl<$Res>
    implements $DocumentLayerCopyWith<$Res> {
  _$DocumentLayerCopyWithImpl(this._self, this._then);

  final DocumentLayer _self;
  final $Res Function(DocumentLayer) _then;

/// Create a copy of DocumentLayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? content = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<PadElement>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _DocumentLayer extends DocumentLayer {
  const _DocumentLayer({this.id, this.name = '', final  List<PadElement> content = const []}): _content = content,super._();
  factory _DocumentLayer.fromJson(Map<String, dynamic> json) => _$DocumentLayerFromJson(json);

@override final  String? id;
@override@JsonKey() final  String name;
 final  List<PadElement> _content;
@override@JsonKey() List<PadElement> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}


/// Create a copy of DocumentLayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentLayerCopyWith<_DocumentLayer> get copyWith => __$DocumentLayerCopyWithImpl<_DocumentLayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentLayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentLayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._content, _content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_content));

@override
String toString() {
  return 'DocumentLayer(id: $id, name: $name, content: $content)';
}


}

/// @nodoc
abstract mixin class _$DocumentLayerCopyWith<$Res> implements $DocumentLayerCopyWith<$Res> {
  factory _$DocumentLayerCopyWith(_DocumentLayer value, $Res Function(_DocumentLayer) _then) = __$DocumentLayerCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, List<PadElement> content
});




}
/// @nodoc
class __$DocumentLayerCopyWithImpl<$Res>
    implements _$DocumentLayerCopyWith<$Res> {
  __$DocumentLayerCopyWithImpl(this._self, this._then);

  final _DocumentLayer _self;
  final $Res Function(_DocumentLayer) _then;

/// Create a copy of DocumentLayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? content = null,}) {
  return _then(_DocumentLayer(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<PadElement>,
  ));
}


}

// dart format on
