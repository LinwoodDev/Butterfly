import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/models/packs/background.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class LayerContainer extends ElementLayer {
  Color backgroundColor;
  BackgroundPack background;

  @override
  Widget buildTile(BuildContext context, DocumentLoadSuccess state) {
    // TODO: implement buildTile
    throw UnimplementedError();
  }
}
