import 'package:butterfly/models/elements/type.dart';
import 'package:butterfly/models/packs/background.dart';
import 'package:flutter/material.dart';

class LayerContainer extends ElementLayer {
  Color backgroundColor;
  BackgroundPack background;

  LayerContainer({@required String name, String description})
      : super(name: name, description: description);

  LayerContainer.fromJson(Map<String, dynamic> json)
      : backgroundColor = Color(json['backgroundColor']),
        super(name: json['name'], description: json['description']);

  @override
  LayerType get type => LayerType.container;
}
