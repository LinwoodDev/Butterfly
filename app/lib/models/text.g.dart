// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DefinedSpanProperty _$$DefinedSpanPropertyFromJson(Map json) =>
    _$DefinedSpanProperty(
      size: (json['size'] as num?)?.toDouble() ?? 12,
      color: json['color'] as int? ?? kColorBlack,
      fontWeight: json['fontWeight'] as int? ?? 3,
      lineThrough: json['lineThrough'] as bool? ?? false,
      underline: json['underline'] as bool? ?? false,
      overline: json['overline'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble() ?? 0,
      decorationColor: json['decorationColor'] as int? ?? kColorBlack,
      decorationStyle: $enumDecodeNullable(
              _$TextDecorationStyleEnumMap, json['decorationStyle']) ??
          TextDecorationStyle.solid,
      decorationThickness:
          (json['decorationThickness'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedSpanPropertyToJson(
        _$DefinedSpanProperty instance) =>
    <String, dynamic>{
      'size': instance.size,
      'color': instance.color,
      'fontWeight': instance.fontWeight,
      'lineThrough': instance.lineThrough,
      'underline': instance.underline,
      'overline': instance.overline,
      'italic': instance.italic,
      'letterSpacing': instance.letterSpacing,
      'decorationColor': instance.decorationColor,
      'decorationStyle':
          _$TextDecorationStyleEnumMap[instance.decorationStyle]!,
      'decorationThickness': instance.decorationThickness,
      'type': instance.$type,
    };

const _$TextDecorationStyleEnumMap = {
  TextDecorationStyle.solid: 'solid',
  TextDecorationStyle.double: 'double',
  TextDecorationStyle.dotted: 'dotted',
  TextDecorationStyle.dashed: 'dashed',
  TextDecorationStyle.wavy: 'wavy',
};

_$NamedSpanProperty _$$NamedSpanPropertyFromJson(Map json) =>
    _$NamedSpanProperty(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedSpanPropertyToJson(_$NamedSpanProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedSpanProperty _$$UndefinedSpanPropertyFromJson(Map json) =>
    _$UndefinedSpanProperty(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedSpanPropertyToJson(
        _$UndefinedSpanProperty instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$DefinedAbstractProperty _$$DefinedAbstractPropertyFromJson(Map json) =>
    _$DefinedAbstractProperty(
      spanProperty: json['spanProperty'] == null
          ? const SpanProperty.undefined()
          : SpanProperty.fromJson(
              Map<String, dynamic>.from(json['spanProperty'] as Map)),
      alignment: $enumDecodeNullable(
              _$HorizontalAlignmentEnumMap, json['alignment']) ??
          HorizontalAlignment.left,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DefinedAbstractPropertyToJson(
        _$DefinedAbstractProperty instance) =>
    <String, dynamic>{
      'spanProperty': instance.spanProperty.toJson(),
      'alignment': _$HorizontalAlignmentEnumMap[instance.alignment]!,
      'type': instance.$type,
    };

const _$HorizontalAlignmentEnumMap = {
  HorizontalAlignment.left: 'left',
  HorizontalAlignment.center: 'center',
  HorizontalAlignment.right: 'right',
  HorizontalAlignment.justify: 'justify',
};

_$NamedAbstractProperty _$$NamedAbstractPropertyFromJson(Map json) =>
    _$NamedAbstractProperty(
      json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NamedAbstractPropertyToJson(
        _$NamedAbstractProperty instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.$type,
    };

_$UndefinedAbstractProperty _$$UndefinedAbstractPropertyFromJson(Map json) =>
    _$UndefinedAbstractProperty(
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$UndefinedAbstractPropertyToJson(
        _$UndefinedAbstractProperty instance) =>
    <String, dynamic>{
      'type': instance.$type,
    };

_$_TextSpan _$$_TextSpanFromJson(Map json) => _$_TextSpan(
      text: json['text'] as String? ?? '',
      property: json['property'] == null
          ? const SpanProperty.undefined()
          : SpanProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
    );

Map<String, dynamic> _$$_TextSpanToJson(_$_TextSpan instance) =>
    <String, dynamic>{
      'text': instance.text,
      'property': instance.property.toJson(),
    };

_$_AbstractProperty _$$_AbstractPropertyFromJson(Map json) =>
    _$_AbstractProperty(
      textProperty: json['textProperty'] == null
          ? const AbstractProperty.undefined()
          : AbstractProperty.fromJson(
              Map<String, dynamic>.from(json['textProperty'] as Map)),
      textSpans: (json['textSpans'] as List<dynamic>?)
              ?.map(
                  (e) => TextSpan.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AbstractPropertyToJson(_$_AbstractProperty instance) =>
    <String, dynamic>{
      'textProperty': instance.textProperty.toJson(),
      'textSpans': instance.textSpans.map((e) => e.toJson()).toList(),
    };
