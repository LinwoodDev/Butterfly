import 'package:butterfly/models/elements/container.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:flutter/foundation.dart';

import 'item.dart';

class PadProjectItem extends ProjectItem {
  ElementLayer root = LayerContainer(name: 'root');

  PadProjectItem({@required String name, String description})
      : super(name: name, description: description);

  PadProjectItem.fromJson(Map<String, dynamic> json)
      : root = ElementLayer.fromJson(json['root']),
        super(name: json['name'], description: json['description']);
}
