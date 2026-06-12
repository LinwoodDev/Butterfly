// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidElementPaint _$SolidElementPaintFromJson(Map json) => SolidElementPaint(
  color: json['color'] == null
      ? SRGBColor.black
      : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
  blur: (json['blur'] as num?)?.toDouble() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SolidElementPaintToJson(SolidElementPaint instance) =>
    <String, dynamic>{
      'color': const ColorJsonConverter().toJson(instance.color),
      'blur': instance.blur,
      'type': instance.$type,
    };

ImageElementPaint _$ImageElementPaintFromJson(Map json) => ImageElementPaint(
  source: json['source'] as String,
  tint: json['tint'] == null
      ? SRGBColor.white
      : const ColorJsonConverter().fromJson((json['tint'] as num).toInt()),
  scale: (json['scale'] as num?)?.toDouble() ?? 0.25,
  blur: (json['blur'] as num?)?.toDouble() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ImageElementPaintToJson(ImageElementPaint instance) =>
    <String, dynamic>{
      'source': instance.source,
      'tint': const ColorJsonConverter().toJson(instance.tint),
      'scale': instance.scale,
      'blur': instance.blur,
      'type': instance.$type,
    };

SvgElementPaint _$SvgElementPaintFromJson(Map json) => SvgElementPaint(
  source: json['source'] as String,
  tint: json['tint'] == null
      ? SRGBColor.white
      : const ColorJsonConverter().fromJson((json['tint'] as num).toInt()),
  scale: (json['scale'] as num?)?.toDouble() ?? 0.25,
  blur: (json['blur'] as num?)?.toDouble() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SvgElementPaintToJson(SvgElementPaint instance) =>
    <String, dynamic>{
      'source': instance.source,
      'tint': const ColorJsonConverter().toJson(instance.tint),
      'scale': instance.scale,
      'blur': instance.blur,
      'type': instance.$type,
    };

GradientElementPaint _$GradientElementPaintFromJson(Map json) =>
    GradientElementPaint(
      gradient: json['gradient'] == null
          ? const ElementGradient.linear()
          : ElementGradient.fromJson(
              Map<String, dynamic>.from(json['gradient'] as Map),
            ),
      blur: (json['blur'] as num?)?.toDouble() ?? 0,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$GradientElementPaintToJson(
  GradientElementPaint instance,
) => <String, dynamic>{
  'gradient': instance.gradient.toJson(),
  'blur': instance.blur,
  'type': instance.$type,
};

LinearElementGradient _$LinearElementGradientFromJson(Map json) =>
    LinearElementGradient(
      start: json['start'] == null
          ? const Point(0, 0)
          : const DoublePointJsonConverter().fromJson(json['start'] as Map),
      end: json['end'] == null
          ? const Point(1, 0)
          : const DoublePointJsonConverter().fromJson(json['end'] as Map),
      stops:
          (json['stops'] as List<dynamic>?)
              ?.map(
                (e) => ElementGradientStop.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList() ??
          defaultGradientStops,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$LinearElementGradientToJson(
  LinearElementGradient instance,
) => <String, dynamic>{
  'start': const DoublePointJsonConverter().toJson(instance.start),
  'end': const DoublePointJsonConverter().toJson(instance.end),
  'stops': instance.stops.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

RadialElementGradient _$RadialElementGradientFromJson(Map json) =>
    RadialElementGradient(
      center: json['center'] == null
          ? const Point(0.5, 0.5)
          : const DoublePointJsonConverter().fromJson(json['center'] as Map),
      radius: (json['radius'] as num?)?.toDouble() ?? 0.5,
      focal: _$JsonConverterFromJson<Map<dynamic, dynamic>, Point<double>>(
        json['focal'],
        const DoublePointJsonConverter().fromJson,
      ),
      focalRadius: (json['focalRadius'] as num?)?.toDouble(),
      stops:
          (json['stops'] as List<dynamic>?)
              ?.map(
                (e) => ElementGradientStop.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList() ??
          defaultGradientStops,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RadialElementGradientToJson(
  RadialElementGradient instance,
) => <String, dynamic>{
  'center': const DoublePointJsonConverter().toJson(instance.center),
  'radius': instance.radius,
  'focal': _$JsonConverterToJson<Map<dynamic, dynamic>, Point<double>>(
    instance.focal,
    const DoublePointJsonConverter().toJson,
  ),
  'focalRadius': instance.focalRadius,
  'stops': instance.stops.map((e) => e.toJson()).toList(),
  'type': instance.$type,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_ElementGradientStop _$ElementGradientStopFromJson(Map json) =>
    _ElementGradientStop(
      offset: (json['offset'] as num?)?.toDouble() ?? 0,
      color: json['color'] == null
          ? SRGBColor.black
          : const ColorJsonConverter().fromJson((json['color'] as num).toInt()),
    );

Map<String, dynamic> _$ElementGradientStopToJson(
  _ElementGradientStop instance,
) => <String, dynamic>{
  'offset': instance.offset,
  'color': const ColorJsonConverter().toJson(instance.color),
};

PenProperty _$PenPropertyFromJson(Map json) => PenProperty(
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  thinning: (json['thinning'] as num?)?.toDouble() ?? 0.4,
  paint: json['paint'] == null
      ? const ElementPaint.solid()
      : ElementPaint.fromJson(Map<String, dynamic>.from(json['paint'] as Map)),
  fillPaint: json['fillPaint'] == null
      ? const ElementPaint.solid(color: SRGBColor.transparent)
      : ElementPaint.fromJson(
          Map<String, dynamic>.from(json['fillPaint'] as Map),
        ),
  smoothing: (json['smoothing'] as num?)?.toDouble() ?? 0.5,
  streamline: (json['streamline'] as num?)?.toDouble() ?? 0.3,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PenPropertyToJson(PenProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'thinning': instance.thinning,
      'paint': instance.paint.toJson(),
      'fillPaint': instance.fillPaint.toJson(),
      'smoothing': instance.smoothing,
      'streamline': instance.streamline,
      'type': instance.$type,
    };

ShapeProperty _$ShapePropertyFromJson(Map json) => ShapeProperty(
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  shape: PathShape.fromJson(Map<String, dynamic>.from(json['shape'] as Map)),
  paint: json['paint'] == null
      ? const ElementPaint.solid()
      : ElementPaint.fromJson(Map<String, dynamic>.from(json['paint'] as Map)),
  strokeStyle:
      $enumDecodeNullable(_$StrokeStyleEnumMap, json['strokeStyle']) ??
      StrokeStyle.solid,
  dashMultiplier: (json['dashMultiplier'] as num?)?.toDouble() ?? 1.0,
  gapMultiplier: (json['gapMultiplier'] as num?)?.toDouble() ?? 1.0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ShapePropertyToJson(ShapeProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'shape': instance.shape.toJson(),
      'paint': instance.paint.toJson(),
      'strokeStyle': _$StrokeStyleEnumMap[instance.strokeStyle]!,
      'dashMultiplier': instance.dashMultiplier,
      'gapMultiplier': instance.gapMultiplier,
      'type': instance.$type,
    };

const _$StrokeStyleEnumMap = {
  StrokeStyle.solid: 'solid',
  StrokeStyle.dotted: 'dotted',
};

PolygonProperty _$PolygonPropertyFromJson(Map json) => PolygonProperty(
  strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 5,
  paint: json['paint'] == null
      ? const ElementPaint.solid()
      : ElementPaint.fromJson(Map<String, dynamic>.from(json['paint'] as Map)),
  fillPaint: json['fillPaint'] == null
      ? const ElementPaint.solid(color: SRGBColor.transparent)
      : ElementPaint.fromJson(
          Map<String, dynamic>.from(json['fillPaint'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PolygonPropertyToJson(PolygonProperty instance) =>
    <String, dynamic>{
      'strokeWidth': instance.strokeWidth,
      'paint': instance.paint.toJson(),
      'fillPaint': instance.fillPaint.toJson(),
      'type': instance.$type,
    };

CircleShape _$CircleShapeFromJson(Map json) => CircleShape(
  fillPaint: json['fillPaint'] == null
      ? const ElementPaint.solid(color: SRGBColor.transparent)
      : ElementPaint.fromJson(
          Map<String, dynamic>.from(json['fillPaint'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CircleShapeToJson(CircleShape instance) =>
    <String, dynamic>{
      'fillPaint': instance.fillPaint.toJson(),
      'type': instance.$type,
    };

RectangleShape _$RectangleShapeFromJson(Map json) => RectangleShape(
  fillPaint: json['fillPaint'] == null
      ? const ElementPaint.solid(color: SRGBColor.transparent)
      : ElementPaint.fromJson(
          Map<String, dynamic>.from(json['fillPaint'] as Map),
        ),
  topLeftCornerRadius: (json['topLeftCornerRadius'] as num?)?.toDouble() ?? 0,
  topRightCornerRadius: (json['topRightCornerRadius'] as num?)?.toDouble() ?? 0,
  bottomLeftCornerRadius:
      (json['bottomLeftCornerRadius'] as num?)?.toDouble() ?? 0,
  bottomRightCornerRadius:
      (json['bottomRightCornerRadius'] as num?)?.toDouble() ?? 0,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RectangleShapeToJson(RectangleShape instance) =>
    <String, dynamic>{
      'fillPaint': instance.fillPaint.toJson(),
      'topLeftCornerRadius': instance.topLeftCornerRadius,
      'topRightCornerRadius': instance.topRightCornerRadius,
      'bottomLeftCornerRadius': instance.bottomLeftCornerRadius,
      'bottomRightCornerRadius': instance.bottomRightCornerRadius,
      'type': instance.$type,
    };

LineShape _$LineShapeFromJson(Map json) =>
    LineShape($type: json['type'] as String?);

Map<String, dynamic> _$LineShapeToJson(LineShape instance) => <String, dynamic>{
  'type': instance.$type,
};

TriangleShape _$TriangleShapeFromJson(Map json) => TriangleShape(
  fillPaint: json['fillPaint'] == null
      ? const ElementPaint.solid(color: SRGBColor.transparent)
      : ElementPaint.fromJson(
          Map<String, dynamic>.from(json['fillPaint'] as Map),
        ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TriangleShapeToJson(TriangleShape instance) =>
    <String, dynamic>{
      'fillPaint': instance.fillPaint.toJson(),
      'type': instance.$type,
    };
