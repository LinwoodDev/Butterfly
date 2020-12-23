import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class GroupElement extends ElementLayer {
  @override
  Widget buildTile(BuildContext context, DocumentLoadSuccess state) => ListTile();
  GroupElement({@required String name, String description})
      : super(name: name, description: description);

  GroupElement.fromJson(Map<String, dynamic> json)
      : super(name: json['name'], description: json['description']);
}
