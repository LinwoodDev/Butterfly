// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchResult()';
}


}

/// @nodoc
class $SearchResultCopyWith<$Res>  {
$SearchResultCopyWith(SearchResult _, $Res Function(SearchResult) __);
}



/// @nodoc


class PageResult extends SearchResult {
  const PageResult(this.name): super._();
  

 final  String name;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageResultCopyWith<PageResult> get copyWith => _$PageResultCopyWithImpl<PageResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageResult&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SearchResult.page(name: $name)';
}


}

/// @nodoc
abstract mixin class $PageResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory $PageResultCopyWith(PageResult value, $Res Function(PageResult) _then) = _$PageResultCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$PageResultCopyWithImpl<$Res>
    implements $PageResultCopyWith<$Res> {
  _$PageResultCopyWithImpl(this._self, this._then);

  final PageResult _self;
  final $Res Function(PageResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(PageResult(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ElementResult extends SearchResult {
  const ElementResult(this.text, this.page, this.position, this.element): super._();
  

 final  String text;
 final  String page;
 final  Point<double> position;
 final  PadElement element;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementResultCopyWith<ElementResult> get copyWith => _$ElementResultCopyWithImpl<ElementResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementResult&&(identical(other.text, text) || other.text == text)&&(identical(other.page, page) || other.page == page)&&(identical(other.position, position) || other.position == position)&&(identical(other.element, element) || other.element == element));
}


@override
int get hashCode => Object.hash(runtimeType,text,page,position,element);

@override
String toString() {
  return 'SearchResult.element(text: $text, page: $page, position: $position, element: $element)';
}


}

/// @nodoc
abstract mixin class $ElementResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory $ElementResultCopyWith(ElementResult value, $Res Function(ElementResult) _then) = _$ElementResultCopyWithImpl;
@useResult
$Res call({
 String text, String page, Point<double> position, PadElement element
});


$PadElementCopyWith<$Res> get element;

}
/// @nodoc
class _$ElementResultCopyWithImpl<$Res>
    implements $ElementResultCopyWith<$Res> {
  _$ElementResultCopyWithImpl(this._self, this._then);

  final ElementResult _self;
  final $Res Function(ElementResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? page = null,Object? position = null,Object? element = null,}) {
  return _then(ElementResult(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as PadElement,
  ));
}

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PadElementCopyWith<$Res> get element {
  
  return $PadElementCopyWith<$Res>(_self.element, (value) {
    return _then(_self.copyWith(element: value));
  });
}
}

/// @nodoc


class AreaResult extends SearchResult {
  const AreaResult(this.area, this.page): super._();
  

 final  Area area;
 final  String page;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaResultCopyWith<AreaResult> get copyWith => _$AreaResultCopyWithImpl<AreaResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaResult&&(identical(other.area, area) || other.area == area)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,area,page);

@override
String toString() {
  return 'SearchResult.area(area: $area, page: $page)';
}


}

/// @nodoc
abstract mixin class $AreaResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory $AreaResultCopyWith(AreaResult value, $Res Function(AreaResult) _then) = _$AreaResultCopyWithImpl;
@useResult
$Res call({
 Area area, String page
});


$AreaCopyWith<$Res> get area;

}
/// @nodoc
class _$AreaResultCopyWithImpl<$Res>
    implements $AreaResultCopyWith<$Res> {
  _$AreaResultCopyWithImpl(this._self, this._then);

  final AreaResult _self;
  final $Res Function(AreaResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? area = null,Object? page = null,}) {
  return _then(AreaResult(
null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as Area,null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaCopyWith<$Res> get area {
  
  return $AreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}
}

/// @nodoc


class WaypointResult extends SearchResult {
  const WaypointResult(this.waypoint, this.page): super._();
  

 final  Waypoint waypoint;
 final  String page;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaypointResultCopyWith<WaypointResult> get copyWith => _$WaypointResultCopyWithImpl<WaypointResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaypointResult&&(identical(other.waypoint, waypoint) || other.waypoint == waypoint)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,waypoint,page);

@override
String toString() {
  return 'SearchResult.waypoint(waypoint: $waypoint, page: $page)';
}


}

/// @nodoc
abstract mixin class $WaypointResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory $WaypointResultCopyWith(WaypointResult value, $Res Function(WaypointResult) _then) = _$WaypointResultCopyWithImpl;
@useResult
$Res call({
 Waypoint waypoint, String page
});


$WaypointCopyWith<$Res> get waypoint;

}
/// @nodoc
class _$WaypointResultCopyWithImpl<$Res>
    implements $WaypointResultCopyWith<$Res> {
  _$WaypointResultCopyWithImpl(this._self, this._then);

  final WaypointResult _self;
  final $Res Function(WaypointResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? waypoint = null,Object? page = null,}) {
  return _then(WaypointResult(
null == waypoint ? _self.waypoint : waypoint // ignore: cast_nullable_to_non_nullable
as Waypoint,null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaypointCopyWith<$Res> get waypoint {
  
  return $WaypointCopyWith<$Res>(_self.waypoint, (value) {
    return _then(_self.copyWith(waypoint: value));
  });
}
}

/// @nodoc


class ToolResult extends SearchResult {
  const ToolResult(this.name, this.tool, this.index): super._();
  

 final  String name;
 final  Tool tool;
 final  int index;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolResultCopyWith<ToolResult> get copyWith => _$ToolResultCopyWithImpl<ToolResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolResult&&(identical(other.name, name) || other.name == name)&&(identical(other.tool, tool) || other.tool == tool)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,name,tool,index);

@override
String toString() {
  return 'SearchResult.tool(name: $name, tool: $tool, index: $index)';
}


}

/// @nodoc
abstract mixin class $ToolResultCopyWith<$Res> implements $SearchResultCopyWith<$Res> {
  factory $ToolResultCopyWith(ToolResult value, $Res Function(ToolResult) _then) = _$ToolResultCopyWithImpl;
@useResult
$Res call({
 String name, Tool tool, int index
});


$ToolCopyWith<$Res> get tool;

}
/// @nodoc
class _$ToolResultCopyWithImpl<$Res>
    implements $ToolResultCopyWith<$Res> {
  _$ToolResultCopyWithImpl(this._self, this._then);

  final ToolResult _self;
  final $Res Function(ToolResult) _then;

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? tool = null,Object? index = null,}) {
  return _then(ToolResult(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == tool ? _self.tool : tool // ignore: cast_nullable_to_non_nullable
as Tool,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ToolCopyWith<$Res> get tool {
  
  return $ToolCopyWith<$Res>(_self.tool, (value) {
    return _then(_self.copyWith(tool: value));
  });
}
}

// dart format on
