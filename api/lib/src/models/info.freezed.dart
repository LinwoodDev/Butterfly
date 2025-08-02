// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocumentInfo {

 List<Tool> get tools; List<ExportPreset> get exportPresets; ViewOption get view; Map<String, dynamic> get extra;
/// Create a copy of DocumentInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocumentInfoCopyWith<DocumentInfo> get copyWith => _$DocumentInfoCopyWithImpl<DocumentInfo>(this as DocumentInfo, _$identity);

  /// Serializes this DocumentInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocumentInfo&&const DeepCollectionEquality().equals(other.tools, tools)&&const DeepCollectionEquality().equals(other.exportPresets, exportPresets)&&(identical(other.view, view) || other.view == view)&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(tools),const DeepCollectionEquality().hash(exportPresets),view,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'DocumentInfo(tools: $tools, exportPresets: $exportPresets, view: $view, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $DocumentInfoCopyWith<$Res>  {
  factory $DocumentInfoCopyWith(DocumentInfo value, $Res Function(DocumentInfo) _then) = _$DocumentInfoCopyWithImpl;
@useResult
$Res call({
 List<Tool> tools, List<ExportPreset> exportPresets, ViewOption view, Map<String, dynamic> extra
});


$ViewOptionCopyWith<$Res> get view;

}
/// @nodoc
class _$DocumentInfoCopyWithImpl<$Res>
    implements $DocumentInfoCopyWith<$Res> {
  _$DocumentInfoCopyWithImpl(this._self, this._then);

  final DocumentInfo _self;
  final $Res Function(DocumentInfo) _then;

/// Create a copy of DocumentInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tools = null,Object? exportPresets = null,Object? view = null,Object? extra = null,}) {
  return _then(_self.copyWith(
tools: null == tools ? _self.tools : tools // ignore: cast_nullable_to_non_nullable
as List<Tool>,exportPresets: null == exportPresets ? _self.exportPresets : exportPresets // ignore: cast_nullable_to_non_nullable
as List<ExportPreset>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ViewOption,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of DocumentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ViewOptionCopyWith<$Res> get view {
  
  return $ViewOptionCopyWith<$Res>(_self.view, (value) {
    return _then(_self.copyWith(view: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _DocumentInfo implements DocumentInfo {
  const _DocumentInfo({final  List<Tool> tools = const [], final  List<ExportPreset> exportPresets = const [], this.view = const ViewOption(), final  Map<String, dynamic> extra = const {}}): _tools = tools,_exportPresets = exportPresets,_extra = extra;
  factory _DocumentInfo.fromJson(Map<String, dynamic> json) => _$DocumentInfoFromJson(json);

 final  List<Tool> _tools;
@override@JsonKey() List<Tool> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}

 final  List<ExportPreset> _exportPresets;
@override@JsonKey() List<ExportPreset> get exportPresets {
  if (_exportPresets is EqualUnmodifiableListView) return _exportPresets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exportPresets);
}

@override@JsonKey() final  ViewOption view;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


/// Create a copy of DocumentInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocumentInfoCopyWith<_DocumentInfo> get copyWith => __$DocumentInfoCopyWithImpl<_DocumentInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocumentInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocumentInfo&&const DeepCollectionEquality().equals(other._tools, _tools)&&const DeepCollectionEquality().equals(other._exportPresets, _exportPresets)&&(identical(other.view, view) || other.view == view)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_tools),const DeepCollectionEquality().hash(_exportPresets),view,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'DocumentInfo(tools: $tools, exportPresets: $exportPresets, view: $view, extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$DocumentInfoCopyWith<$Res> implements $DocumentInfoCopyWith<$Res> {
  factory _$DocumentInfoCopyWith(_DocumentInfo value, $Res Function(_DocumentInfo) _then) = __$DocumentInfoCopyWithImpl;
@override @useResult
$Res call({
 List<Tool> tools, List<ExportPreset> exportPresets, ViewOption view, Map<String, dynamic> extra
});


@override $ViewOptionCopyWith<$Res> get view;

}
/// @nodoc
class __$DocumentInfoCopyWithImpl<$Res>
    implements _$DocumentInfoCopyWith<$Res> {
  __$DocumentInfoCopyWithImpl(this._self, this._then);

  final _DocumentInfo _self;
  final $Res Function(_DocumentInfo) _then;

/// Create a copy of DocumentInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tools = null,Object? exportPresets = null,Object? view = null,Object? extra = null,}) {
  return _then(_DocumentInfo(
tools: null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<Tool>,exportPresets: null == exportPresets ? _self._exportPresets : exportPresets // ignore: cast_nullable_to_non_nullable
as List<ExportPreset>,view: null == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as ViewOption,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of DocumentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ViewOptionCopyWith<$Res> get view {
  
  return $ViewOptionCopyWith<$Res>(_self.view, (value) {
    return _then(_self.copyWith(view: value));
  });
}
}

// dart format on
