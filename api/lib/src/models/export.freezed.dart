// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ExportOptions _$ExportOptionsFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'image':
          return ImageExportOptions.fromJson(
            json
          );
                case 'svg':
          return SvgExportOptions.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ExportOptions',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ExportOptions {

 double get width; double get height; double get x; double get y; bool get renderBackground;
/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportOptionsCopyWith<ExportOptions> get copyWith => _$ExportOptionsCopyWithImpl<ExportOptions>(this as ExportOptions, _$identity);

  /// Serializes this ExportOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportOptions&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.renderBackground, renderBackground) || other.renderBackground == renderBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,x,y,renderBackground);

@override
String toString() {
  return 'ExportOptions(width: $width, height: $height, x: $x, y: $y, renderBackground: $renderBackground)';
}


}

/// @nodoc
abstract mixin class $ExportOptionsCopyWith<$Res>  {
  factory $ExportOptionsCopyWith(ExportOptions value, $Res Function(ExportOptions) _then) = _$ExportOptionsCopyWithImpl;
@useResult
$Res call({
 double width, double height, double x, double y, bool renderBackground
});




}
/// @nodoc
class _$ExportOptionsCopyWithImpl<$Res>
    implements $ExportOptionsCopyWith<$Res> {
  _$ExportOptionsCopyWithImpl(this._self, this._then);

  final ExportOptions _self;
  final $Res Function(ExportOptions) _then;

/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,Object? x = null,Object? y = null,Object? renderBackground = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,renderBackground: null == renderBackground ? _self.renderBackground : renderBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class ImageExportOptions extends ExportOptions {
  const ImageExportOptions({required this.width, required this.height, this.x = 0, this.y = 0, this.scale = 1, this.quality = 1, this.renderBackground = true, final  String? $type}): $type = $type ?? 'image',super._();
  factory ImageExportOptions.fromJson(Map<String, dynamic> json) => _$ImageExportOptionsFromJson(json);

@override final  double width;
@override final  double height;
@override@JsonKey() final  double x;
@override@JsonKey() final  double y;
@JsonKey() final  double scale;
@JsonKey() final  double quality;
@override@JsonKey() final  bool renderBackground;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageExportOptionsCopyWith<ImageExportOptions> get copyWith => _$ImageExportOptionsCopyWithImpl<ImageExportOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageExportOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageExportOptions&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.renderBackground, renderBackground) || other.renderBackground == renderBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,x,y,scale,quality,renderBackground);

@override
String toString() {
  return 'ExportOptions.image(width: $width, height: $height, x: $x, y: $y, scale: $scale, quality: $quality, renderBackground: $renderBackground)';
}


}

/// @nodoc
abstract mixin class $ImageExportOptionsCopyWith<$Res> implements $ExportOptionsCopyWith<$Res> {
  factory $ImageExportOptionsCopyWith(ImageExportOptions value, $Res Function(ImageExportOptions) _then) = _$ImageExportOptionsCopyWithImpl;
@override @useResult
$Res call({
 double width, double height, double x, double y, double scale, double quality, bool renderBackground
});




}
/// @nodoc
class _$ImageExportOptionsCopyWithImpl<$Res>
    implements $ImageExportOptionsCopyWith<$Res> {
  _$ImageExportOptionsCopyWithImpl(this._self, this._then);

  final ImageExportOptions _self;
  final $Res Function(ImageExportOptions) _then;

/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? x = null,Object? y = null,Object? scale = null,Object? quality = null,Object? renderBackground = null,}) {
  return _then(ImageExportOptions(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as double,renderBackground: null == renderBackground ? _self.renderBackground : renderBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SvgExportOptions extends ExportOptions {
  const SvgExportOptions({required this.width, required this.height, this.x = 0, this.y = 0, this.renderBackground = true, final  String? $type}): $type = $type ?? 'svg',super._();
  factory SvgExportOptions.fromJson(Map<String, dynamic> json) => _$SvgExportOptionsFromJson(json);

@override final  double width;
@override final  double height;
@override@JsonKey() final  double x;
@override@JsonKey() final  double y;
@override@JsonKey() final  bool renderBackground;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SvgExportOptionsCopyWith<SvgExportOptions> get copyWith => _$SvgExportOptionsCopyWithImpl<SvgExportOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SvgExportOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SvgExportOptions&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.renderBackground, renderBackground) || other.renderBackground == renderBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height,x,y,renderBackground);

@override
String toString() {
  return 'ExportOptions.svg(width: $width, height: $height, x: $x, y: $y, renderBackground: $renderBackground)';
}


}

/// @nodoc
abstract mixin class $SvgExportOptionsCopyWith<$Res> implements $ExportOptionsCopyWith<$Res> {
  factory $SvgExportOptionsCopyWith(SvgExportOptions value, $Res Function(SvgExportOptions) _then) = _$SvgExportOptionsCopyWithImpl;
@override @useResult
$Res call({
 double width, double height, double x, double y, bool renderBackground
});




}
/// @nodoc
class _$SvgExportOptionsCopyWithImpl<$Res>
    implements $SvgExportOptionsCopyWith<$Res> {
  _$SvgExportOptionsCopyWithImpl(this._self, this._then);

  final SvgExportOptions _self;
  final $Res Function(SvgExportOptions) _then;

/// Create a copy of ExportOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,Object? x = null,Object? y = null,Object? renderBackground = null,}) {
  return _then(SvgExportOptions(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,renderBackground: null == renderBackground ? _self.renderBackground : renderBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ExportPreset {

 String get name; List<AreaPreset> get areas;
/// Create a copy of ExportPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportPresetCopyWith<ExportPreset> get copyWith => _$ExportPresetCopyWithImpl<ExportPreset>(this as ExportPreset, _$identity);

  /// Serializes this ExportPreset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExportPreset&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.areas, areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(areas));

@override
String toString() {
  return 'ExportPreset(name: $name, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $ExportPresetCopyWith<$Res>  {
  factory $ExportPresetCopyWith(ExportPreset value, $Res Function(ExportPreset) _then) = _$ExportPresetCopyWithImpl;
@useResult
$Res call({
 String name, List<AreaPreset> areas
});




}
/// @nodoc
class _$ExportPresetCopyWithImpl<$Res>
    implements $ExportPresetCopyWith<$Res> {
  _$ExportPresetCopyWithImpl(this._self, this._then);

  final ExportPreset _self;
  final $Res Function(ExportPreset) _then;

/// Create a copy of ExportPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? areas = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,areas: null == areas ? _self.areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPreset>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ExportPreset implements ExportPreset {
  const _ExportPreset({this.name = '', final  List<AreaPreset> areas = const []}): _areas = areas;
  factory _ExportPreset.fromJson(Map<String, dynamic> json) => _$ExportPresetFromJson(json);

@override@JsonKey() final  String name;
 final  List<AreaPreset> _areas;
@override@JsonKey() List<AreaPreset> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


/// Create a copy of ExportPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExportPresetCopyWith<_ExportPreset> get copyWith => __$ExportPresetCopyWithImpl<_ExportPreset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportPresetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExportPreset&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._areas, _areas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_areas));

@override
String toString() {
  return 'ExportPreset(name: $name, areas: $areas)';
}


}

/// @nodoc
abstract mixin class _$ExportPresetCopyWith<$Res> implements $ExportPresetCopyWith<$Res> {
  factory _$ExportPresetCopyWith(_ExportPreset value, $Res Function(_ExportPreset) _then) = __$ExportPresetCopyWithImpl;
@override @useResult
$Res call({
 String name, List<AreaPreset> areas
});




}
/// @nodoc
class __$ExportPresetCopyWithImpl<$Res>
    implements _$ExportPresetCopyWith<$Res> {
  __$ExportPresetCopyWithImpl(this._self, this._then);

  final _ExportPreset _self;
  final $Res Function(_ExportPreset) _then;

/// Create a copy of ExportPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? areas = null,}) {
  return _then(_ExportPreset(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<AreaPreset>,
  ));
}


}


/// @nodoc
mixin _$AreaPreset {

 String get page; String get name; double get quality; Area? get area;
/// Create a copy of AreaPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaPresetCopyWith<AreaPreset> get copyWith => _$AreaPresetCopyWithImpl<AreaPreset>(this as AreaPreset, _$identity);

  /// Serializes this AreaPreset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaPreset&&(identical(other.page, page) || other.page == page)&&(identical(other.name, name) || other.name == name)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.area, area) || other.area == area));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,name,quality,area);

@override
String toString() {
  return 'AreaPreset(page: $page, name: $name, quality: $quality, area: $area)';
}


}

/// @nodoc
abstract mixin class $AreaPresetCopyWith<$Res>  {
  factory $AreaPresetCopyWith(AreaPreset value, $Res Function(AreaPreset) _then) = _$AreaPresetCopyWithImpl;
@useResult
$Res call({
 String page, String name, double quality, Area? area
});


$AreaCopyWith<$Res>? get area;

}
/// @nodoc
class _$AreaPresetCopyWithImpl<$Res>
    implements $AreaPresetCopyWith<$Res> {
  _$AreaPresetCopyWithImpl(this._self, this._then);

  final AreaPreset _self;
  final $Res Function(AreaPreset) _then;

/// Create a copy of AreaPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? name = null,Object? quality = null,Object? area = freezed,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as double,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area?,
  ));
}
/// Create a copy of AreaPreset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res>? get area {
    if (_self.area == null) {
    return null;
  }

  return $AreaCopyWith<$Res>(_self.area!, (value) {
    return _then(_self.copyWith(area: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _AreaPreset implements AreaPreset {
  const _AreaPreset({this.page = 'default', this.name = '', this.quality = 1, this.area});
  factory _AreaPreset.fromJson(Map<String, dynamic> json) => _$AreaPresetFromJson(json);

@override@JsonKey() final  String page;
@override@JsonKey() final  String name;
@override@JsonKey() final  double quality;
@override final  Area? area;

/// Create a copy of AreaPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaPresetCopyWith<_AreaPreset> get copyWith => __$AreaPresetCopyWithImpl<_AreaPreset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaPresetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaPreset&&(identical(other.page, page) || other.page == page)&&(identical(other.name, name) || other.name == name)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.area, area) || other.area == area));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,name,quality,area);

@override
String toString() {
  return 'AreaPreset(page: $page, name: $name, quality: $quality, area: $area)';
}


}

/// @nodoc
abstract mixin class _$AreaPresetCopyWith<$Res> implements $AreaPresetCopyWith<$Res> {
  factory _$AreaPresetCopyWith(_AreaPreset value, $Res Function(_AreaPreset) _then) = __$AreaPresetCopyWithImpl;
@override @useResult
$Res call({
 String page, String name, double quality, Area? area
});


@override $AreaCopyWith<$Res>? get area;

}
/// @nodoc
class __$AreaPresetCopyWithImpl<$Res>
    implements _$AreaPresetCopyWith<$Res> {
  __$AreaPresetCopyWithImpl(this._self, this._then);

  final _AreaPreset _self;
  final $Res Function(_AreaPreset) _then;

/// Create a copy of AreaPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? name = null,Object? quality = null,Object? area = freezed,}) {
  return _then(_AreaPreset(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as double,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area?,
  ));
}

/// Create a copy of AreaPreset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res>? get area {
    if (_self.area == null) {
    return null;
  }

  return $AreaCopyWith<$Res>(_self.area!, (value) {
    return _then(_self.copyWith(area: value));
  });
}
}

// dart format on
