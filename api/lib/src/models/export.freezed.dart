// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExportOptions _$ExportOptionsFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'image':
      return ImageExportOptions.fromJson(json);
    case 'svg':
      return SVGExportOptions.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'ExportOptions',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$ExportOptions {
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  bool get renderBackground => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)
        image,
    required TResult Function(double width, double height, double x, double y,
            bool renderBackground)
        svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)?
        image,
    TResult? Function(double width, double height, double x, double y,
            bool renderBackground)?
        svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)?
        image,
    TResult Function(double width, double height, double x, double y,
            bool renderBackground)?
        svg,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImageExportOptions value) image,
    required TResult Function(SVGExportOptions value) svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ImageExportOptions value)? image,
    TResult? Function(SVGExportOptions value)? svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImageExportOptions value)? image,
    TResult Function(SVGExportOptions value)? svg,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExportOptionsCopyWith<ExportOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportOptionsCopyWith<$Res> {
  factory $ExportOptionsCopyWith(
          ExportOptions value, $Res Function(ExportOptions) then) =
      _$ExportOptionsCopyWithImpl<$Res, ExportOptions>;
  @useResult
  $Res call(
      {double width, double height, double x, double y, bool renderBackground});
}

/// @nodoc
class _$ExportOptionsCopyWithImpl<$Res, $Val extends ExportOptions>
    implements $ExportOptionsCopyWith<$Res> {
  _$ExportOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? x = null,
    Object? y = null,
    Object? renderBackground = null,
  }) {
    return _then(_value.copyWith(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      renderBackground: null == renderBackground
          ? _value.renderBackground
          : renderBackground // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageExportOptionsImplCopyWith<$Res>
    implements $ExportOptionsCopyWith<$Res> {
  factory _$$ImageExportOptionsImplCopyWith(_$ImageExportOptionsImpl value,
          $Res Function(_$ImageExportOptionsImpl) then) =
      __$$ImageExportOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double width,
      double height,
      double x,
      double y,
      double scale,
      double quality,
      bool renderBackground});
}

/// @nodoc
class __$$ImageExportOptionsImplCopyWithImpl<$Res>
    extends _$ExportOptionsCopyWithImpl<$Res, _$ImageExportOptionsImpl>
    implements _$$ImageExportOptionsImplCopyWith<$Res> {
  __$$ImageExportOptionsImplCopyWithImpl(_$ImageExportOptionsImpl _value,
      $Res Function(_$ImageExportOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? x = null,
    Object? y = null,
    Object? scale = null,
    Object? quality = null,
    Object? renderBackground = null,
  }) {
    return _then(_$ImageExportOptionsImpl(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      renderBackground: null == renderBackground
          ? _value.renderBackground
          : renderBackground // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageExportOptionsImpl extends ImageExportOptions {
  const _$ImageExportOptionsImpl(
      {required this.width,
      required this.height,
      this.x = 0,
      this.y = 0,
      this.scale = 0,
      this.quality = 1,
      this.renderBackground = true,
      final String? $type})
      : $type = $type ?? 'image',
        super._();

  factory _$ImageExportOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageExportOptionsImplFromJson(json);

  @override
  final double width;
  @override
  final double height;
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double y;
  @override
  @JsonKey()
  final double scale;
  @override
  @JsonKey()
  final double quality;
  @override
  @JsonKey()
  final bool renderBackground;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ExportOptions.image(width: $width, height: $height, x: $x, y: $y, scale: $scale, quality: $quality, renderBackground: $renderBackground)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageExportOptionsImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.renderBackground, renderBackground) ||
                other.renderBackground == renderBackground));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, width, height, x, y, scale, quality, renderBackground);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageExportOptionsImplCopyWith<_$ImageExportOptionsImpl> get copyWith =>
      __$$ImageExportOptionsImplCopyWithImpl<_$ImageExportOptionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)
        image,
    required TResult Function(double width, double height, double x, double y,
            bool renderBackground)
        svg,
  }) {
    return image(width, height, x, y, scale, quality, renderBackground);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)?
        image,
    TResult? Function(double width, double height, double x, double y,
            bool renderBackground)?
        svg,
  }) {
    return image?.call(width, height, x, y, scale, quality, renderBackground);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)?
        image,
    TResult Function(double width, double height, double x, double y,
            bool renderBackground)?
        svg,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(width, height, x, y, scale, quality, renderBackground);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImageExportOptions value) image,
    required TResult Function(SVGExportOptions value) svg,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ImageExportOptions value)? image,
    TResult? Function(SVGExportOptions value)? svg,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImageExportOptions value)? image,
    TResult Function(SVGExportOptions value)? svg,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageExportOptionsImplToJson(
      this,
    );
  }
}

abstract class ImageExportOptions extends ExportOptions {
  const factory ImageExportOptions(
      {required final double width,
      required final double height,
      final double x,
      final double y,
      final double scale,
      final double quality,
      final bool renderBackground}) = _$ImageExportOptionsImpl;
  const ImageExportOptions._() : super._();

  factory ImageExportOptions.fromJson(Map<String, dynamic> json) =
      _$ImageExportOptionsImpl.fromJson;

  @override
  double get width;
  @override
  double get height;
  @override
  double get x;
  @override
  double get y;
  double get scale;
  double get quality;
  @override
  bool get renderBackground;
  @override
  @JsonKey(ignore: true)
  _$$ImageExportOptionsImplCopyWith<_$ImageExportOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SVGExportOptionsImplCopyWith<$Res>
    implements $ExportOptionsCopyWith<$Res> {
  factory _$$SVGExportOptionsImplCopyWith(_$SVGExportOptionsImpl value,
          $Res Function(_$SVGExportOptionsImpl) then) =
      __$$SVGExportOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double width, double height, double x, double y, bool renderBackground});
}

/// @nodoc
class __$$SVGExportOptionsImplCopyWithImpl<$Res>
    extends _$ExportOptionsCopyWithImpl<$Res, _$SVGExportOptionsImpl>
    implements _$$SVGExportOptionsImplCopyWith<$Res> {
  __$$SVGExportOptionsImplCopyWithImpl(_$SVGExportOptionsImpl _value,
      $Res Function(_$SVGExportOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? width = null,
    Object? height = null,
    Object? x = null,
    Object? y = null,
    Object? renderBackground = null,
  }) {
    return _then(_$SVGExportOptionsImpl(
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      renderBackground: null == renderBackground
          ? _value.renderBackground
          : renderBackground // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SVGExportOptionsImpl extends SVGExportOptions {
  const _$SVGExportOptionsImpl(
      {required this.width,
      required this.height,
      this.x = 0,
      this.y = 0,
      this.renderBackground = true,
      final String? $type})
      : $type = $type ?? 'svg',
        super._();

  factory _$SVGExportOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SVGExportOptionsImplFromJson(json);

  @override
  final double width;
  @override
  final double height;
  @override
  @JsonKey()
  final double x;
  @override
  @JsonKey()
  final double y;
  @override
  @JsonKey()
  final bool renderBackground;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ExportOptions.svg(width: $width, height: $height, x: $x, y: $y, renderBackground: $renderBackground)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SVGExportOptionsImpl &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.renderBackground, renderBackground) ||
                other.renderBackground == renderBackground));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, width, height, x, y, renderBackground);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SVGExportOptionsImplCopyWith<_$SVGExportOptionsImpl> get copyWith =>
      __$$SVGExportOptionsImplCopyWithImpl<_$SVGExportOptionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)
        image,
    required TResult Function(double width, double height, double x, double y,
            bool renderBackground)
        svg,
  }) {
    return svg(width, height, x, y, renderBackground);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)?
        image,
    TResult? Function(double width, double height, double x, double y,
            bool renderBackground)?
        svg,
  }) {
    return svg?.call(width, height, x, y, renderBackground);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double width, double height, double x, double y,
            double scale, double quality, bool renderBackground)?
        image,
    TResult Function(double width, double height, double x, double y,
            bool renderBackground)?
        svg,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(width, height, x, y, renderBackground);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImageExportOptions value) image,
    required TResult Function(SVGExportOptions value) svg,
  }) {
    return svg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ImageExportOptions value)? image,
    TResult? Function(SVGExportOptions value)? svg,
  }) {
    return svg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImageExportOptions value)? image,
    TResult Function(SVGExportOptions value)? svg,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SVGExportOptionsImplToJson(
      this,
    );
  }
}

abstract class SVGExportOptions extends ExportOptions {
  const factory SVGExportOptions(
      {required final double width,
      required final double height,
      final double x,
      final double y,
      final bool renderBackground}) = _$SVGExportOptionsImpl;
  const SVGExportOptions._() : super._();

  factory SVGExportOptions.fromJson(Map<String, dynamic> json) =
      _$SVGExportOptionsImpl.fromJson;

  @override
  double get width;
  @override
  double get height;
  @override
  double get x;
  @override
  double get y;
  @override
  bool get renderBackground;
  @override
  @JsonKey(ignore: true)
  _$$SVGExportOptionsImplCopyWith<_$SVGExportOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExportPreset _$ExportPresetFromJson(Map<String, dynamic> json) {
  return _ExportPreset.fromJson(json);
}

/// @nodoc
mixin _$ExportPreset {
  String get name => throw _privateConstructorUsedError;
  List<AreaPreset> get areas => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExportPresetCopyWith<ExportPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExportPresetCopyWith<$Res> {
  factory $ExportPresetCopyWith(
          ExportPreset value, $Res Function(ExportPreset) then) =
      _$ExportPresetCopyWithImpl<$Res, ExportPreset>;
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class _$ExportPresetCopyWithImpl<$Res, $Val extends ExportPreset>
    implements $ExportPresetCopyWith<$Res> {
  _$ExportPresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaPreset>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExportPresetImplCopyWith<$Res>
    implements $ExportPresetCopyWith<$Res> {
  factory _$$ExportPresetImplCopyWith(
          _$ExportPresetImpl value, $Res Function(_$ExportPresetImpl) then) =
      __$$ExportPresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class __$$ExportPresetImplCopyWithImpl<$Res>
    extends _$ExportPresetCopyWithImpl<$Res, _$ExportPresetImpl>
    implements _$$ExportPresetImplCopyWith<$Res> {
  __$$ExportPresetImplCopyWithImpl(
      _$ExportPresetImpl _value, $Res Function(_$ExportPresetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_$ExportPresetImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaPreset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPresetImpl implements _ExportPreset {
  const _$ExportPresetImpl(
      {this.name = '', final List<AreaPreset> areas = const []})
      : _areas = areas;

  factory _$ExportPresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExportPresetImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<AreaPreset> _areas;
  @override
  @JsonKey()
  List<AreaPreset> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  String toString() {
    return 'ExportPreset(name: $name, areas: $areas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPresetImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_areas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportPresetImplCopyWith<_$ExportPresetImpl> get copyWith =>
      __$$ExportPresetImplCopyWithImpl<_$ExportPresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPresetImplToJson(
      this,
    );
  }
}

abstract class _ExportPreset implements ExportPreset {
  const factory _ExportPreset(
      {final String name, final List<AreaPreset> areas}) = _$ExportPresetImpl;

  factory _ExportPreset.fromJson(Map<String, dynamic> json) =
      _$ExportPresetImpl.fromJson;

  @override
  String get name;
  @override
  List<AreaPreset> get areas;
  @override
  @JsonKey(ignore: true)
  _$$ExportPresetImplCopyWith<_$ExportPresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AreaPreset _$AreaPresetFromJson(Map<String, dynamic> json) {
  return _AreaPreset.fromJson(json);
}

/// @nodoc
mixin _$AreaPreset {
  String get page => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get quality => throw _privateConstructorUsedError;
  Area? get area => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaPresetCopyWith<AreaPreset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaPresetCopyWith<$Res> {
  factory $AreaPresetCopyWith(
          AreaPreset value, $Res Function(AreaPreset) then) =
      _$AreaPresetCopyWithImpl<$Res, AreaPreset>;
  @useResult
  $Res call({String page, String name, double quality, Area? area});

  $AreaCopyWith<$Res>? get area;
}

/// @nodoc
class _$AreaPresetCopyWithImpl<$Res, $Val extends AreaPreset>
    implements $AreaPresetCopyWith<$Res> {
  _$AreaPresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? name = null,
    Object? quality = null,
    Object? area = freezed,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as Area?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaCopyWith<$Res>? get area {
    if (_value.area == null) {
      return null;
    }

    return $AreaCopyWith<$Res>(_value.area!, (value) {
      return _then(_value.copyWith(area: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AreaPresetImplCopyWith<$Res>
    implements $AreaPresetCopyWith<$Res> {
  factory _$$AreaPresetImplCopyWith(
          _$AreaPresetImpl value, $Res Function(_$AreaPresetImpl) then) =
      __$$AreaPresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String page, String name, double quality, Area? area});

  @override
  $AreaCopyWith<$Res>? get area;
}

/// @nodoc
class __$$AreaPresetImplCopyWithImpl<$Res>
    extends _$AreaPresetCopyWithImpl<$Res, _$AreaPresetImpl>
    implements _$$AreaPresetImplCopyWith<$Res> {
  __$$AreaPresetImplCopyWithImpl(
      _$AreaPresetImpl _value, $Res Function(_$AreaPresetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? name = null,
    Object? quality = null,
    Object? area = freezed,
  }) {
    return _then(_$AreaPresetImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quality: null == quality
          ? _value.quality
          : quality // ignore: cast_nullable_to_non_nullable
              as double,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as Area?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaPresetImpl implements _AreaPreset {
  const _$AreaPresetImpl(
      {this.page = 'default', this.name = '', this.quality = 1, this.area});

  factory _$AreaPresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaPresetImplFromJson(json);

  @override
  @JsonKey()
  final String page;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double quality;
  @override
  final Area? area;

  @override
  String toString() {
    return 'AreaPreset(page: $page, name: $name, quality: $quality, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaPresetImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quality, quality) || other.quality == quality) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, name, quality, area);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaPresetImplCopyWith<_$AreaPresetImpl> get copyWith =>
      __$$AreaPresetImplCopyWithImpl<_$AreaPresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaPresetImplToJson(
      this,
    );
  }
}

abstract class _AreaPreset implements AreaPreset {
  const factory _AreaPreset(
      {final String page,
      final String name,
      final double quality,
      final Area? area}) = _$AreaPresetImpl;

  factory _AreaPreset.fromJson(Map<String, dynamic> json) =
      _$AreaPresetImpl.fromJson;

  @override
  String get page;
  @override
  String get name;
  @override
  double get quality;
  @override
  Area? get area;
  @override
  @JsonKey(ignore: true)
  _$$AreaPresetImplCopyWith<_$AreaPresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
