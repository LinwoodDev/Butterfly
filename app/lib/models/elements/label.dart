part of 'element.dart';

class LabelElement extends PositionedElement {
  final String text;
  final LabelProperty property;

  const LabelElement(
      {String layer = '',
      this.text = '',
      Offset position = Offset.zero,
      this.property = const LabelProperty()})
      : super(layer: layer, position: position);

  LabelElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : text = json['text'] ?? '',
        property = LabelProperty.fromJson(json),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'text': text,
      }
        ..addAll(property.toJson())
        ..addAll(super.toJson());

  @override
  bool hit(Offset offset, [double radius = 1]) {
    var tp = _createPainter();
    tp.layout();
    var rect = Rect.fromLTWH(position.dx - radius, position.dy - radius,
        tp.width + radius * 2, tp.height + radius * 2);
    return rect.contains(offset);
  }

  @override
  LabelElement copyWith(
          {String? layer,
          String? text,
          LabelProperty? property,
          Offset? position}) =>
      LabelElement(
          layer: layer ?? this.layer,
          text: text ?? this.text,
          property: property ?? this.property,
          position: position ?? this.position);

  @override
  void paint(Canvas canvas, [bool preview = false]) {
    var tp = _createPainter();
    tp.layout();
    var current = position;
    tp.paint(canvas, current);
  }

  TextPainter _createPainter() => TextPainter(
      text: TextSpan(
          style: TextStyle(
              fontSize: property.size,
              fontStyle: property.italic ? FontStyle.italic : FontStyle.normal,
              color: property.color,
              fontWeight: property.fontWeight,
              letterSpacing: property.letterSpacing,
              decorationColor: property.decorationColor,
              decorationStyle: property.decorationStyle,
              decorationThickness: property.decorationThickness,
              decoration: TextDecoration.combine([
                if (property.underline) TextDecoration.underline,
                if (property.lineThrough) TextDecoration.lineThrough,
                if (property.overline) TextDecoration.overline,
              ])),
          text: text),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textScaleFactor: 1.0);

  @override
  Rect get rect {
    var tp = _createPainter();
    tp.layout();
    return Rect.fromLTWH(position.dx, position.dy, tp.width, tp.height);
  }

  @override
  LabelElement moveBy(Offset offset) {
    return copyWith(position: position + offset);
  }

  @override
  ElementType get type => ElementType.label;
}
