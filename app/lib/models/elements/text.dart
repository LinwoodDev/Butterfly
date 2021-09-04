import 'element.dart';

class TextElement extends ElementLayer {
  String? text;
  int size = 12;
  TextElement();
  TextElement.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        size = json['size'];
  @override
  Map<String, dynamic> toJson() => {'text': text, 'size': size, 'type': 'text'};
}
