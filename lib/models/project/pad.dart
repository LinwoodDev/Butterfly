import 'package:butterfly/models/elements/container.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/elements/type.dart';
import 'package:flutter/foundation.dart';

import 'item.dart';
import 'type.dart';

class PadProjectItem extends ProjectItem {
  ElementLayer root = LayerContainer();

  PadProjectItem({@required String name, String description})
      : super(name: name, description: description);

  PadProjectItem.fromJson(Map<String, dynamic> json)
      : root = LayerType.values
            .firstWhere((element) => element.toString() == json['root']['type'])
            .fromJson(json['root']),
        super(name: json['name'], description: json['description']);
}
