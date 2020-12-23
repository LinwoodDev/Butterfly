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

  LayerContainer({@required String name, String description})
      : super(name: name, description: description);

  LayerContainer.fromJson(Map<String, dynamic> json)
      : backgroundColor = Color(json['backgroundColor']),
        super(name: json['name'], description: json['description']);
}
