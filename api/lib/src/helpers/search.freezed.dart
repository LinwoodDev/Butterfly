// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) page,
    required TResult Function(String text, String page, Point<double> position,
            PadElement element)
        element,
    required TResult Function(Area area, String page) area,
    required TResult Function(Waypoint waypoint, String page) waypoint,
    required TResult Function(String name, Tool tool, int index) tool,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? page,
    TResult? Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult? Function(Area area, String page)? area,
    TResult? Function(Waypoint waypoint, String page)? waypoint,
    TResult? Function(String name, Tool tool, int index)? tool,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? page,
    TResult Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult Function(Area area, String page)? area,
    TResult Function(Waypoint waypoint, String page)? waypoint,
    TResult Function(String name, Tool tool, int index)? tool,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageResult value) page,
    required TResult Function(ElementResult value) element,
    required TResult Function(AreaResult value) area,
    required TResult Function(WaypointResult value) waypoint,
    required TResult Function(ToolResult value) tool,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageResult value)? page,
    TResult? Function(ElementResult value)? element,
    TResult? Function(AreaResult value)? area,
    TResult? Function(WaypointResult value)? waypoint,
    TResult? Function(ToolResult value)? tool,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageResult value)? page,
    TResult Function(ElementResult value)? element,
    TResult Function(AreaResult value)? area,
    TResult Function(WaypointResult value)? waypoint,
    TResult Function(ToolResult value)? tool,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
          SearchResult value, $Res Function(SearchResult) then) =
      _$SearchResultCopyWithImpl<$Res, SearchResult>;
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PageResultImplCopyWith<$Res> {
  factory _$$PageResultImplCopyWith(
          _$PageResultImpl value, $Res Function(_$PageResultImpl) then) =
      __$$PageResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$PageResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$PageResultImpl>
    implements _$$PageResultImplCopyWith<$Res> {
  __$$PageResultImplCopyWithImpl(
      _$PageResultImpl _value, $Res Function(_$PageResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$PageResultImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PageResultImpl extends PageResult {
  const _$PageResultImpl(this.name) : super._();

  @override
  final String name;

  @override
  String toString() {
    return 'SearchResult.page(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageResultImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PageResultImplCopyWith<_$PageResultImpl> get copyWith =>
      __$$PageResultImplCopyWithImpl<_$PageResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) page,
    required TResult Function(String text, String page, Point<double> position,
            PadElement element)
        element,
    required TResult Function(Area area, String page) area,
    required TResult Function(Waypoint waypoint, String page) waypoint,
    required TResult Function(String name, Tool tool, int index) tool,
  }) {
    return page(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? page,
    TResult? Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult? Function(Area area, String page)? area,
    TResult? Function(Waypoint waypoint, String page)? waypoint,
    TResult? Function(String name, Tool tool, int index)? tool,
  }) {
    return page?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? page,
    TResult Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult Function(Area area, String page)? area,
    TResult Function(Waypoint waypoint, String page)? waypoint,
    TResult Function(String name, Tool tool, int index)? tool,
    required TResult orElse(),
  }) {
    if (page != null) {
      return page(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageResult value) page,
    required TResult Function(ElementResult value) element,
    required TResult Function(AreaResult value) area,
    required TResult Function(WaypointResult value) waypoint,
    required TResult Function(ToolResult value) tool,
  }) {
    return page(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageResult value)? page,
    TResult? Function(ElementResult value)? element,
    TResult? Function(AreaResult value)? area,
    TResult? Function(WaypointResult value)? waypoint,
    TResult? Function(ToolResult value)? tool,
  }) {
    return page?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageResult value)? page,
    TResult Function(ElementResult value)? element,
    TResult Function(AreaResult value)? area,
    TResult Function(WaypointResult value)? waypoint,
    TResult Function(ToolResult value)? tool,
    required TResult orElse(),
  }) {
    if (page != null) {
      return page(this);
    }
    return orElse();
  }
}

abstract class PageResult extends SearchResult {
  const factory PageResult(final String name) = _$PageResultImpl;
  const PageResult._() : super._();

  String get name;
  @JsonKey(ignore: true)
  _$$PageResultImplCopyWith<_$PageResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementResultImplCopyWith<$Res> {
  factory _$$ElementResultImplCopyWith(
          _$ElementResultImpl value, $Res Function(_$ElementResultImpl) then) =
      __$$ElementResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String text, String page, Point<double> position, PadElement element});

  $PadElementCopyWith<$Res> get element;
}

/// @nodoc
class __$$ElementResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$ElementResultImpl>
    implements _$$ElementResultImplCopyWith<$Res> {
  __$$ElementResultImplCopyWithImpl(
      _$ElementResultImpl _value, $Res Function(_$ElementResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? page = null,
    Object? position = null,
    Object? element = null,
  }) {
    return _then(_$ElementResultImpl(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Point<double>,
      null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as PadElement,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PadElementCopyWith<$Res> get element {
    return $PadElementCopyWith<$Res>(_value.element, (value) {
      return _then(_value.copyWith(element: value));
    });
  }
}

/// @nodoc

class _$ElementResultImpl extends ElementResult {
  const _$ElementResultImpl(this.text, this.page, this.position, this.element)
      : super._();

  @override
  final String text;
  @override
  final String page;
  @override
  final Point<double> position;
  @override
  final PadElement element;

  @override
  String toString() {
    return 'SearchResult.element(text: $text, page: $page, position: $position, element: $element)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementResultImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.element, element) || other.element == element));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, page, position, element);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementResultImplCopyWith<_$ElementResultImpl> get copyWith =>
      __$$ElementResultImplCopyWithImpl<_$ElementResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) page,
    required TResult Function(String text, String page, Point<double> position,
            PadElement element)
        element,
    required TResult Function(Area area, String page) area,
    required TResult Function(Waypoint waypoint, String page) waypoint,
    required TResult Function(String name, Tool tool, int index) tool,
  }) {
    return element(text, this.page, position, this.element);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? page,
    TResult? Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult? Function(Area area, String page)? area,
    TResult? Function(Waypoint waypoint, String page)? waypoint,
    TResult? Function(String name, Tool tool, int index)? tool,
  }) {
    return element?.call(text, this.page, position, this.element);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? page,
    TResult Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult Function(Area area, String page)? area,
    TResult Function(Waypoint waypoint, String page)? waypoint,
    TResult Function(String name, Tool tool, int index)? tool,
    required TResult orElse(),
  }) {
    if (element != null) {
      return element(text, this.page, position, this.element);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageResult value) page,
    required TResult Function(ElementResult value) element,
    required TResult Function(AreaResult value) area,
    required TResult Function(WaypointResult value) waypoint,
    required TResult Function(ToolResult value) tool,
  }) {
    return element(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageResult value)? page,
    TResult? Function(ElementResult value)? element,
    TResult? Function(AreaResult value)? area,
    TResult? Function(WaypointResult value)? waypoint,
    TResult? Function(ToolResult value)? tool,
  }) {
    return element?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageResult value)? page,
    TResult Function(ElementResult value)? element,
    TResult Function(AreaResult value)? area,
    TResult Function(WaypointResult value)? waypoint,
    TResult Function(ToolResult value)? tool,
    required TResult orElse(),
  }) {
    if (element != null) {
      return element(this);
    }
    return orElse();
  }
}

abstract class ElementResult extends SearchResult {
  const factory ElementResult(
      final String text,
      final String page,
      final Point<double> position,
      final PadElement element) = _$ElementResultImpl;
  const ElementResult._() : super._();

  String get text;
  String get page;
  Point<double> get position;
  PadElement get element;
  @JsonKey(ignore: true)
  _$$ElementResultImplCopyWith<_$ElementResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreaResultImplCopyWith<$Res> {
  factory _$$AreaResultImplCopyWith(
          _$AreaResultImpl value, $Res Function(_$AreaResultImpl) then) =
      __$$AreaResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Area area, String page});

  $AreaCopyWith<$Res> get area;
}

/// @nodoc
class __$$AreaResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$AreaResultImpl>
    implements _$$AreaResultImplCopyWith<$Res> {
  __$$AreaResultImplCopyWithImpl(
      _$AreaResultImpl _value, $Res Function(_$AreaResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? page = null,
  }) {
    return _then(_$AreaResultImpl(
      null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as Area,
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaCopyWith<$Res> get area {
    return $AreaCopyWith<$Res>(_value.area, (value) {
      return _then(_value.copyWith(area: value));
    });
  }
}

/// @nodoc

class _$AreaResultImpl extends AreaResult {
  const _$AreaResultImpl(this.area, this.page) : super._();

  @override
  final Area area;
  @override
  final String page;

  @override
  String toString() {
    return 'SearchResult.area(area: $area, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaResultImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, area, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaResultImplCopyWith<_$AreaResultImpl> get copyWith =>
      __$$AreaResultImplCopyWithImpl<_$AreaResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) page,
    required TResult Function(String text, String page, Point<double> position,
            PadElement element)
        element,
    required TResult Function(Area area, String page) area,
    required TResult Function(Waypoint waypoint, String page) waypoint,
    required TResult Function(String name, Tool tool, int index) tool,
  }) {
    return area(this.area, this.page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? page,
    TResult? Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult? Function(Area area, String page)? area,
    TResult? Function(Waypoint waypoint, String page)? waypoint,
    TResult? Function(String name, Tool tool, int index)? tool,
  }) {
    return area?.call(this.area, this.page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? page,
    TResult Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult Function(Area area, String page)? area,
    TResult Function(Waypoint waypoint, String page)? waypoint,
    TResult Function(String name, Tool tool, int index)? tool,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(this.area, this.page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageResult value) page,
    required TResult Function(ElementResult value) element,
    required TResult Function(AreaResult value) area,
    required TResult Function(WaypointResult value) waypoint,
    required TResult Function(ToolResult value) tool,
  }) {
    return area(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageResult value)? page,
    TResult? Function(ElementResult value)? element,
    TResult? Function(AreaResult value)? area,
    TResult? Function(WaypointResult value)? waypoint,
    TResult? Function(ToolResult value)? tool,
  }) {
    return area?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageResult value)? page,
    TResult Function(ElementResult value)? element,
    TResult Function(AreaResult value)? area,
    TResult Function(WaypointResult value)? waypoint,
    TResult Function(ToolResult value)? tool,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(this);
    }
    return orElse();
  }
}

abstract class AreaResult extends SearchResult {
  const factory AreaResult(final Area area, final String page) =
      _$AreaResultImpl;
  const AreaResult._() : super._();

  Area get area;
  String get page;
  @JsonKey(ignore: true)
  _$$AreaResultImplCopyWith<_$AreaResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaypointResultImplCopyWith<$Res> {
  factory _$$WaypointResultImplCopyWith(_$WaypointResultImpl value,
          $Res Function(_$WaypointResultImpl) then) =
      __$$WaypointResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Waypoint waypoint, String page});

  $WaypointCopyWith<$Res> get waypoint;
}

/// @nodoc
class __$$WaypointResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$WaypointResultImpl>
    implements _$$WaypointResultImplCopyWith<$Res> {
  __$$WaypointResultImplCopyWithImpl(
      _$WaypointResultImpl _value, $Res Function(_$WaypointResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waypoint = null,
    Object? page = null,
  }) {
    return _then(_$WaypointResultImpl(
      null == waypoint
          ? _value.waypoint
          : waypoint // ignore: cast_nullable_to_non_nullable
              as Waypoint,
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $WaypointCopyWith<$Res> get waypoint {
    return $WaypointCopyWith<$Res>(_value.waypoint, (value) {
      return _then(_value.copyWith(waypoint: value));
    });
  }
}

/// @nodoc

class _$WaypointResultImpl extends WaypointResult {
  const _$WaypointResultImpl(this.waypoint, this.page) : super._();

  @override
  final Waypoint waypoint;
  @override
  final String page;

  @override
  String toString() {
    return 'SearchResult.waypoint(waypoint: $waypoint, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaypointResultImpl &&
            (identical(other.waypoint, waypoint) ||
                other.waypoint == waypoint) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, waypoint, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointResultImplCopyWith<_$WaypointResultImpl> get copyWith =>
      __$$WaypointResultImplCopyWithImpl<_$WaypointResultImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) page,
    required TResult Function(String text, String page, Point<double> position,
            PadElement element)
        element,
    required TResult Function(Area area, String page) area,
    required TResult Function(Waypoint waypoint, String page) waypoint,
    required TResult Function(String name, Tool tool, int index) tool,
  }) {
    return waypoint(this.waypoint, this.page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? page,
    TResult? Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult? Function(Area area, String page)? area,
    TResult? Function(Waypoint waypoint, String page)? waypoint,
    TResult? Function(String name, Tool tool, int index)? tool,
  }) {
    return waypoint?.call(this.waypoint, this.page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? page,
    TResult Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult Function(Area area, String page)? area,
    TResult Function(Waypoint waypoint, String page)? waypoint,
    TResult Function(String name, Tool tool, int index)? tool,
    required TResult orElse(),
  }) {
    if (waypoint != null) {
      return waypoint(this.waypoint, this.page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageResult value) page,
    required TResult Function(ElementResult value) element,
    required TResult Function(AreaResult value) area,
    required TResult Function(WaypointResult value) waypoint,
    required TResult Function(ToolResult value) tool,
  }) {
    return waypoint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageResult value)? page,
    TResult? Function(ElementResult value)? element,
    TResult? Function(AreaResult value)? area,
    TResult? Function(WaypointResult value)? waypoint,
    TResult? Function(ToolResult value)? tool,
  }) {
    return waypoint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageResult value)? page,
    TResult Function(ElementResult value)? element,
    TResult Function(AreaResult value)? area,
    TResult Function(WaypointResult value)? waypoint,
    TResult Function(ToolResult value)? tool,
    required TResult orElse(),
  }) {
    if (waypoint != null) {
      return waypoint(this);
    }
    return orElse();
  }
}

abstract class WaypointResult extends SearchResult {
  const factory WaypointResult(final Waypoint waypoint, final String page) =
      _$WaypointResultImpl;
  const WaypointResult._() : super._();

  Waypoint get waypoint;
  String get page;
  @JsonKey(ignore: true)
  _$$WaypointResultImplCopyWith<_$WaypointResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToolResultImplCopyWith<$Res> {
  factory _$$ToolResultImplCopyWith(
          _$ToolResultImpl value, $Res Function(_$ToolResultImpl) then) =
      __$$ToolResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, Tool tool, int index});

  $ToolCopyWith<$Res> get tool;
}

/// @nodoc
class __$$ToolResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$ToolResultImpl>
    implements _$$ToolResultImplCopyWith<$Res> {
  __$$ToolResultImplCopyWithImpl(
      _$ToolResultImpl _value, $Res Function(_$ToolResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tool = null,
    Object? index = null,
  }) {
    return _then(_$ToolResultImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as Tool,
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ToolCopyWith<$Res> get tool {
    return $ToolCopyWith<$Res>(_value.tool, (value) {
      return _then(_value.copyWith(tool: value));
    });
  }
}

/// @nodoc

class _$ToolResultImpl extends ToolResult {
  const _$ToolResultImpl(this.name, this.tool, this.index) : super._();

  @override
  final String name;
  @override
  final Tool tool;
  @override
  final int index;

  @override
  String toString() {
    return 'SearchResult.tool(name: $name, tool: $tool, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolResultImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, tool, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolResultImplCopyWith<_$ToolResultImpl> get copyWith =>
      __$$ToolResultImplCopyWithImpl<_$ToolResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) page,
    required TResult Function(String text, String page, Point<double> position,
            PadElement element)
        element,
    required TResult Function(Area area, String page) area,
    required TResult Function(Waypoint waypoint, String page) waypoint,
    required TResult Function(String name, Tool tool, int index) tool,
  }) {
    return tool(name, this.tool, index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? page,
    TResult? Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult? Function(Area area, String page)? area,
    TResult? Function(Waypoint waypoint, String page)? waypoint,
    TResult? Function(String name, Tool tool, int index)? tool,
  }) {
    return tool?.call(name, this.tool, index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? page,
    TResult Function(String text, String page, Point<double> position,
            PadElement element)?
        element,
    TResult Function(Area area, String page)? area,
    TResult Function(Waypoint waypoint, String page)? waypoint,
    TResult Function(String name, Tool tool, int index)? tool,
    required TResult orElse(),
  }) {
    if (tool != null) {
      return tool(name, this.tool, index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageResult value) page,
    required TResult Function(ElementResult value) element,
    required TResult Function(AreaResult value) area,
    required TResult Function(WaypointResult value) waypoint,
    required TResult Function(ToolResult value) tool,
  }) {
    return tool(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageResult value)? page,
    TResult? Function(ElementResult value)? element,
    TResult? Function(AreaResult value)? area,
    TResult? Function(WaypointResult value)? waypoint,
    TResult? Function(ToolResult value)? tool,
  }) {
    return tool?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageResult value)? page,
    TResult Function(ElementResult value)? element,
    TResult Function(AreaResult value)? area,
    TResult Function(WaypointResult value)? waypoint,
    TResult Function(ToolResult value)? tool,
    required TResult orElse(),
  }) {
    if (tool != null) {
      return tool(this);
    }
    return orElse();
  }
}

abstract class ToolResult extends SearchResult {
  const factory ToolResult(
      final String name, final Tool tool, final int index) = _$ToolResultImpl;
  const ToolResult._() : super._();

  String get name;
  Tool get tool;
  int get index;
  @JsonKey(ignore: true)
  _$$ToolResultImplCopyWith<_$ToolResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
