// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DocumentInfo _$DocumentInfoFromJson(Map<String, dynamic> json) {
  return _DocumentInfo.fromJson(json);
}

/// @nodoc
mixin _$DocumentInfo {
  List<Tool> get tools => throw _privateConstructorUsedError;
  List<ExportPreset> get exportPresets => throw _privateConstructorUsedError;
  ViewOption get view => throw _privateConstructorUsedError;
  Map<String, dynamic> get extra => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentInfoCopyWith<DocumentInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentInfoCopyWith<$Res> {
  factory $DocumentInfoCopyWith(
          DocumentInfo value, $Res Function(DocumentInfo) then) =
      _$DocumentInfoCopyWithImpl<$Res, DocumentInfo>;
  @useResult
  $Res call(
      {List<Tool> tools,
      List<ExportPreset> exportPresets,
      ViewOption view,
      Map<String, dynamic> extra});

  $ViewOptionCopyWith<$Res> get view;
}

/// @nodoc
class _$DocumentInfoCopyWithImpl<$Res, $Val extends DocumentInfo>
    implements $DocumentInfoCopyWith<$Res> {
  _$DocumentInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tools = null,
    Object? exportPresets = null,
    Object? view = null,
    Object? extra = null,
  }) {
    return _then(_value.copyWith(
      tools: null == tools
          ? _value.tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<Tool>,
      exportPresets: null == exportPresets
          ? _value.exportPresets
          : exportPresets // ignore: cast_nullable_to_non_nullable
              as List<ExportPreset>,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as ViewOption,
      extra: null == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ViewOptionCopyWith<$Res> get view {
    return $ViewOptionCopyWith<$Res>(_value.view, (value) {
      return _then(_value.copyWith(view: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DocumentInfoImplCopyWith<$Res>
    implements $DocumentInfoCopyWith<$Res> {
  factory _$$DocumentInfoImplCopyWith(
          _$DocumentInfoImpl value, $Res Function(_$DocumentInfoImpl) then) =
      __$$DocumentInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Tool> tools,
      List<ExportPreset> exportPresets,
      ViewOption view,
      Map<String, dynamic> extra});

  @override
  $ViewOptionCopyWith<$Res> get view;
}

/// @nodoc
class __$$DocumentInfoImplCopyWithImpl<$Res>
    extends _$DocumentInfoCopyWithImpl<$Res, _$DocumentInfoImpl>
    implements _$$DocumentInfoImplCopyWith<$Res> {
  __$$DocumentInfoImplCopyWithImpl(
      _$DocumentInfoImpl _value, $Res Function(_$DocumentInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tools = null,
    Object? exportPresets = null,
    Object? view = null,
    Object? extra = null,
  }) {
    return _then(_$DocumentInfoImpl(
      tools: null == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<Tool>,
      exportPresets: null == exportPresets
          ? _value._exportPresets
          : exportPresets // ignore: cast_nullable_to_non_nullable
              as List<ExportPreset>,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as ViewOption,
      extra: null == extra
          ? _value._extra
          : extra // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentInfoImpl implements _DocumentInfo {
  const _$DocumentInfoImpl(
      {final List<Tool> tools = const [],
      final List<ExportPreset> exportPresets = const [],
      this.view = const ViewOption(),
      final Map<String, dynamic> extra = const {}})
      : _tools = tools,
        _exportPresets = exportPresets,
        _extra = extra;

  factory _$DocumentInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentInfoImplFromJson(json);

  final List<Tool> _tools;
  @override
  @JsonKey()
  List<Tool> get tools {
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tools);
  }

  final List<ExportPreset> _exportPresets;
  @override
  @JsonKey()
  List<ExportPreset> get exportPresets {
    if (_exportPresets is EqualUnmodifiableListView) return _exportPresets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exportPresets);
  }

  @override
  @JsonKey()
  final ViewOption view;
  final Map<String, dynamic> _extra;
  @override
  @JsonKey()
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @override
  String toString() {
    return 'DocumentInfo(tools: $tools, exportPresets: $exportPresets, view: $view, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentInfoImpl &&
            const DeepCollectionEquality().equals(other._tools, _tools) &&
            const DeepCollectionEquality()
                .equals(other._exportPresets, _exportPresets) &&
            (identical(other.view, view) || other.view == view) &&
            const DeepCollectionEquality().equals(other._extra, _extra));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tools),
      const DeepCollectionEquality().hash(_exportPresets),
      view,
      const DeepCollectionEquality().hash(_extra));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentInfoImplCopyWith<_$DocumentInfoImpl> get copyWith =>
      __$$DocumentInfoImplCopyWithImpl<_$DocumentInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentInfoImplToJson(
      this,
    );
  }
}

abstract class _DocumentInfo implements DocumentInfo {
  const factory _DocumentInfo(
      {final List<Tool> tools,
      final List<ExportPreset> exportPresets,
      final ViewOption view,
      final Map<String, dynamic> extra}) = _$DocumentInfoImpl;

  factory _DocumentInfo.fromJson(Map<String, dynamic> json) =
      _$DocumentInfoImpl.fromJson;

  @override
  List<Tool> get tools;
  @override
  List<ExportPreset> get exportPresets;
  @override
  ViewOption get view;
  @override
  Map<String, dynamic> get extra;
  @override
  @JsonKey(ignore: true)
  _$$DocumentInfoImplCopyWith<_$DocumentInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
