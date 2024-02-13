// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LabelContext {
  LabelTool get tool => throw _privateConstructorUsedError;
  TextPainter get textPainter => throw _privateConstructorUsedError;
  PadElement? get element => throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;
  double get zoom => throw _privateConstructorUsedError;
  TextSelection get selection => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)
        text,
    required TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)
        markdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)?
        text,
    TResult? Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)?
        markdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)?
        text,
    TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)?
        markdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContext value) text,
    required TResult Function(MarkdownContext value) markdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContext value)? text,
    TResult? Function(MarkdownContext value)? markdown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContext value)? text,
    TResult Function(MarkdownContext value)? markdown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LabelContextCopyWith<LabelContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelContextCopyWith<$Res> {
  factory $LabelContextCopyWith(
          LabelContext value, $Res Function(LabelContext) then) =
      _$LabelContextCopyWithImpl<$Res, LabelContext>;
  @useResult
  $Res call(
      {LabelTool tool,
      TextPainter textPainter,
      bool isCreating,
      double zoom,
      TextSelection selection});
}

/// @nodoc
class _$LabelContextCopyWithImpl<$Res, $Val extends LabelContext>
    implements $LabelContextCopyWith<$Res> {
  _$LabelContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? textPainter = null,
    Object? isCreating = null,
    Object? zoom = null,
    Object? selection = null,
  }) {
    return _then(_value.copyWith(
      tool: null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as LabelTool,
      textPainter: null == textPainter
          ? _value.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelection,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextContextImplCopyWith<$Res>
    implements $LabelContextCopyWith<$Res> {
  factory _$$TextContextImplCopyWith(
          _$TextContextImpl value, $Res Function(_$TextContextImpl) then) =
      __$$TextContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LabelTool tool,
      TextPainter textPainter,
      TextElement? element,
      bool isCreating,
      double zoom,
      TextSelection selection,
      txt.ParagraphProperty? forcedProperty,
      txt.SpanProperty? forcedSpanProperty,
      bool? forceParagraph});

  $ParagraphPropertyCopyWith<$Res>? get forcedProperty;
  $SpanPropertyCopyWith<$Res>? get forcedSpanProperty;
}

/// @nodoc
class __$$TextContextImplCopyWithImpl<$Res>
    extends _$LabelContextCopyWithImpl<$Res, _$TextContextImpl>
    implements _$$TextContextImplCopyWith<$Res> {
  __$$TextContextImplCopyWithImpl(
      _$TextContextImpl _value, $Res Function(_$TextContextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? textPainter = null,
    Object? element = freezed,
    Object? isCreating = null,
    Object? zoom = null,
    Object? selection = null,
    Object? forcedProperty = freezed,
    Object? forcedSpanProperty = freezed,
    Object? forceParagraph = freezed,
  }) {
    return _then(_$TextContextImpl(
      tool: null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as LabelTool,
      textPainter: null == textPainter
          ? _value.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter,
      element: freezed == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as TextElement?,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelection,
      forcedProperty: freezed == forcedProperty
          ? _value.forcedProperty
          : forcedProperty // ignore: cast_nullable_to_non_nullable
              as txt.ParagraphProperty?,
      forcedSpanProperty: freezed == forcedSpanProperty
          ? _value.forcedSpanProperty
          : forcedSpanProperty // ignore: cast_nullable_to_non_nullable
              as txt.SpanProperty?,
      forceParagraph: freezed == forceParagraph
          ? _value.forceParagraph
          : forceParagraph // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ParagraphPropertyCopyWith<$Res>? get forcedProperty {
    if (_value.forcedProperty == null) {
      return null;
    }

    return $ParagraphPropertyCopyWith<$Res>(_value.forcedProperty!, (value) {
      return _then(_value.copyWith(forcedProperty: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SpanPropertyCopyWith<$Res>? get forcedSpanProperty {
    if (_value.forcedSpanProperty == null) {
      return null;
    }

    return $SpanPropertyCopyWith<$Res>(_value.forcedSpanProperty!, (value) {
      return _then(_value.copyWith(forcedSpanProperty: value));
    });
  }
}

/// @nodoc

class _$TextContextImpl extends TextContext {
  const _$TextContextImpl(
      {required this.tool,
      required this.textPainter,
      this.element,
      this.isCreating = false,
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
  final bool isCreating;
  @override
  @JsonKey()
  final double zoom;
  @override
  @JsonKey()
  final TextSelection selection;
  @override
  final txt.ParagraphProperty? forcedProperty;
  @override
  final txt.SpanProperty? forcedSpanProperty;
  @override
  final bool? forceParagraph;

  @override
  String toString() {
    return 'LabelContext.text(tool: $tool, textPainter: $textPainter, element: $element, isCreating: $isCreating, zoom: $zoom, selection: $selection, forcedProperty: $forcedProperty, forcedSpanProperty: $forcedSpanProperty, forceParagraph: $forceParagraph)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextContextImpl &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter) &&
            (identical(other.element, element) || other.element == element) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
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
  int get hashCode => Object.hash(
      runtimeType,
      tool,
      textPainter,
      element,
      isCreating,
      zoom,
      selection,
      forcedProperty,
      forcedSpanProperty,
      forceParagraph);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextContextImplCopyWith<_$TextContextImpl> get copyWith =>
      __$$TextContextImplCopyWithImpl<_$TextContextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)
        text,
    required TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)
        markdown,
  }) {
    return text(tool, textPainter, element, isCreating, zoom, selection,
        forcedProperty, forcedSpanProperty, forceParagraph);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)?
        text,
    TResult? Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)?
        markdown,
  }) {
    return text?.call(tool, textPainter, element, isCreating, zoom, selection,
        forcedProperty, forcedSpanProperty, forceParagraph);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)?
        text,
    TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)?
        markdown,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(tool, textPainter, element, isCreating, zoom, selection,
          forcedProperty, forcedSpanProperty, forceParagraph);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContext value) text,
    required TResult Function(MarkdownContext value) markdown,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContext value)? text,
    TResult? Function(MarkdownContext value)? markdown,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContext value)? text,
    TResult Function(MarkdownContext value)? markdown,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }
}

abstract class TextContext extends LabelContext {
  const factory TextContext(
      {required final LabelTool tool,
      required final TextPainter textPainter,
      final TextElement? element,
      final bool isCreating,
      final double zoom,
      final TextSelection selection,
      final txt.ParagraphProperty? forcedProperty,
      final txt.SpanProperty? forcedSpanProperty,
      final bool? forceParagraph}) = _$TextContextImpl;
  const TextContext._() : super._();

  @override
  LabelTool get tool;
  @override
  TextPainter get textPainter;
  @override
  TextElement? get element;
  @override
  bool get isCreating;
  @override
  double get zoom;
  @override
  TextSelection get selection;
  txt.ParagraphProperty? get forcedProperty;
  txt.SpanProperty? get forcedSpanProperty;
  bool? get forceParagraph;
  @override
  @JsonKey(ignore: true)
  _$$TextContextImplCopyWith<_$TextContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkdownContextImplCopyWith<$Res>
    implements $LabelContextCopyWith<$Res> {
  factory _$$MarkdownContextImplCopyWith(_$MarkdownContextImpl value,
          $Res Function(_$MarkdownContextImpl) then) =
      __$$MarkdownContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LabelTool tool,
      TextPainter textPainter,
      MarkdownElement? element,
      bool isCreating,
      double zoom,
      TextSelection selection});
}

/// @nodoc
class __$$MarkdownContextImplCopyWithImpl<$Res>
    extends _$LabelContextCopyWithImpl<$Res, _$MarkdownContextImpl>
    implements _$$MarkdownContextImplCopyWith<$Res> {
  __$$MarkdownContextImplCopyWithImpl(
      _$MarkdownContextImpl _value, $Res Function(_$MarkdownContextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
    Object? textPainter = null,
    Object? element = freezed,
    Object? isCreating = null,
    Object? zoom = null,
    Object? selection = null,
  }) {
    return _then(_$MarkdownContextImpl(
      tool: null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as LabelTool,
      textPainter: null == textPainter
          ? _value.textPainter
          : textPainter // ignore: cast_nullable_to_non_nullable
              as TextPainter,
      element: freezed == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as MarkdownElement?,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
      zoom: null == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as double,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as TextSelection,
    ));
  }
}

/// @nodoc

class _$MarkdownContextImpl extends MarkdownContext {
  const _$MarkdownContextImpl(
      {required this.tool,
      required this.textPainter,
      this.element,
      this.isCreating = false,
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
  final bool isCreating;
  @override
  @JsonKey()
  final double zoom;
  @override
  @JsonKey()
  final TextSelection selection;

  @override
  String toString() {
    return 'LabelContext.markdown(tool: $tool, textPainter: $textPainter, element: $element, isCreating: $isCreating, zoom: $zoom, selection: $selection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkdownContextImpl &&
            (identical(other.tool, tool) || other.tool == tool) &&
            (identical(other.textPainter, textPainter) ||
                other.textPainter == textPainter) &&
            (identical(other.element, element) || other.element == element) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating) &&
            (identical(other.zoom, zoom) || other.zoom == zoom) &&
            (identical(other.selection, selection) ||
                other.selection == selection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, tool, textPainter, element, isCreating, zoom, selection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkdownContextImplCopyWith<_$MarkdownContextImpl> get copyWith =>
      __$$MarkdownContextImplCopyWithImpl<_$MarkdownContextImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)
        text,
    required TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)
        markdown,
  }) {
    return markdown(tool, textPainter, element, isCreating, zoom, selection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)?
        text,
    TResult? Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)?
        markdown,
  }) {
    return markdown?.call(
        tool, textPainter, element, isCreating, zoom, selection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            TextElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection,
            txt.ParagraphProperty? forcedProperty,
            txt.SpanProperty? forcedSpanProperty,
            bool? forceParagraph)?
        text,
    TResult Function(
            LabelTool tool,
            TextPainter textPainter,
            MarkdownElement? element,
            bool isCreating,
            double zoom,
            TextSelection selection)?
        markdown,
    required TResult orElse(),
  }) {
    if (markdown != null) {
      return markdown(tool, textPainter, element, isCreating, zoom, selection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextContext value) text,
    required TResult Function(MarkdownContext value) markdown,
  }) {
    return markdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextContext value)? text,
    TResult? Function(MarkdownContext value)? markdown,
  }) {
    return markdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextContext value)? text,
    TResult Function(MarkdownContext value)? markdown,
    required TResult orElse(),
  }) {
    if (markdown != null) {
      return markdown(this);
    }
    return orElse();
  }
}

abstract class MarkdownContext extends LabelContext {
  const factory MarkdownContext(
      {required final LabelTool tool,
      required final TextPainter textPainter,
      final MarkdownElement? element,
      final bool isCreating,
      final double zoom,
      final TextSelection selection}) = _$MarkdownContextImpl;
  const MarkdownContext._() : super._();

  @override
  LabelTool get tool;
  @override
  TextPainter get textPainter;
  @override
  MarkdownElement? get element;
  @override
  bool get isCreating;
  @override
  double get zoom;
  @override
  TextSelection get selection;
  @override
  @JsonKey(ignore: true)
  _$$MarkdownContextImplCopyWith<_$MarkdownContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
