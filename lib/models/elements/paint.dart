import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class PaintElement extends ElementLayer {
  PaintElement({@required String name, String description})
      : super(name: name, description: description);
  PaintElement.fromJson(Map<String, dynamic> json)
      : super(name: json['name'], description: json['description']);
  @override
  Widget buildTile(BuildContext context, DocumentLoadSuccess state) {
    // TODO: implement buildTile
    return ListTile();
  }
}
