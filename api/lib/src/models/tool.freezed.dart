// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tool _$ToolFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'select':
      return SelectTool.fromJson(json);
    case 'hand':
      return HandTool.fromJson(json);
    case 'import':
      return ImportTool.fromJson(json);
    case 'undo':
      return UndoTool.fromJson(json);
    case 'redo':
      return RedoTool.fromJson(json);
    case 'label':
      return LabelTool.fromJson(json);
    case 'pen':
      return PenTool.fromJson(json);
    case 'eraser':
      return EraserTool.fromJson(json);
    case 'pathEraser':
      return PathEraserTool.fromJson(json);
    case 'collection':
      return CollectionTool.fromJson(json);
    case 'area':
      return AreaTool.fromJson(json);
    case 'laser':
      return LaserTool.fromJson(json);
    case 'shape':
      return ShapeTool.fromJson(json);
    case 'stamp':
      return StampTool.fromJson(json);
    case 'presentation':
      return PresentationTool.fromJson(json);
    case 'spacer':
      return SpacerTool.fromJson(json);
    case 'fullSceen':
      return FullScreenTool.fromJson(json);
    case 'asset':
      return AssetTool.fromJson(json);
    case 'export':
      return ExportTool.fromJson(json);
    case 'texture':
      return TextureTool.fromJson(json);
    case 'ruler':
      return RulerTool.fromJson(json);
    case 'grid':
      return GridTool.fromJson(json);
    case 'eyeDropper':
      return EyeDropperTool.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Tool', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Tool {
  String get name => throw _privateConstructorUsedError;
  String get displayIcon => throw _privateConstructorUsedError;

  /// Serializes this Tool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToolCopyWith<Tool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolCopyWith<$Res> {
  factory $ToolCopyWith(Tool value, $Res Function(Tool) then) =
      _$ToolCopyWithImpl<$Res, Tool>;
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class _$ToolCopyWithImpl<$Res, $Val extends Tool>
    implements $ToolCopyWith<$Res> {
  _$ToolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$SelectToolImplCopyWith(
          _$SelectToolImpl value, $Res Function(_$SelectToolImpl) then) =
      __$$SelectToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, SelectMode mode});
}

/// @nodoc
class __$$SelectToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$SelectToolImpl>
    implements _$$SelectToolImplCopyWith<$Res> {
  __$$SelectToolImplCopyWithImpl(
      _$SelectToolImpl _value, $Res Function(_$SelectToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? mode = null,
  }) {
    return _then(_$SelectToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as SelectMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectToolImpl extends SelectTool {
  _$SelectToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.mode = SelectMode.rectangle,
      final String? $type})
      : $type = $type ?? 'select',
        super._();

  factory _$SelectToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final SelectMode mode;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.select(name: $name, displayIcon: $displayIcon, mode: $mode)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectToolImplCopyWith<_$SelectToolImpl> get copyWith =>
      __$$SelectToolImplCopyWithImpl<_$SelectToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectToolImplToJson(
      this,
    );
  }
}

abstract class SelectTool extends Tool {
  factory SelectTool(
      {final String name,
      final String displayIcon,
      final SelectMode mode}) = _$SelectToolImpl;
  SelectTool._() : super._();

  factory SelectTool.fromJson(Map<String, dynamic> json) =
      _$SelectToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  SelectMode get mode;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectToolImplCopyWith<_$SelectToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HandToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$HandToolImplCopyWith(
          _$HandToolImpl value, $Res Function(_$HandToolImpl) then) =
      __$$HandToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$HandToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$HandToolImpl>
    implements _$$HandToolImplCopyWith<$Res> {
  __$$HandToolImplCopyWithImpl(
      _$HandToolImpl _value, $Res Function(_$HandToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$HandToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HandToolImpl extends HandTool {
  _$HandToolImpl({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'hand',
        super._();

  factory _$HandToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$HandToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.hand(name: $name, displayIcon: $displayIcon)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HandToolImplCopyWith<_$HandToolImpl> get copyWith =>
      __$$HandToolImplCopyWithImpl<_$HandToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HandToolImplToJson(
      this,
    );
  }
}

abstract class HandTool extends Tool {
  factory HandTool({final String name, final String displayIcon}) =
      _$HandToolImpl;
  HandTool._() : super._();

  factory HandTool.fromJson(Map<String, dynamic> json) =
      _$HandToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HandToolImplCopyWith<_$HandToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImportToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$ImportToolImplCopyWith(
          _$ImportToolImpl value, $Res Function(_$ImportToolImpl) then) =
      __$$ImportToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      List<PadElement> elements,
      List<Area> areas});
}

/// @nodoc
class __$$ImportToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$ImportToolImpl>
    implements _$$ImportToolImplCopyWith<$Res> {
  __$$ImportToolImplCopyWithImpl(
      _$ImportToolImpl _value, $Res Function(_$ImportToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? elements = null,
    Object? areas = null,
  }) {
    return _then(_$ImportToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      elements: null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImportToolImpl extends ImportTool {
  _$ImportToolImpl(
      {this.name = '',
      this.displayIcon = '',
      required final List<PadElement> elements,
      required final List<Area> areas,
      final String? $type})
      : _elements = elements,
        _areas = areas,
        $type = $type ?? 'import',
        super._();

  factory _$ImportToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImportToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  final List<PadElement> _elements;
  @override
  List<PadElement> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  final List<Area> _areas;
  @override
  List<Area> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.import(name: $name, displayIcon: $displayIcon, elements: $elements, areas: $areas)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportToolImplCopyWith<_$ImportToolImpl> get copyWith =>
      __$$ImportToolImplCopyWithImpl<_$ImportToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportToolImplToJson(
      this,
    );
  }
}

abstract class ImportTool extends Tool {
  factory ImportTool(
      {final String name,
      final String displayIcon,
      required final List<PadElement> elements,
      required final List<Area> areas}) = _$ImportToolImpl;
  ImportTool._() : super._();

  factory ImportTool.fromJson(Map<String, dynamic> json) =
      _$ImportToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  List<PadElement> get elements;
  List<Area> get areas;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImportToolImplCopyWith<_$ImportToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndoToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$UndoToolImplCopyWith(
          _$UndoToolImpl value, $Res Function(_$UndoToolImpl) then) =
      __$$UndoToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$UndoToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$UndoToolImpl>
    implements _$$UndoToolImplCopyWith<$Res> {
  __$$UndoToolImplCopyWithImpl(
      _$UndoToolImpl _value, $Res Function(_$UndoToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$UndoToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UndoToolImpl extends UndoTool {
  _$UndoToolImpl({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'undo',
        super._();

  factory _$UndoToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$UndoToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.undo(name: $name, displayIcon: $displayIcon)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UndoToolImplCopyWith<_$UndoToolImpl> get copyWith =>
      __$$UndoToolImplCopyWithImpl<_$UndoToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UndoToolImplToJson(
      this,
    );
  }
}

abstract class UndoTool extends Tool {
  factory UndoTool({final String name, final String displayIcon}) =
      _$UndoToolImpl;
  UndoTool._() : super._();

  factory UndoTool.fromJson(Map<String, dynamic> json) =
      _$UndoToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UndoToolImplCopyWith<_$UndoToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RedoToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$RedoToolImplCopyWith(
          _$RedoToolImpl value, $Res Function(_$RedoToolImpl) then) =
      __$$RedoToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$RedoToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$RedoToolImpl>
    implements _$$RedoToolImplCopyWith<$Res> {
  __$$RedoToolImplCopyWithImpl(
      _$RedoToolImpl _value, $Res Function(_$RedoToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$RedoToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RedoToolImpl extends RedoTool {
  _$RedoToolImpl({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'redo',
        super._();

  factory _$RedoToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$RedoToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.redo(name: $name, displayIcon: $displayIcon)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RedoToolImplCopyWith<_$RedoToolImpl> get copyWith =>
      __$$RedoToolImplCopyWithImpl<_$RedoToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RedoToolImplToJson(
      this,
    );
  }
}

abstract class RedoTool extends Tool {
  factory RedoTool({final String name, final String displayIcon}) =
      _$RedoToolImpl;
  RedoTool._() : super._();

  factory RedoTool.fromJson(Map<String, dynamic> json) =
      _$RedoToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RedoToolImplCopyWith<_$RedoToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LabelToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$LabelToolImplCopyWith(
          _$LabelToolImpl value, $Res Function(_$LabelToolImpl) then) =
      __$$LabelToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      LabelMode mode,
      bool zoomDependent,
      @ColorJsonConverter() SRGBColor foreground,
      PackAssetLocation styleSheet,
      double scale});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
}

/// @nodoc
class __$$LabelToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$LabelToolImpl>
    implements _$$LabelToolImplCopyWith<$Res> {
  __$$LabelToolImplCopyWithImpl(
      _$LabelToolImpl _value, $Res Function(_$LabelToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? mode = null,
    Object? zoomDependent = null,
    Object? foreground = null,
    Object? styleSheet = null,
    Object? scale = null,
  }) {
    return _then(_$LabelToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LabelMode,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      foreground: null == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
      styleSheet: null == styleSheet
          ? _value.styleSheet
          : styleSheet // ignore: cast_nullable_to_non_nullable
              as PackAssetLocation,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<$Res> get styleSheet {
    return $PackAssetLocationCopyWith<$Res>(_value.styleSheet, (value) {
      return _then(_value.copyWith(styleSheet: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$LabelToolImpl extends LabelTool {
  _$LabelToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.mode = LabelMode.text,
      this.zoomDependent = false,
      @ColorJsonConverter() this.foreground = SRGBColor.black,
      this.styleSheet = const PackAssetLocation(),
      this.scale = 2.0,
      final String? $type})
      : $type = $type ?? 'label',
        super._();

  factory _$LabelToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$LabelToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final LabelMode mode;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor foreground;
  @override
  @JsonKey()
  final PackAssetLocation styleSheet;
  @override
  @JsonKey()
  final double scale;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.label(name: $name, displayIcon: $displayIcon, mode: $mode, zoomDependent: $zoomDependent, foreground: $foreground, styleSheet: $styleSheet, scale: $scale)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabelToolImplCopyWith<_$LabelToolImpl> get copyWith =>
      __$$LabelToolImplCopyWithImpl<_$LabelToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelToolImplToJson(
      this,
    );
  }
}

abstract class LabelTool extends Tool {
  factory LabelTool(
      {final String name,
      final String displayIcon,
      final LabelMode mode,
      final bool zoomDependent,
      @ColorJsonConverter() final SRGBColor foreground,
      final PackAssetLocation styleSheet,
      final double scale}) = _$LabelToolImpl;
  LabelTool._() : super._();

  factory LabelTool.fromJson(Map<String, dynamic> json) =
      _$LabelToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  LabelMode get mode;
  bool get zoomDependent;
  @ColorJsonConverter()
  SRGBColor get foreground;
  PackAssetLocation get styleSheet;
  double get scale;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabelToolImplCopyWith<_$LabelToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PenToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$PenToolImplCopyWith(
          _$PenToolImpl value, $Res Function(_$PenToolImpl) then) =
      __$$PenToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      bool zoomDependent,
      double shapeDetectionTime,
      bool shapeDetectionEnabled,
      PenProperty property});
}

/// @nodoc
class __$$PenToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$PenToolImpl>
    implements _$$PenToolImplCopyWith<$Res> {
  __$$PenToolImplCopyWithImpl(
      _$PenToolImpl _value, $Res Function(_$PenToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? zoomDependent = null,
    Object? shapeDetectionTime = null,
    Object? shapeDetectionEnabled = null,
    Object? property = freezed,
  }) {
    return _then(_$PenToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      shapeDetectionTime: null == shapeDetectionTime
          ? _value.shapeDetectionTime
          : shapeDetectionTime // ignore: cast_nullable_to_non_nullable
              as double,
      shapeDetectionEnabled: null == shapeDetectionEnabled
          ? _value.shapeDetectionEnabled
          : shapeDetectionEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as PenProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenToolImpl extends PenTool {
  _$PenToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.zoomDependent = false,
      this.shapeDetectionTime = 0.5,
      this.shapeDetectionEnabled = false,
      this.property = const PenProperty(),
      final String? $type})
      : $type = $type ?? 'pen',
        super._();

  factory _$PenToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$PenToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final double shapeDetectionTime;
  @override
  @JsonKey()
  final bool shapeDetectionEnabled;
  @override
  @JsonKey()
  final PenProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.pen(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, shapeDetectionTime: $shapeDetectionTime, shapeDetectionEnabled: $shapeDetectionEnabled, property: $property)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PenToolImplCopyWith<_$PenToolImpl> get copyWith =>
      __$$PenToolImplCopyWithImpl<_$PenToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PenToolImplToJson(
      this,
    );
  }
}

abstract class PenTool extends Tool {
  factory PenTool(
      {final String name,
      final String displayIcon,
      final bool zoomDependent,
      final double shapeDetectionTime,
      final bool shapeDetectionEnabled,
      final PenProperty property}) = _$PenToolImpl;
  PenTool._() : super._();

  factory PenTool.fromJson(Map<String, dynamic> json) = _$PenToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  bool get zoomDependent;
  double get shapeDetectionTime;
  bool get shapeDetectionEnabled;
  PenProperty get property;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PenToolImplCopyWith<_$PenToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EraserToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$EraserToolImplCopyWith(
          _$EraserToolImpl value, $Res Function(_$EraserToolImpl) then) =
      __$$EraserToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      double strokeWidth,
      bool eraseElements});
}

/// @nodoc
class __$$EraserToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$EraserToolImpl>
    implements _$$EraserToolImplCopyWith<$Res> {
  __$$EraserToolImplCopyWithImpl(
      _$EraserToolImpl _value, $Res Function(_$EraserToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? strokeWidth = null,
    Object? eraseElements = null,
  }) {
    return _then(_$EraserToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      eraseElements: null == eraseElements
          ? _value.eraseElements
          : eraseElements // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EraserToolImpl extends EraserTool {
  _$EraserToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.strokeWidth = 5,
      this.eraseElements = false,
      final String? $type})
      : $type = $type ?? 'eraser',
        super._();

  factory _$EraserToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$EraserToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final bool eraseElements;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.eraser(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth, eraseElements: $eraseElements)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EraserToolImplCopyWith<_$EraserToolImpl> get copyWith =>
      __$$EraserToolImplCopyWithImpl<_$EraserToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EraserToolImplToJson(
      this,
    );
  }
}

abstract class EraserTool extends Tool {
  factory EraserTool(
      {final String name,
      final String displayIcon,
      final double strokeWidth,
      final bool eraseElements}) = _$EraserToolImpl;
  EraserTool._() : super._();

  factory EraserTool.fromJson(Map<String, dynamic> json) =
      _$EraserToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get strokeWidth;
  bool get eraseElements;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EraserToolImplCopyWith<_$EraserToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PathEraserToolImplCopyWith<$Res>
    implements $ToolCopyWith<$Res> {
  factory _$$PathEraserToolImplCopyWith(_$PathEraserToolImpl value,
          $Res Function(_$PathEraserToolImpl) then) =
      __$$PathEraserToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      double strokeWidth,
      bool eraseElements});
}

/// @nodoc
class __$$PathEraserToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$PathEraserToolImpl>
    implements _$$PathEraserToolImplCopyWith<$Res> {
  __$$PathEraserToolImplCopyWithImpl(
      _$PathEraserToolImpl _value, $Res Function(_$PathEraserToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? strokeWidth = null,
    Object? eraseElements = null,
  }) {
    return _then(_$PathEraserToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      eraseElements: null == eraseElements
          ? _value.eraseElements
          : eraseElements // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PathEraserToolImpl extends PathEraserTool {
  _$PathEraserToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.strokeWidth = 5,
      this.eraseElements = false,
      final String? $type})
      : $type = $type ?? 'pathEraser',
        super._();

  factory _$PathEraserToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$PathEraserToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final bool eraseElements;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.pathEraser(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth, eraseElements: $eraseElements)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PathEraserToolImplCopyWith<_$PathEraserToolImpl> get copyWith =>
      __$$PathEraserToolImplCopyWithImpl<_$PathEraserToolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PathEraserToolImplToJson(
      this,
    );
  }
}

abstract class PathEraserTool extends Tool {
  factory PathEraserTool(
      {final String name,
      final String displayIcon,
      final double strokeWidth,
      final bool eraseElements}) = _$PathEraserToolImpl;
  PathEraserTool._() : super._();

  factory PathEraserTool.fromJson(Map<String, dynamic> json) =
      _$PathEraserToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get strokeWidth;
  bool get eraseElements;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PathEraserToolImplCopyWith<_$PathEraserToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CollectionToolImplCopyWith<$Res>
    implements $ToolCopyWith<$Res> {
  factory _$$CollectionToolImplCopyWith(_$CollectionToolImpl value,
          $Res Function(_$CollectionToolImpl) then) =
      __$$CollectionToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, double strokeWidth});
}

/// @nodoc
class __$$CollectionToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$CollectionToolImpl>
    implements _$$CollectionToolImplCopyWith<$Res> {
  __$$CollectionToolImplCopyWithImpl(
      _$CollectionToolImpl _value, $Res Function(_$CollectionToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$CollectionToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionToolImpl extends CollectionTool {
  _$CollectionToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.strokeWidth = 5,
      final String? $type})
      : $type = $type ?? 'collection',
        super._();

  factory _$CollectionToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.collection(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionToolImplCopyWith<_$CollectionToolImpl> get copyWith =>
      __$$CollectionToolImplCopyWithImpl<_$CollectionToolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionToolImplToJson(
      this,
    );
  }
}

abstract class CollectionTool extends Tool {
  factory CollectionTool(
      {final String name,
      final String displayIcon,
      final double strokeWidth}) = _$CollectionToolImpl;
  CollectionTool._() : super._();

  factory CollectionTool.fromJson(Map<String, dynamic> json) =
      _$CollectionToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get strokeWidth;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionToolImplCopyWith<_$CollectionToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreaToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$AreaToolImplCopyWith(
          _$AreaToolImpl value, $Res Function(_$AreaToolImpl) then) =
      __$$AreaToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      bool askForName});
}

/// @nodoc
class __$$AreaToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$AreaToolImpl>
    implements _$$AreaToolImplCopyWith<$Res> {
  __$$AreaToolImplCopyWithImpl(
      _$AreaToolImpl _value, $Res Function(_$AreaToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? askForName = null,
  }) {
    return _then(_$AreaToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      constrainedWidth: null == constrainedWidth
          ? _value.constrainedWidth
          : constrainedWidth // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedHeight: null == constrainedHeight
          ? _value.constrainedHeight
          : constrainedHeight // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedAspectRatio: null == constrainedAspectRatio
          ? _value.constrainedAspectRatio
          : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      askForName: null == askForName
          ? _value.askForName
          : askForName // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaToolImpl extends AreaTool {
  _$AreaToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.askForName = false,
      final String? $type})
      : $type = $type ?? 'area',
        super._();

  factory _$AreaToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double constrainedWidth;
  @override
  @JsonKey()
  final double constrainedHeight;
  @override
  @JsonKey()
  final double constrainedAspectRatio;
  @override
  @JsonKey()
  final bool askForName;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.area(name: $name, displayIcon: $displayIcon, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, askForName: $askForName)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaToolImplCopyWith<_$AreaToolImpl> get copyWith =>
      __$$AreaToolImplCopyWithImpl<_$AreaToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaToolImplToJson(
      this,
    );
  }
}

abstract class AreaTool extends Tool {
  factory AreaTool(
      {final String name,
      final String displayIcon,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final bool askForName}) = _$AreaToolImpl;
  AreaTool._() : super._();

  factory AreaTool.fromJson(Map<String, dynamic> json) =
      _$AreaToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  bool get askForName;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AreaToolImplCopyWith<_$AreaToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LaserToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$LaserToolImplCopyWith(
          _$LaserToolImpl value, $Res Function(_$LaserToolImpl) then) =
      __$$LaserToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      double duration,
      double hideDuration,
      double strokeWidth,
      double thinning,
      @ColorJsonConverter() SRGBColor color,
      LaserAnimation animation});
}

/// @nodoc
class __$$LaserToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$LaserToolImpl>
    implements _$$LaserToolImplCopyWith<$Res> {
  __$$LaserToolImplCopyWithImpl(
      _$LaserToolImpl _value, $Res Function(_$LaserToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? duration = null,
    Object? hideDuration = null,
    Object? strokeWidth = null,
    Object? thinning = null,
    Object? color = null,
    Object? animation = null,
  }) {
    return _then(_$LaserToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
      hideDuration: null == hideDuration
          ? _value.hideDuration
          : hideDuration // ignore: cast_nullable_to_non_nullable
              as double,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      thinning: null == thinning
          ? _value.thinning
          : thinning // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
      animation: null == animation
          ? _value.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as LaserAnimation,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LaserToolImpl extends LaserTool {
  _$LaserToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.duration = 5,
      this.hideDuration = 0.5,
      this.strokeWidth = 5,
      this.thinning = 0.4,
      @ColorJsonConverter() this.color = BasicColors.red,
      this.animation = LaserAnimation.fade,
      final String? $type})
      : $type = $type ?? 'laser',
        super._();

  factory _$LaserToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaserToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double duration;
  @override
  @JsonKey()
  final double hideDuration;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final double thinning;
  @override
  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor color;
  @override
  @JsonKey()
  final LaserAnimation animation;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.laser(name: $name, displayIcon: $displayIcon, duration: $duration, hideDuration: $hideDuration, strokeWidth: $strokeWidth, thinning: $thinning, color: $color, animation: $animation)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LaserToolImplCopyWith<_$LaserToolImpl> get copyWith =>
      __$$LaserToolImplCopyWithImpl<_$LaserToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaserToolImplToJson(
      this,
    );
  }
}

abstract class LaserTool extends Tool {
  factory LaserTool(
      {final String name,
      final String displayIcon,
      final double duration,
      final double hideDuration,
      final double strokeWidth,
      final double thinning,
      @ColorJsonConverter() final SRGBColor color,
      final LaserAnimation animation}) = _$LaserToolImpl;
  LaserTool._() : super._();

  factory LaserTool.fromJson(Map<String, dynamic> json) =
      _$LaserToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get duration;
  double get hideDuration;
  double get strokeWidth;
  double get thinning;
  @ColorJsonConverter()
  SRGBColor get color;
  LaserAnimation get animation;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LaserToolImplCopyWith<_$LaserToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapeToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$ShapeToolImplCopyWith(
          _$ShapeToolImpl value, $Res Function(_$ShapeToolImpl) then) =
      __$$ShapeToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      bool zoomDependent,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      ShapeProperty property});
}

/// @nodoc
class __$$ShapeToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$ShapeToolImpl>
    implements _$$ShapeToolImplCopyWith<$Res> {
  __$$ShapeToolImplCopyWithImpl(
      _$ShapeToolImpl _value, $Res Function(_$ShapeToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? zoomDependent = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? property = freezed,
  }) {
    return _then(_$ShapeToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      constrainedWidth: null == constrainedWidth
          ? _value.constrainedWidth
          : constrainedWidth // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedHeight: null == constrainedHeight
          ? _value.constrainedHeight
          : constrainedHeight // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedAspectRatio: null == constrainedAspectRatio
          ? _value.constrainedAspectRatio
          : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as ShapeProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShapeToolImpl extends ShapeTool {
  _$ShapeToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.zoomDependent = false,
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.property = const ShapeProperty(shape: RectangleShape()),
      final String? $type})
      : $type = $type ?? 'shape',
        super._();

  factory _$ShapeToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShapeToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final double constrainedWidth;
  @override
  @JsonKey()
  final double constrainedHeight;
  @override
  @JsonKey()
  final double constrainedAspectRatio;
  @override
  @JsonKey()
  final ShapeProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.shape(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, property: $property)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShapeToolImplCopyWith<_$ShapeToolImpl> get copyWith =>
      __$$ShapeToolImplCopyWithImpl<_$ShapeToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShapeToolImplToJson(
      this,
    );
  }
}

abstract class ShapeTool extends Tool {
  factory ShapeTool(
      {final String name,
      final String displayIcon,
      final bool zoomDependent,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final ShapeProperty property}) = _$ShapeToolImpl;
  ShapeTool._() : super._();

  factory ShapeTool.fromJson(Map<String, dynamic> json) =
      _$ShapeToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  bool get zoomDependent;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  ShapeProperty get property;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShapeToolImplCopyWith<_$ShapeToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StampToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$StampToolImplCopyWith(
          _$StampToolImpl value, $Res Function(_$StampToolImpl) then) =
      __$$StampToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, PackAssetLocation component});

  $PackAssetLocationCopyWith<$Res> get component;
}

/// @nodoc
class __$$StampToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$StampToolImpl>
    implements _$$StampToolImplCopyWith<$Res> {
  __$$StampToolImplCopyWithImpl(
      _$StampToolImpl _value, $Res Function(_$StampToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? component = null,
  }) {
    return _then(_$StampToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      component: null == component
          ? _value.component
          : component // ignore: cast_nullable_to_non_nullable
              as PackAssetLocation,
    ));
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<$Res> get component {
    return $PackAssetLocationCopyWith<$Res>(_value.component, (value) {
      return _then(_value.copyWith(component: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$StampToolImpl extends StampTool {
  _$StampToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.component = const PackAssetLocation(),
      final String? $type})
      : $type = $type ?? 'stamp',
        super._();

  factory _$StampToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$StampToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final PackAssetLocation component;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.stamp(name: $name, displayIcon: $displayIcon, component: $component)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StampToolImplCopyWith<_$StampToolImpl> get copyWith =>
      __$$StampToolImplCopyWithImpl<_$StampToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StampToolImplToJson(
      this,
    );
  }
}

abstract class StampTool extends Tool {
  factory StampTool(
      {final String name,
      final String displayIcon,
      final PackAssetLocation component}) = _$StampToolImpl;
  StampTool._() : super._();

  factory StampTool.fromJson(Map<String, dynamic> json) =
      _$StampToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  PackAssetLocation get component;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StampToolImplCopyWith<_$StampToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresentationToolImplCopyWith<$Res>
    implements $ToolCopyWith<$Res> {
  factory _$$PresentationToolImplCopyWith(_$PresentationToolImpl value,
          $Res Function(_$PresentationToolImpl) then) =
      __$$PresentationToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$PresentationToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$PresentationToolImpl>
    implements _$$PresentationToolImplCopyWith<$Res> {
  __$$PresentationToolImplCopyWithImpl(_$PresentationToolImpl _value,
      $Res Function(_$PresentationToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$PresentationToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentationToolImpl extends PresentationTool {
  _$PresentationToolImpl(
      {this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'presentation',
        super._();

  factory _$PresentationToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresentationToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.presentation(name: $name, displayIcon: $displayIcon)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentationToolImplCopyWith<_$PresentationToolImpl> get copyWith =>
      __$$PresentationToolImplCopyWithImpl<_$PresentationToolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentationToolImplToJson(
      this,
    );
  }
}

abstract class PresentationTool extends Tool {
  factory PresentationTool({final String name, final String displayIcon}) =
      _$PresentationToolImpl;
  PresentationTool._() : super._();

  factory PresentationTool.fromJson(Map<String, dynamic> json) =
      _$PresentationToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresentationToolImplCopyWith<_$PresentationToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpacerToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$SpacerToolImplCopyWith(
          _$SpacerToolImpl value, $Res Function(_$SpacerToolImpl) then) =
      __$$SpacerToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, Axis2D axis});
}

/// @nodoc
class __$$SpacerToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$SpacerToolImpl>
    implements _$$SpacerToolImplCopyWith<$Res> {
  __$$SpacerToolImplCopyWithImpl(
      _$SpacerToolImpl _value, $Res Function(_$SpacerToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? axis = null,
  }) {
    return _then(_$SpacerToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      axis: null == axis
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis2D,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpacerToolImpl extends SpacerTool {
  _$SpacerToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.axis = Axis2D.horizontal,
      final String? $type})
      : $type = $type ?? 'spacer',
        super._();

  factory _$SpacerToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpacerToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final Axis2D axis;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.spacer(name: $name, displayIcon: $displayIcon, axis: $axis)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpacerToolImplCopyWith<_$SpacerToolImpl> get copyWith =>
      __$$SpacerToolImplCopyWithImpl<_$SpacerToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpacerToolImplToJson(
      this,
    );
  }
}

abstract class SpacerTool extends Tool {
  factory SpacerTool(
      {final String name,
      final String displayIcon,
      final Axis2D axis}) = _$SpacerToolImpl;
  SpacerTool._() : super._();

  factory SpacerTool.fromJson(Map<String, dynamic> json) =
      _$SpacerToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  Axis2D get axis;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpacerToolImplCopyWith<_$SpacerToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FullScreenToolImplCopyWith<$Res>
    implements $ToolCopyWith<$Res> {
  factory _$$FullScreenToolImplCopyWith(_$FullScreenToolImpl value,
          $Res Function(_$FullScreenToolImpl) then) =
      __$$FullScreenToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$FullScreenToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$FullScreenToolImpl>
    implements _$$FullScreenToolImplCopyWith<$Res> {
  __$$FullScreenToolImplCopyWithImpl(
      _$FullScreenToolImpl _value, $Res Function(_$FullScreenToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$FullScreenToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FullScreenToolImpl extends FullScreenTool {
  _$FullScreenToolImpl(
      {this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'fullSceen',
        super._();

  factory _$FullScreenToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$FullScreenToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.fullScreen(name: $name, displayIcon: $displayIcon)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullScreenToolImplCopyWith<_$FullScreenToolImpl> get copyWith =>
      __$$FullScreenToolImplCopyWithImpl<_$FullScreenToolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FullScreenToolImplToJson(
      this,
    );
  }
}

abstract class FullScreenTool extends Tool {
  factory FullScreenTool({final String name, final String displayIcon}) =
      _$FullScreenToolImpl;
  FullScreenTool._() : super._();

  factory FullScreenTool.fromJson(Map<String, dynamic> json) =
      _$FullScreenToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullScreenToolImplCopyWith<_$FullScreenToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssetToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$AssetToolImplCopyWith(
          _$AssetToolImpl value, $Res Function(_$AssetToolImpl) then) =
      __$$AssetToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String displayIcon, ImportType importType, bool advanced});
}

/// @nodoc
class __$$AssetToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$AssetToolImpl>
    implements _$$AssetToolImplCopyWith<$Res> {
  __$$AssetToolImplCopyWithImpl(
      _$AssetToolImpl _value, $Res Function(_$AssetToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? importType = null,
    Object? advanced = null,
  }) {
    return _then(_$AssetToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      importType: null == importType
          ? _value.importType
          : importType // ignore: cast_nullable_to_non_nullable
              as ImportType,
      advanced: null == advanced
          ? _value.advanced
          : advanced // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetToolImpl extends AssetTool {
  _$AssetToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.importType = ImportType.document,
      this.advanced = true,
      final String? $type})
      : $type = $type ?? 'asset',
        super._();

  factory _$AssetToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final ImportType importType;
  @override
  @JsonKey()
  final bool advanced;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.asset(name: $name, displayIcon: $displayIcon, importType: $importType, advanced: $advanced)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetToolImplCopyWith<_$AssetToolImpl> get copyWith =>
      __$$AssetToolImplCopyWithImpl<_$AssetToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetToolImplToJson(
      this,
    );
  }
}

abstract class AssetTool extends Tool {
  factory AssetTool(
      {final String name,
      final String displayIcon,
      final ImportType importType,
      final bool advanced}) = _$AssetToolImpl;
  AssetTool._() : super._();

  factory AssetTool.fromJson(Map<String, dynamic> json) =
      _$AssetToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  ImportType get importType;
  bool get advanced;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetToolImplCopyWith<_$AssetToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExportToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$ExportToolImplCopyWith(
          _$ExportToolImpl value, $Res Function(_$ExportToolImpl) then) =
      __$$ExportToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, ExportOptions options});

  $ExportOptionsCopyWith<$Res> get options;
}

/// @nodoc
class __$$ExportToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$ExportToolImpl>
    implements _$$ExportToolImplCopyWith<$Res> {
  __$$ExportToolImplCopyWithImpl(
      _$ExportToolImpl _value, $Res Function(_$ExportToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? options = null,
  }) {
    return _then(_$ExportToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as ExportOptions,
    ));
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExportOptionsCopyWith<$Res> get options {
    return $ExportOptionsCopyWith<$Res>(_value.options, (value) {
      return _then(_value.copyWith(options: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportToolImpl extends ExportTool {
  _$ExportToolImpl(
      {this.name = '',
      this.displayIcon = '',
      required this.options,
      final String? $type})
      : $type = $type ?? 'export',
        super._();

  factory _$ExportToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  final ExportOptions options;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.export(name: $name, displayIcon: $displayIcon, options: $options)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportToolImplCopyWith<_$ExportToolImpl> get copyWith =>
      __$$ExportToolImplCopyWithImpl<_$ExportToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportToolImplToJson(
      this,
    );
  }
}

abstract class ExportTool extends Tool {
  factory ExportTool(
      {final String name,
      final String displayIcon,
      required final ExportOptions options}) = _$ExportToolImpl;
  ExportTool._() : super._();

  factory ExportTool.fromJson(Map<String, dynamic> json) =
      _$ExportToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  ExportOptions get options;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExportToolImplCopyWith<_$ExportToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextureToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$TextureToolImplCopyWith(
          _$TextureToolImpl value, $Res Function(_$TextureToolImpl) then) =
      __$$TextureToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      bool zoomDependent,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      SurfaceTexture texture});

  $SurfaceTextureCopyWith<$Res> get texture;
}

/// @nodoc
class __$$TextureToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$TextureToolImpl>
    implements _$$TextureToolImplCopyWith<$Res> {
  __$$TextureToolImplCopyWithImpl(
      _$TextureToolImpl _value, $Res Function(_$TextureToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? zoomDependent = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? texture = null,
  }) {
    return _then(_$TextureToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      constrainedWidth: null == constrainedWidth
          ? _value.constrainedWidth
          : constrainedWidth // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedHeight: null == constrainedHeight
          ? _value.constrainedHeight
          : constrainedHeight // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedAspectRatio: null == constrainedAspectRatio
          ? _value.constrainedAspectRatio
          : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      texture: null == texture
          ? _value.texture
          : texture // ignore: cast_nullable_to_non_nullable
              as SurfaceTexture,
    ));
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SurfaceTextureCopyWith<$Res> get texture {
    return $SurfaceTextureCopyWith<$Res>(_value.texture, (value) {
      return _then(_value.copyWith(texture: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TextureToolImpl extends TextureTool {
  _$TextureToolImpl(
      {this.name = '',
      this.displayIcon = '',
      this.zoomDependent = false,
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.texture = const SurfaceTexture.pattern(),
      final String? $type})
      : $type = $type ?? 'texture',
        super._();

  factory _$TextureToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextureToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final double constrainedWidth;
  @override
  @JsonKey()
  final double constrainedHeight;
  @override
  @JsonKey()
  final double constrainedAspectRatio;
  @override
  @JsonKey()
  final SurfaceTexture texture;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.texture(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, texture: $texture)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TextureToolImplCopyWith<_$TextureToolImpl> get copyWith =>
      __$$TextureToolImplCopyWithImpl<_$TextureToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextureToolImplToJson(
      this,
    );
  }
}

abstract class TextureTool extends Tool {
  factory TextureTool(
      {final String name,
      final String displayIcon,
      final bool zoomDependent,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final SurfaceTexture texture}) = _$TextureToolImpl;
  TextureTool._() : super._();

  factory TextureTool.fromJson(Map<String, dynamic> json) =
      _$TextureToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  bool get zoomDependent;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  SurfaceTexture get texture;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TextureToolImplCopyWith<_$TextureToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RulerToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$RulerToolImplCopyWith(
          _$RulerToolImpl value, $Res Function(_$RulerToolImpl) then) =
      __$$RulerToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      @ColorJsonConverter() SRGBColor? color,
      int size});
}

/// @nodoc
class __$$RulerToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$RulerToolImpl>
    implements _$$RulerToolImplCopyWith<$Res> {
  __$$RulerToolImplCopyWithImpl(
      _$RulerToolImpl _value, $Res Function(_$RulerToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? color = freezed,
    Object? size = null,
  }) {
    return _then(_$RulerToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as SRGBColor?,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RulerToolImpl extends RulerTool {
  _$RulerToolImpl(
      {this.name = '',
      this.displayIcon = '',
      @ColorJsonConverter() this.color,
      this.size = 100,
      final String? $type})
      : $type = $type ?? 'ruler',
        super._();

  factory _$RulerToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$RulerToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @ColorJsonConverter()
  final SRGBColor? color;
  @override
  @JsonKey()
  final int size;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.ruler(name: $name, displayIcon: $displayIcon, color: $color, size: $size)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RulerToolImplCopyWith<_$RulerToolImpl> get copyWith =>
      __$$RulerToolImplCopyWithImpl<_$RulerToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RulerToolImplToJson(
      this,
    );
  }
}

abstract class RulerTool extends Tool {
  factory RulerTool(
      {final String name,
      final String displayIcon,
      @ColorJsonConverter() final SRGBColor? color,
      final int size}) = _$RulerToolImpl;
  RulerTool._() : super._();

  factory RulerTool.fromJson(Map<String, dynamic> json) =
      _$RulerToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @ColorJsonConverter()
  SRGBColor? get color;
  int get size;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RulerToolImplCopyWith<_$RulerToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GridToolImplCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$GridToolImplCopyWith(
          _$GridToolImpl value, $Res Function(_$GridToolImpl) then) =
      __$$GridToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      @ColorJsonConverter() SRGBColor color,
      double xSize,
      double ySize,
      double xOffset,
      double yOffset,
      bool positionDependent,
      bool zoomDependent,
      double stroke});
}

/// @nodoc
class __$$GridToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$GridToolImpl>
    implements _$$GridToolImplCopyWith<$Res> {
  __$$GridToolImplCopyWithImpl(
      _$GridToolImpl _value, $Res Function(_$GridToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? color = null,
    Object? xSize = null,
    Object? ySize = null,
    Object? xOffset = null,
    Object? yOffset = null,
    Object? positionDependent = null,
    Object? zoomDependent = null,
    Object? stroke = null,
  }) {
    return _then(_$GridToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
      xSize: null == xSize
          ? _value.xSize
          : xSize // ignore: cast_nullable_to_non_nullable
              as double,
      ySize: null == ySize
          ? _value.ySize
          : ySize // ignore: cast_nullable_to_non_nullable
              as double,
      xOffset: null == xOffset
          ? _value.xOffset
          : xOffset // ignore: cast_nullable_to_non_nullable
              as double,
      yOffset: null == yOffset
          ? _value.yOffset
          : yOffset // ignore: cast_nullable_to_non_nullable
              as double,
      positionDependent: null == positionDependent
          ? _value.positionDependent
          : positionDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      stroke: null == stroke
          ? _value.stroke
          : stroke // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GridToolImpl extends GridTool {
  _$GridToolImpl(
      {this.name = '',
      this.displayIcon = '',
      @ColorJsonConverter() this.color = SRGBColor.black,
      this.xSize = 20,
      this.ySize = 20,
      this.xOffset = 0,
      this.yOffset = 0,
      this.positionDependent = false,
      this.zoomDependent = false,
      this.stroke = 1,
      final String? $type})
      : $type = $type ?? 'grid',
        super._();

  factory _$GridToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$GridToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor color;
  @override
  @JsonKey()
  final double xSize;
  @override
  @JsonKey()
  final double ySize;
  @override
  @JsonKey()
  final double xOffset;
  @override
  @JsonKey()
  final double yOffset;
  @override
  @JsonKey()
  final bool positionDependent;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final double stroke;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.grid(name: $name, displayIcon: $displayIcon, color: $color, xSize: $xSize, ySize: $ySize, xOffset: $xOffset, yOffset: $yOffset, positionDependent: $positionDependent, zoomDependent: $zoomDependent, stroke: $stroke)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GridToolImplCopyWith<_$GridToolImpl> get copyWith =>
      __$$GridToolImplCopyWithImpl<_$GridToolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GridToolImplToJson(
      this,
    );
  }
}

abstract class GridTool extends Tool {
  factory GridTool(
      {final String name,
      final String displayIcon,
      @ColorJsonConverter() final SRGBColor color,
      final double xSize,
      final double ySize,
      final double xOffset,
      final double yOffset,
      final bool positionDependent,
      final bool zoomDependent,
      final double stroke}) = _$GridToolImpl;
  GridTool._() : super._();

  factory GridTool.fromJson(Map<String, dynamic> json) =
      _$GridToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @ColorJsonConverter()
  SRGBColor get color;
  double get xSize;
  double get ySize;
  double get xOffset;
  double get yOffset;
  bool get positionDependent;
  bool get zoomDependent;
  double get stroke;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GridToolImplCopyWith<_$GridToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EyeDropperToolImplCopyWith<$Res>
    implements $ToolCopyWith<$Res> {
  factory _$$EyeDropperToolImplCopyWith(_$EyeDropperToolImpl value,
          $Res Function(_$EyeDropperToolImpl) then) =
      __$$EyeDropperToolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$EyeDropperToolImplCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$EyeDropperToolImpl>
    implements _$$EyeDropperToolImplCopyWith<$Res> {
  __$$EyeDropperToolImplCopyWithImpl(
      _$EyeDropperToolImpl _value, $Res Function(_$EyeDropperToolImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$EyeDropperToolImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EyeDropperToolImpl extends EyeDropperTool {
  _$EyeDropperToolImpl(
      {this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'eyeDropper',
        super._();

  factory _$EyeDropperToolImpl.fromJson(Map<String, dynamic> json) =>
      _$$EyeDropperToolImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.eyeDropper(name: $name, displayIcon: $displayIcon)';
  }

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EyeDropperToolImplCopyWith<_$EyeDropperToolImpl> get copyWith =>
      __$$EyeDropperToolImplCopyWithImpl<_$EyeDropperToolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EyeDropperToolImplToJson(
      this,
    );
  }
}

abstract class EyeDropperTool extends Tool {
  factory EyeDropperTool({final String name, final String displayIcon}) =
      _$EyeDropperToolImpl;
  EyeDropperTool._() : super._();

  factory EyeDropperTool.fromJson(Map<String, dynamic> json) =
      _$EyeDropperToolImpl.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;

  /// Create a copy of Tool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EyeDropperToolImplCopyWith<_$EyeDropperToolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
