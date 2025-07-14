// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LabelContext {
  LabelTool get tool;
  TextPainter get textPainter;
  PadElement? get element;
  double get zoom;
  TextSelection get selection;

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LabelContextCopyWith<LabelContext> get copyWith =>
      _$LabelContextCopyWithImpl<LabelContext>(
          this as LabelContext, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LabelContext &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter) &&
            (identical(other.element, element) || other.element == element) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.selection, selection) ||
                other.selection == selection));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tool, textPainter, element, zoom, selection);

  @override
  String toString() {
    return 'LabelContext(tool: $tool, textPainter: $textPainter, element: $element, zoom: $zoom, selection: $selection)';
  }
}

/// @nodoc
abstract mixin class $LabelContextCopyWith<$Res> {
  factory $LabelContextCopyWith(
          LabelContext value, $Res Function(LabelContext) _then) =
      _$LabelContextCopyWithImpl;
  @useResult
  $Res call(
      {LabelTool tool,
      TextPainter textPainter,
      double zoom,
      TextSelection selection});
}

/// @nodoc
class _$LabelContextCopyWithImpl<$Res> implements $LabelContextCopyWith<$Res> {
  _$LabelContextCopyWithImpl(this._self, this._then);

  final LabelContext _self;
  final $Res Function(LabelContext) _then;

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? textPainter = null,
    Object? zoom = null,
    Object? selection = null,
  }) {
    return _then(_self.copyWith(
      tool: null == tool
          ? _self.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as LabelTool,
      textPainter: null == textPainter
          ? _self.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter,
      zoom: null == zoom
          ? _self.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      selection: null == selection
          ? _self.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelection,
    ));
  }
}

/// @nodoc

class TextContext extends LabelContext {
  const TextContext(
      {required this.tool,
      required this.textPainter,
      this.element,
      this.zoom = 1.0,
      this.selection = const TextSelection.collapsed(offset: 0),
      this.forcedProperty,
      this.forcedSpanProperty,
      this.forceParagraph})
      : super._();

  @override
  final LabelTool tool;
  @override
  final TextPainter textPainter;
  @override
  final TextElement? element;
  @override
  @JsonKey()
  final double zoom;
  @override
  @JsonKey()
  final TextSelection selection;
  final ParagraphProperty? forcedProperty;
  final SpanProperty? forcedSpanProperty;
  final bool? forceParagraph;

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextContextCopyWith<TextContext> get copyWith =>
      _$TextContextCopyWithImpl<TextContext>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextContext &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter) &&
            (identical(other.element, element) || other.element == element) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.selection, selection) ||
                other.selection == selection) &&
            (identical(other.forcedProperty, forcedProperty) ||
                other.forcedProperty == forcedProperty) &&
            (identical(other.forcedSpanProperty, forcedSpanProperty) ||
                other.forcedSpanProperty == forcedSpanProperty) &&
            (identical(other.forceParagraph, forceParagraph) ||
                other.forceParagraph == forceParagraph));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tool, textPainter, element, zoom,
      selection, forcedProperty, forcedSpanProperty, forceParagraph);

  @override
  String toString() {
    return 'LabelContext.text(tool: $tool, textPainter: $textPainter, element: $element, zoom: $zoom, selection: $selection, forcedProperty: $forcedProperty, forcedSpanProperty: $forcedSpanProperty, forceParagraph: $forceParagraph)';
  }
}

/// @nodoc
abstract mixin class $TextContextCopyWith<$Res>
    implements $LabelContextCopyWith<$Res> {
  factory $TextContextCopyWith(
          TextContext value, $Res Function(TextContext) _then) =
      _$TextContextCopyWithImpl;
  @override
  @useResult
  $Res call(
      {LabelTool tool,
      TextPainter textPainter,
      TextElement? element,
      double zoom,
      TextSelection selection,
      ParagraphProperty? forcedProperty,
      SpanProperty? forcedSpanProperty,
      bool? forceParagraph});

  $ParagraphPropertyCopyWith<$Res>? get forcedProperty;
  $SpanPropertyCopyWith<$Res>? get forcedSpanProperty;
}

/// @nodoc
class _$TextContextCopyWithImpl<$Res> implements $TextContextCopyWith<$Res> {
  _$TextContextCopyWithImpl(this._self, this._then);

  final TextContext _self;
  final $Res Function(TextContext) _then;

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tool = null,
    Object? textPainter = null,
    Object? element = freezed,
    Object? zoom = null,
    Object? selection = null,
    Object? forcedProperty = freezed,
    Object? forcedSpanProperty = freezed,
    Object? forceParagraph = freezed,
  }) {
    return _then(TextContext(
      tool: null == tool
          ? _self.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as LabelTool,
      textPainter: null == textPainter
          ? _self.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter,
      element: freezed == element
          ? _self.element
          : element // ignore: cast_nullable_to_non_nullable
              as TextElement?,
      zoom: null == zoom
          ? _self.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      selection: null == selection
          ? _self.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelection,
      forcedProperty: freezed == forcedProperty
          ? _self.forcedProperty
          : forcedProperty // ignore: cast_nullable_to_non_nullable
              as ParagraphProperty?,
      forcedSpanProperty: freezed == forcedSpanProperty
          ? _self.forcedSpanProperty
          : forcedSpanProperty // ignore: cast_nullable_to_non_nullable
              as SpanProperty?,
      forceParagraph: freezed == forceParagraph
          ? _self.forceParagraph
          : forceParagraph // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ParagraphPropertyCopyWith<$Res>? get forcedProperty {
    if (_self.forcedProperty == null) {
      return null;
    }

    return $ParagraphPropertyCopyWith<$Res>(_self.forcedProperty!, (value) {
      return _then(_self.copyWith(forcedProperty: value));
    });
  }

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpanPropertyCopyWith<$Res>? get forcedSpanProperty {
    if (_self.forcedSpanProperty == null) {
      return null;
    }

    return $SpanPropertyCopyWith<$Res>(_self.forcedSpanProperty!, (value) {
      return _then(_self.copyWith(forcedSpanProperty: value));
    });
  }
}

/// @nodoc

class MarkdownContext extends LabelContext {
  const MarkdownContext(
      {required this.tool,
      required this.textPainter,
      this.element,
      this.zoom = 1.0,
      this.selection = const TextSelection.collapsed(offset: 0)})
      : super._();

  @override
  final LabelTool tool;
  @override
  final TextPainter textPainter;
  @override
  final MarkdownElement? element;
  @override
  @JsonKey()
  final double zoom;
  @override
  @JsonKey()
  final TextSelection selection;

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MarkdownContextCopyWith<MarkdownContext> get copyWith =>
      _$MarkdownContextCopyWithImpl<MarkdownContext>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MarkdownContext &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter) &&
            (identical(other.element, element) || other.element == element) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.selection, selection) ||
                other.selection == selection));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tool, textPainter, element, zoom, selection);

  @override
  String toString() {
    return 'LabelContext.markdown(tool: $tool, textPainter: $textPainter, element: $element, zoom: $zoom, selection: $selection)';
  }
}

/// @nodoc
abstract mixin class $MarkdownContextCopyWith<$Res>
    implements $LabelContextCopyWith<$Res> {
  factory $MarkdownContextCopyWith(
          MarkdownContext value, $Res Function(MarkdownContext) _then) =
      _$MarkdownContextCopyWithImpl;
  @override
  @useResult
  $Res call(
      {LabelTool tool,
      TextPainter textPainter,
      MarkdownElement? element,
      double zoom,
      TextSelection selection});
}

/// @nodoc
class _$MarkdownContextCopyWithImpl<$Res>
    implements $MarkdownContextCopyWith<$Res> {
  _$MarkdownContextCopyWithImpl(this._self, this._then);

  final MarkdownContext _self;
  final $Res Function(MarkdownContext) _then;

  /// Create a copy of LabelContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tool = null,
    Object? textPainter = null,
    Object? element = freezed,
    Object? zoom = null,
    Object? selection = null,
  }) {
    return _then(MarkdownContext(
      tool: null == tool
          ? _self.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as LabelTool,
      textPainter: null == textPainter
          ? _self.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter,
      element: freezed == element
          ? _self.element
          : element // ignore: cast_nullable_to_non_nullable
              as MarkdownElement?,
      zoom: null == zoom
          ? _self.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      selection: null == selection
          ? _self.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelection,
    ));
  }
}

// dart format on
