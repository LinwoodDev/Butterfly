import 'package:butterfly/models/elements/document.dart';
import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/material/list_tile.dart';

class LayerContainer extends ElementLayer {
  Color backgroundColor;
  BackgroundPack background;

  @override
  ListTile buildTile(BuildContext context, AppDocument document) {
    // TODO: implement buildTile
    throw UnimplementedError();
  }
}
