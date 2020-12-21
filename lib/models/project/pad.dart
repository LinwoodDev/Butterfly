import 'package:butterfly/models/elements/container.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/collection.dart';
import 'package:flutter/foundation.dart';

import 'item.dart';

class PadProjectItem extends ProjectItem {
  final ElementLayer root = LayerContainer();

  PadProjectItem({@required String name, String description})
      : super(name: name, description: description);
}
