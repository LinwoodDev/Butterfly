import 'package:butterfly/models/elements/type.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class GroupElement extends ElementLayer {
  @override
  IconData get icon => Mdi.group;

  GroupElement({@required String name, String description})
      : super(name: name, description: description);

  GroupElement.fromJson(Map<String, dynamic> json)
      : super(name: json['name'], description: json['description']);

  @override
  LayerType get type => LayerType.group;
}
