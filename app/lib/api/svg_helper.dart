import 'package:flutter/painting.dart';

// HTML color names
const colorNames = <String, Color>{
  'aliceblue': Color(0xFFF0F8FF),
  'antiquewhite': Color(0xFFFAEBD7),
  'aqua': Color(0xFF00FFFF),
  'aquamarine': Color(0xFF7FFFD4),
  'azure': Color(0xFFF0FFFF),
  'beige': Color(0xFFF5F5DC),
  'bisque': Color(0xFFFFE4C4),
  'black': Color(0xFF000000),
  'blanchedalmond': Color(0xFFFFEBCD),
  'blue': Color(0xFF0000FF),
  'blueviolet': Color(0xFF8A2BE2),
  'brown': Color(0xFFA52A2A),
  'burlywood': Color(0xFFDEB887),
  'cadetblue': Color(0xFF5F9EA0),
  'chartreuse': Color(0xFF7FFF00),
  'chocolate': Color(0xFFD2691E),
  'coral': Color(0xFFFF7F50),
  'cornflowerblue': Color(0xFF6495ED),
  'cornsilk': Color(0xFFFFF8DC),
  'crimson': Color(0xFFDC143C),
  'cyan': Color(0xFF00FFFF),
  'darkblue': Color(0xFF00008B),
  'darkcyan': Color(0xFF008B8B),
  'darkgoldenrod': Color(0xFFB8860B),
  'darkgray': Color(0xFFA9A9A9),
  'darkgreen': Color(0xFF006400),
  'darkgrey': Color(0xFFA9A9A9),
  'darkkhaki': Color(0xFFBDB76B),
  'darkmagenta': Color(0xFF8B008B),
  'darkolivegreen': Color(0xFF556B2F),
  'darkorange': Color(0xFFFF8C00),
  'darkorchid': Color(0xFF9932CC),
  'darkred': Color(0xFF8B0000),
  'darksalmon': Color(0xFFE9967A),
  'darkseagreen': Color(0xFF8FBC8F),
  'darkslateblue': Color(0xFF483D8B),
  'darkslategray': Color(0xFF2F4F4F),
  'darkslategrey': Color(0xFF2F4F4F),
  'darkturquoise': Color(0xFF00CED1),
  'darkviolet': Color(0xFF9400D3),
  'deeppink': Color(0xFFFF1493),
  'deepskyblue': Color(0xFF00BFFF),
  'dimgray': Color(0xFF696969),
  'dimgrey': Color(0xFF696969),
  'dodgerblue': Color(0xFF1E90FF),
  'firebrick': Color(0xFFB22222),
  'floralwhite': Color(0xFFFFFAF0),
  'forestgreen': Color(0xFF228B22),
  'fuchsia': Color(0xFFFF00FF),
  'gainsboro': Color(0xFFDCDCDC),
  'ghostwhite': Color(0xFFF8F8FF),
  'gold': Color(0xFFFFD700),
  'goldenrod': Color(0xFFDAA520),
  'gray': Color(0xFF808080),
  'green': Color(0xFF008000),
  'greenyellow': Color(0xFFADFF2F),
  'grey': Color(0xFF808080),
  'honeydew': Color(0xFFF0FFF0),
  'hotpink': Color(0xFFFF69B4),
  'indianred': Color(0xFFCD5C5C),
  'indigo': Color(0xFF4B0082),
  'ivory': Color(0xFFFFFFF0),
  'khaki': Color(0xFFF0E68C),
  'lavender': Color(0xFFE6E6FA),
  'lavenderblush': Color(0xFFFFF0F5),
  'lawngreen': Color(0xFF7CFC00),
  'lemonchiffon': Color(0xFFFFFACD),
  'lightblue': Color(0xFFADD8E6),
  'lightcoral': Color(0xFFF08080),
  'lightcyan': Color(0xFFE0FFFF),
  'lightgoldenrodyellow': Color(0xFFFAFAD2),
  'lightgray': Color(0xFFD3D3D3),
  'lightgreen': Color(0xFF90EE90),
  'lightgrey': Color(0xFFD3D3D3),
  'lightpink': Color(0xFFFFB6C1),
  'lightsalmon': Color(0xFFFFA07A),
  'lightseagreen': Color(0xFF20B2AA),
  'lightskyblue': Color(0xFF87CEFA),
  'lightslategray': Color(0xFF778899),
  'lightslategrey': Color(0xFF778899),
  'lightsteelblue': Color(0xFFB0C4DE),
  'lightyellow': Color(0xFFFFFFE0),
  'lime': Color(0xFF00FF00),
  'limegreen': Color(0xFF32CD32),
  'linen': Color(0xFFFAF0E6),
  'magenta': Color(0xFFFF00FF),
  'maroon': Color(0xFF800000),
  'mediumaquamarine': Color(0xFF66CDAA),
  'mediumblue': Color(0xFF0000CD),
  'mediumorchid': Color(0xFFBA55D3),
  'mediumpurple': Color(0xFF9370DB),
  'mediumseagreen': Color(0xFF3CB371),
  'mediumslateblue': Color(0xFF7B68EE),
  'mediumspringgreen': Color(0xFF00FA9A),
  'mediumturquoise': Color(0xFF48D1CC),
  'mediumvioletred': Color(0xFFC71585),
  'midnightblue': Color(0xFF191970),
  'mintcream': Color(0xFFF5FFFA),
  'mistyrose': Color(0xFFFFE4E1),
  'moccasin': Color(0xFFFFE4B5),
  'navajowhite': Color(0xFFFFDEAD),
  'navy': Color(0xFF000080),
  'oldlace': Color(0xFFFDF5E6),
  'olive': Color(0xFF808000),
  'olivedrab': Color(0xFF6B8E23),
  'orange': Color(0xFFFFA500),
  'orangered': Color(0xFFFF4500),
  'orchid': Color(0xFFDA70D6),
  'palegoldenrod': Color(0xFFEEE8AA),
  'palegreen': Color(0xFF98FB98),
  'paleturquoise': Color(0xFFAFEEEE),
  'palevioletred': Color(0xFFDB7093),
  'papayawhip': Color(0xFFFFEFD5),
  'peachpuff': Color(0xFFFFDAB9),
  'peru': Color(0xFFCD853F),
  'pink': Color(0xFFFFC0CB),
  'plum': Color(0xFFDDA0DD),
  'powderblue': Color(0xFFB0E0E6),
  'purple': Color(0xFF800080),
  'red': Color(0xFFFF0000),
  'rosybrown': Color(0xFFBC8F8F),
  'royalblue': Color(0xFF4169E1),
  'saddlebrown': Color(0xFF8B4513),
  'salmon': Color(0xFFFA8072),
  'sandybrown': Color(0xFFF4A460),
  'seagreen': Color(0xFF2E8B57),
  'seashell': Color(0xFFFFF5EE),
  'sienna': Color(0xFFA0522D),
  'silver': Color(0xFFC0C0C0),
  'skyblue': Color(0xFF87CEEB),
  'slateblue': Color(0xFF6A5ACD),
  'slategray': Color(0xFF708090),
  'slategrey': Color(0xFF708090),
  'snow': Color(0xFFFFFAFA),
  'springgreen': Color(0xFF00FF7F),
  'steelblue': Color(0xFF4682B4),
  'tan': Color(0xFFD2B48C),
  'teal': Color(0xFF008080),
  'thistle': Color(0xFFD8BFD8),
  'transparent': Color(0x00000000),
  'tomato': Color(0xFFFF6347),
  'turquoise': Color(0xFF40E0D0),
  'violet': Color(0xFFEE82EE),
  'wheat': Color(0xFFF5DEB3),
  'white': Color(0xFFFFFFFF),
  'whitesmoke': Color(0xFFF5F5F5),
  'yellow': Color(0xFFFFFF00),
  'yellowgreen': Color(0xFF9ACD32),
};
Color stringToColor(String text) {
  text = text.toLowerCase();
  text = text.trim();
  if (colorNames.containsKey(text)) {
    return colorNames[text]!;
  }
  if (text.startsWith('#')) {
    text = text.substring(1);
  }
  if (text.startsWith('rgba')) {
    return parseRgba(text);
  }
  if (text.startsWith('rgb')) {
    return parseRgb(text);
  }
  if (text.length == 6) {
    text = 'ff' + text;
  }
  if (text.length == 3) {
    var r = text[0];
    var g = text[1];
    var b = text[2];
    text = 'ff$r$r$g$g$b$b';
  }
  if (text.length != 8) {
    throw ArgumentError('Color hex must be either 3, 6, or 8 characters long');
  }
  return Color(int.parse(text.substring(0, 6), radix: 16) + 0xFF000000);
}

Color parseRgba(String text) {
  var parts = text.split(',');
  if (parts.length != 4) {
    throw ArgumentError('Invalid rgba color');
  }
  var r = double.parse(parts[1]);
  var g = double.parse(parts[2]);
  var b = double.parse(parts[3]);
  var a = double.parse(parts[4]);
  return Color.fromARGB(a.round(), r.round(), g.round(), b.round());
}

Color parseRgb(String text) {
  var parts = text.split(',');
  if (parts.length != 3) {
    throw ArgumentError('Invalid rgb color');
  }
  var r = double.parse(parts[1]);
  var g = double.parse(parts[2]);
  var b = double.parse(parts[3]);
  return Color.fromARGB(255, r.round(), g.round(), b.round());
}
