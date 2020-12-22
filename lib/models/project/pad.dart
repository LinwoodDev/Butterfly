import 'package:butterfly/models/elements/container.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:flutter/foundation.dart';

import 'item.dart';
import 'type.dart';

class PadProjectItem extends ProjectItem {
  ElementLayer root = LayerContainer();

  PadProjectItem({@required String name, String description})
      : super(name: name, description: description);

  static ProjectItem fromJson(Map<String, dynamic> json) {}
}
