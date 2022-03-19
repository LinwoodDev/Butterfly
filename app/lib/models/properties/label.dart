part of 'property.dart';

class LabelProperty {
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final bool lineThrough, underline, overline, italic;
  final Color decorationColor;
  final TextDecorationStyle decorationStyle;
  final double decorationThickness;
  final double letterSpacing;

  const LabelProperty(
      {this.size = 12,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.lineThrough = false,
      this.underline = false,
      this.overline = false,
      this.italic = false,
      this.letterSpacing = 0,
      this.decorationColor = Colors.black,
      this.decorationStyle = TextDecorationStyle.solid,
      this.decorationThickness = 1});

  LabelProperty.fromJson(Map<String, dynamic> json)
      : size = json['size'] ?? 12,
        letterSpacing = json['letterSpacing'] ?? 0,
        color = json['color'] == null ? Colors.black : Color(json['color']),
        fontWeight = json['fontWeight'] != null
            ? FontWeight.values[json['fontWeight']]
            : FontWeight.normal,
        lineThrough = json['lineThrough'] ?? false,
        underline = json['underline'] ?? false,
        overline = json['overline'] ?? false,
        italic = json['italic'] ?? false,
        decorationColor = json['decorationColor'] != null
            ? Color(json['decorationColor'])
            : Colors.black,
        decorationStyle = json['decorationStyle'] != null
            ? TextDecorationStyle.values[json['decorationStyle']]
            : TextDecorationStyle.solid,
        decorationThickness = json['decorationThickness'] ?? 1;

  Map<String, dynamic> toJson() => {
        'fontWeight': FontWeight.values.indexOf(fontWeight),
        'lineThrough': lineThrough,
        'underline': underline,
        'overline': overline,
        'italic': italic,
        'decorationColor': decorationColor.value,
        'decorationStyle': decorationStyle.index,
        'decorationThickness': decorationThickness,
        'letterSpacing': letterSpacing,
        'size': size,
        'color': color.value
      };

  LabelProperty copyWith(
          {Color? color,
          double? size,
          FontWeight? fontWeight,
          bool? lineThrough,
          bool? underline,
          bool? overline,
          bool? italic,
          Color? decorationColor,
          TextDecorationStyle? decorationStyle,
          double? decorationThickness,
          double? letterSpacing}) =>
      LabelProperty(
          color: color ?? this.color,
          size: size ?? this.size,
          fontWeight: fontWeight ?? this.fontWeight,
          lineThrough: lineThrough ?? this.lineThrough,
          underline: underline ?? this.underline,
          overline: overline ?? this.overline,
          italic: italic ?? this.italic,
          decorationColor: decorationColor ?? this.decorationColor,
          decorationStyle: decorationStyle ?? this.decorationStyle,
          decorationThickness: decorationThickness ?? this.decorationThickness,
          letterSpacing: letterSpacing ?? this.letterSpacing);
}
