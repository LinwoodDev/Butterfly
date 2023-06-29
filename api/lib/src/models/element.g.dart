// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ElementConstraint _$$_ElementConstraintFromJson(Map json) =>
    _$_ElementConstraint(
      size: (json['size'] as num?)?.toDouble() ?? 0,
      length: (json['length'] as num?)?.toDouble() ?? 0,
      includeArea: json['includeArea'] as bool? ?? true,
    );

Map<String, dynamic> _$$_ElementConstraintToJson(
        _$_ElementConstraint instance) =>
    <String, dynamic>{
      'size': instance.size,
      'length': instance.length,
      'includeArea': instance.includeArea,
    };

_$ScaledElementConstraints _$$ScaledElementConstraintsFromJson(Map json) =>
    _$ScaledElementConstraints(
      scaleX: (json['scaleX'] as num?)?.toDouble() ?? 1,
      scaleY: (json['scaleY'] as num?)?.toDouble() ?? 1,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ScaledElementConstraintsToJson(
        _$ScaledElementConstraints instance) =>
    <String, dynamic>{
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'type': instance.$type,
    };

_$FixedElementConstraints _$$FixedElementConstraintsFromJson(Map json) =>
    _$FixedElementConstraints(
      (json['height'] as num).toDouble(),
      (json['width'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$FixedElementConstraintsToJson(
        _$FixedElementConstraints instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'type': instance.$type,
    };

_$DynamicElementConstraints _$$DynamicElementConstraintsFromJson(Map json) =>
    _$DynamicElementConstraints(
      height: (json['height'] as num?)?.toDouble() ?? 0,
      width: (json['width'] as num?)?.toDouble() ?? 0,
      aspectRatio: (json['aspectRatio'] as num?)?.toDouble() ?? 0,
      includeArea: json['includeArea'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$DynamicElementConstraintsToJson(
        _$DynamicElementConstraints instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'aspectRatio': instance.aspectRatio,
      'includeArea': instance.includeArea,
      'type': instance.$type,
    };

_$PenElement _$$PenElementFromJson(Map json) => _$PenElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      zoom: (json['zoom'] as num?)?.toDouble(),
      points: (json['points'] as List<dynamic>?)
              ?.map((e) =>
                  PathPoint.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      property: json['property'] == null
          ? const PenProperty()
          : PenProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PenElementToJson(_$PenElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'zoom': instance.zoom,
      'points': instance.points.map((e) => e.toJson()).toList(),
      'property': instance.property.toJson(),
      'type': instance.$type,
    };

_$TextElement _$$TextElementFromJson(Map json) => _$TextElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      area: TextArea.fromJson(Map<String, dynamic>.from(json['area'] as Map)),
      constraint: json['constraint'] == null
          ? const ElementConstraint(size: 1000)
          : ElementConstraint.fromJson(
              Map<String, dynamic>.from(json['constraint'] as Map)),
      foreground: json['foreground'] as int? ?? kColorBlack,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TextElementToJson(_$TextElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
      'styleSheet': instance.styleSheet.toJson(),
      'area': instance.area.toJson(),
      'constraint': instance.constraint.toJson(),
      'foreground': instance.foreground,
      'type': instance.$type,
    };

_$MarkdownElement _$$MarkdownElementFromJson(Map json) => _$MarkdownElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      styleSheet: json['styleSheet'] == null
          ? const PackAssetLocation()
          : PackAssetLocation.fromJson(
              Map<String, dynamic>.from(json['styleSheet'] as Map)),
      areaProperty: json['areaProperty'] == null
          ? const AreaProperty()
          : AreaProperty.fromJson(
              Map<String, dynamic>.from(json['areaProperty'] as Map)),
      text: json['text'] as String,
      constraint: json['constraint'] == null
          ? const ElementConstraint(size: 1000)
          : ElementConstraint.fromJson(
              Map<String, dynamic>.from(json['constraint'] as Map)),
      foreground: json['foreground'] as int? ?? kColorBlack,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$MarkdownElementToJson(_$MarkdownElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'scale': instance.scale,
      'styleSheet': instance.styleSheet.toJson(),
      'areaProperty': instance.areaProperty.toJson(),
      'text': instance.text,
      'constraint': instance.constraint.toJson(),
      'foreground': instance.foreground,
      'type': instance.$type,
    };

_$ImageElement _$$ImageElementFromJson(Map json) => _$ImageElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      constraints: json['constraints'] == null
          ? const ScaledElementConstraints(scaleX: 1, scaleY: 1)
          : ElementConstraints.fromJson(
              Map<String, dynamic>.from(json['constraints'] as Map)),
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ImageElementToJson(_$ImageElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'constraints': instance.constraints?.toJson(),
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'type': instance.$type,
    };

_$SvgElement _$$SvgElementFromJson(Map json) => _$SvgElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      position: json['position'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter().fromJson(json['position'] as Map),
      constraints: json['constraints'] == null
          ? const ScaledElementConstraints(scaleX: 1, scaleY: 1)
          : ElementConstraints.fromJson(
              Map<String, dynamic>.from(json['constraints'] as Map)),
      source: json['source'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SvgElementToJson(_$SvgElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'position': const DoublePointJsonConverter().toJson(instance.position),
      'constraints': instance.constraints?.toJson(),
      'source': instance.source,
      'width': instance.width,
      'height': instance.height,
      'type': instance.$type,
    };

_$ShapeElement _$$ShapeElementFromJson(Map json) => _$ShapeElement(
      rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
      layer: json['layer'] as String? ?? '',
      firstPosition: json['firstPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['firstPosition'] as Map),
      secondPosition: json['secondPosition'] == null
          ? const Point(0.0, 0.0)
          : const DoublePointJsonConverter()
              .fromJson(json['secondPosition'] as Map),
      property: json['property'] == null
          ? const ShapeProperty(shape: RectangleShape())
          : ShapeProperty.fromJson(
              Map<String, dynamic>.from(json['property'] as Map)),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ShapeElementToJson(_$ShapeElement instance) =>
    <String, dynamic>{
      'rotation': instance.rotation,
      'layer': instance.layer,
      'firstPosition':
          const DoublePointJsonConverter().toJson(instance.firstPosition),
      'secondPosition':
          const DoublePointJsonConverter().toJson(instance.secondPosition),
      'property': instance.property.toJson(),
      'type': instance.$type,
    };
