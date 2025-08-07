// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefinedSpanProperty _$DefinedSpanPropertyFromJson(Map json) =>
    DefinedSpanProperty(
      size: (json['size'] as num?)?.toDouble(),
      color: _$JsonConverterFromJson<int, SRGBColor>(
        json['color'],
        const ColorJsonConverter().fromJson,
      ),
      fontWeight: (json['fontWeight'] as num?)?.toInt(),
      lineThrough: json['lineThrough'] as bool?,
      underline: json['underline'] as bool?,
      overline: json['overline'] as bool?,
      italic: json['italic'] as bool?,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      decorationColor: _$JsonConverterFromJson<int, SRGBColor>(
        json['decorationColor'],
        const ColorJsonConverter().fromJson,
      ),
      decorationStyle: $enumDecodeNullable(
        _$TextDecorationStyleEnumMap,
        json['decorationStyle'],
      ),
      decorationThickness: (json['decorationThickness'] as num?)?.toDouble(),
      backgroundColor: _$JsonConverterFromJson<int, SRGBColor>(
        json['backgroundColor'],
        const ColorJsonConverter().fromJson,
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DefinedSpanPropertyToJson(
  DefinedSpanProperty instance,
) => <String, dynamic>{
  'size': instance.size,
  'color': _$JsonConverterToJson<int, SRGBColor>(
    instance.color,
    const ColorJsonConverter().toJson,
  ),
  'fontWeight': instance.fontWeight,
  'lineThrough': instance.lineThrough,
  'underline': instance.underline,
  'overline': instance.overline,
  'italic': instance.italic,
  'letterSpacing': instance.letterSpacing,
  'decorationColor': _$JsonConverterToJson<int, SRGBColor>(
    instance.decorationColor,
    const ColorJsonConverter().toJson,
  ),
  'decorationStyle': _$TextDecorationStyleEnumMap[instance.decorationStyle],
  'decorationThickness': instance.decorationThickness,
  'backgroundColor': _$JsonConverterToJson<int, SRGBColor>(
    instance.backgroundColor,
    const ColorJsonConverter().toJson,
  ),
  'type': instance.$type,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

NamedSpanProperty _$NamedSpanPropertyFromJson(Map json) =>
    NamedSpanProperty(json['name'] as String, $type: json['type'] as String?);

Map<String, dynamic> _$NamedSpanPropertyToJson(NamedSpanProperty instance) =>
    <String, dynamic>{'name': instance.name, 'type': instance.$type};

UndefinedSpanProperty _$UndefinedSpanPropertyFromJson(Map json) =>
    UndefinedSpanProperty($type: json['type'] as String?);

Map<String, dynamic> _$UndefinedSpanPropertyToJson(
  UndefinedSpanProperty instance,
) => <String, dynamic>{'type': instance.$type};

DefinedParagraphProperty _$DefinedParagraphPropertyFromJson(Map json) =>
    DefinedParagraphProperty(
      span: json['span'] == null
          ? const DefinedSpanProperty()
          : DefinedSpanProperty.fromJson(
              Map<String, dynamic>.from(json['span'] as Map),
            ),
      alignment:
          $enumDecodeNullable(
            _$HorizontalAlignmentEnumMap,
            json['alignment'],
          ) ??
          HorizontalAlignment.left,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$DefinedParagraphPropertyToJson(
  DefinedParagraphProperty instance,
) => <String, dynamic>{
  'span': instance.span.toJson(),
  'alignment': _$HorizontalAlignmentEnumMap[instance.alignment]!,
  'type': instance.$type,
};

const _$HorizontalAlignmentEnumMap = {
  HorizontalAlignment.left: 'left',
  HorizontalAlignment.center: 'center',
  HorizontalAlignment.right: 'right',
  HorizontalAlignment.justify: 'justify',
};

NamedParagraphProperty _$NamedParagraphPropertyFromJson(Map json) =>
    NamedParagraphProperty(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$NamedParagraphPropertyToJson(
  NamedParagraphProperty instance,
) => <String, dynamic>{'name': instance.name, 'type': instance.$type};

UndefinedParagraphProperty _$UndefinedParagraphPropertyFromJson(Map json) =>
    UndefinedParagraphProperty($type: json['type'] as String?);

Map<String, dynamic> _$UndefinedParagraphPropertyToJson(
  UndefinedParagraphProperty instance,
) => <String, dynamic>{'type': instance.$type};

_AreaProperty _$AreaPropertyFromJson(Map json) => _AreaProperty(
  alignment:
      $enumDecodeNullable(_$VerticalAlignmentEnumMap, json['alignment']) ??
      VerticalAlignment.top,
);

Map<String, dynamic> _$AreaPropertyToJson(_AreaProperty instance) =>
    <String, dynamic>{
      'alignment': _$VerticalAlignmentEnumMap[instance.alignment]!,
    };

const _$VerticalAlignmentEnumMap = {
  VerticalAlignment.top: 'top',
  VerticalAlignment.center: 'center',
  VerticalAlignment.bottom: 'bottom',
};

TextSpan _$TextSpanFromJson(Map json) => TextSpan(
  text: json['text'] as String? ?? '',
  property: json['property'] == null
      ? const SpanProperty.undefined()
      : SpanProperty.fromJson(
          Map<String, dynamic>.from(json['property'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TextSpanToJson(TextSpan instance) => <String, dynamic>{
  'text': instance.text,
  'property': instance.property.toJson(),
  'type': instance.$type,
};

MathTextSpan _$MathTextSpanFromJson(Map json) => MathTextSpan(
  text: json['text'] as String? ?? '',
  property: json['property'] == null
      ? const SpanProperty.undefined()
      : SpanProperty.fromJson(
          Map<String, dynamic>.from(json['property'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MathTextSpanToJson(MathTextSpan instance) =>
    <String, dynamic>{
      'text': instance.text,
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_TextParagraph _$TextParagraphFromJson(Map json) => _TextParagraph(
  property: json['property'] == null
      ? const ParagraphProperty.undefined()
      : ParagraphProperty.fromJson(
          Map<String, dynamic>.from(json['property'] as Map),
        ),
  textSpans:
      (json['textSpans'] as List<dynamic>?)
          ?.map((e) => InlineSpan.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TextParagraphToJson(_TextParagraph instance) =>
    <String, dynamic>{
      'property': instance.property.toJson(),
      'textSpans': instance.textSpans.map((e) => e.toJson()).toList(),
    };

_TextArea _$TextAreaFromJson(Map json) => _TextArea(
  areaProperty: json['areaProperty'] == null
      ? const AreaProperty()
      : AreaProperty.fromJson(
          Map<String, dynamic>.from(json['areaProperty'] as Map),
        ),
  paragraph: TextParagraph.fromJson(
    Map<String, dynamic>.from(json['paragraph'] as Map),
  ),
);

Map<String, dynamic> _$TextAreaToJson(_TextArea instance) => <String, dynamic>{
  'areaProperty': instance.areaProperty.toJson(),
  'paragraph': instance.paragraph.toJson(),
};

_TextStyleSheet _$TextStyleSheetFromJson(Map json) => _TextStyleSheet(
  spanProperties:
      (json['spanProperties'] as Map?)?.map(
        (k, e) => MapEntry(
          k as String,
          DefinedSpanProperty.fromJson(Map<String, dynamic>.from(e as Map)),
        ),
      ) ??
      const {},
  paragraphProperties:
      (json['paragraphProperties'] as Map?)?.map(
        (k, e) => MapEntry(
          k as String,
          DefinedParagraphProperty.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        ),
      ) ??
      const {},
);

Map<String, dynamic> _$TextStyleSheetToJson(_TextStyleSheet instance) =>
    <String, dynamic>{
      'spanProperties': instance.spanProperties.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
      'paragraphProperties': instance.paragraphProperties.map(
        (k, e) => MapEntry(k, e.toJson()),
      ),
    };
