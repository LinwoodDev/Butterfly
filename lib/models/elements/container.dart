import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/background.dart';
import 'package:flutter/material.dart';

import '../document.dart';

class LayerContainer extends ElementLayer {
  Color backgroundColor;
  BackgroundPack background;

  @override
  Widget buildTile(BuildContext context, AppDocument document) {
    // TODO: implement buildTile
    throw UnimplementedError();
  }
}
