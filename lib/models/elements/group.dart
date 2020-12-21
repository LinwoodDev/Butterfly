import 'package:butterfly/models/elements/layer.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class GroupElement extends ElementLayer {
  @override
  Widget buildTile(BuildContext context, DocumentLoadSuccess state) => ListTile();
}
