import 'package:flutter/painting.dart';

import 'element.dart';

class LabelElement extends ElementLayer {
  String? text;
  int size = 12;
  LabelElement();
  LabelElement.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        size = json['size'];
  @override
  Map<String, dynamic> toJson() => {'text': text, 'size': size, 'type': 'label'};

  @override
  bool hit(Offset offset) => false;
}
